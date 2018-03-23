//
//  LogClient.m
//  AliyunLogObjc
//
//  Created by 陆家靖 on 2016/10/27.
//  Copyright © 2016年 陆家靖. All rights reserved.
//

#import "LogClient.h"
#import "RawLogGroup.h"
#import "Const.h"
#import "NSData+MD5Digest.h"
#import "NSData+GZIP.h"
#import "NSString+Crypto.h"

@implementation LogClient

- (id)initWithApp:(NSString*) endPoint accessKeyID:(NSString *)ak accessKeySecret: (NSString *)as projectName: (NSString *)name serializeType: (AliSLSSerializer) sType {
    if(self = [super init]) {
        if([[endPoint lowercaseString] hasPrefix:@"http://"]) {
            _mEndPoint = [endPoint substringFromIndex:7];
        } else if([[endPoint lowercaseString] hasPrefix:@"https://"]) {
            _mEndPoint = [endPoint substringFromIndex:8];
        } else {
            _mEndPoint = endPoint;
        }
        _mAccessKeyID = ak;
        _mAccessKeySecret = as;
        _mProject = name;
        _sType = sType;
    }
    return self;
}

- (void)SetToken: (NSString*) token {
    if(token == nil || [token isEqualToString: @""]) {
        return;
    }
    _mAccessToken = token;
}
- (NSString*)GetToken {
    return _mAccessToken;
}
- (NSString*)GetEndPoint {
    return _mEndPoint;
}
- (NSString*)GetKeyID {
    return _mAccessKeyID;
}
- (NSString*)GetKeySecret {
    return _mAccessKeySecret;
}

- (void)PostLog:(RawLogGroup*)logGroup logStoreName:(NSString*)name call:(void (^)(NSURLResponse* _Nullable response,NSError* _Nullable error) )errorCallback {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Force to use https api interface
        // Due to the requirement of Apple Security Policy after Jan. 1st, 2017
        NSString *httpUrl = [NSString stringWithFormat:@"https://%@.%@/logstores/%@/shards/lb",_mProject,_mEndPoint,name];
        NSData *httpPostBody = [logGroup serialize: _sType];
        NSData *httpPostBodyZipped = [httpPostBody gzippedData];
        
        NSDictionary<NSString*,NSString*>* httpHeaders = [self GetHttpHeadersFrom:name url:httpUrl body:httpPostBody bodyZipped:httpPostBodyZipped];
        
        [self HttpPostRequest: httpUrl withHeaders:httpHeaders andBody:httpPostBodyZipped callback:errorCallback];
    });
}

- (NSDictionary<NSString*,NSString*>*)GetHttpHeadersFrom:(NSString*)logstore url:(NSString*)url body:(NSData*)body bodyZipped:(NSData*)bodyZipped {
    NSMutableDictionary<NSString*,NSString*> *headers = [[NSMutableDictionary alloc] init];
    [headers setValue:POST_VALUE_LOG_APIVERSION forKey:KEY_LOG_APIVERSION];
    [headers setValue:POST_VALUE_LOG_SIGNATUREMETHOD forKey:KEY_LOG_SIGNATUREMETHOD];
    [headers setValue:POST_VALUE_LOG_UA forKey: KEY_LOG_CLIENT];
    if (_sType == AliSLSJSONSerializer) {
        [headers setValue:POST_VALUE_LOG_JSON_CONTENT_TYPE forKey:KEY_CONTENT_TYPE];
    } else {
        [headers setValue:POST_VALUE_LOG_PB_CONTENT_TYPE forKey:KEY_CONTENT_TYPE];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = HTTP_DATE_FORMAT;
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:[NSDate date]];
    [headers setValue:[NSString stringWithFormat:@"%@ GMT",timeStamp] forKey:KEY_DATE];
    [headers setValue:[bodyZipped MD5HexDigest] forKey:KEY_CONTENT_MD5];
    
    [headers setValue:[NSString stringWithFormat:@"%lu",[bodyZipped length]] forKey:KEY_CONTENT_LENGTH];
    [headers setValue:[NSString stringWithFormat:@"%lu",[body length]] forKey:KEY_LOG_BODYRAWSIZE];
    [headers setValue:POST_VALUE_LOG_COMPRESSTYPE forKey:KEY_LOG_COMPRESSTYPE];
    [headers setValue:[self getHostIn:url] forKey:KEY_HOST];
    
    NSString *signString = [NSString stringWithFormat:@"POST\n%@\n%@\n%@\n", [headers valueForKey:KEY_CONTENT_MD5],[headers valueForKey:KEY_CONTENT_TYPE],[headers valueForKey:KEY_DATE]];
    if(_mAccessToken != nil) {
        [headers setValue:_mAccessToken forKey:KEY_ACS_SECURITY_TOKEN];
        signString = [signString stringByAppendingFormat: @"x-acs-security-token:%@\n", [headers valueForKey:KEY_ACS_SECURITY_TOKEN]];
    }
    
    signString = [signString stringByAppendingFormat:@"x-log-apiversion:%@\n",POST_VALUE_LOG_APIVERSION];
    signString = [signString stringByAppendingFormat:@"x-log-bodyrawsize:%@\n",[headers valueForKey:KEY_LOG_BODYRAWSIZE]];
    signString = [signString stringByAppendingFormat:@"x-log-compresstype:%@\n",POST_VALUE_LOG_COMPRESSTYPE];
    signString = [signString stringByAppendingFormat:@"x-log-signaturemethod:%@\n",POST_VALUE_LOG_SIGNATUREMETHOD];
    signString = [signString stringByAppendingFormat:@"/logstores/%@/shards/lb",logstore];
    
    NSString *sign = [signString SHA1WithSecret:_mAccessKeySecret];
    
    [headers setValue:[NSString stringWithFormat: @"LOG %@:%@",_mAccessKeyID,sign] forKey:KEY_AUTHORIZATION];
    return headers;
}

-(void)HttpPostRequest: (NSString*)url withHeaders:(NSDictionary<NSString*,NSString*>*)headers andBody:(NSData*)body callback:(void (^)(NSURLResponse* _Nullable response,NSError* _Nullable error)) call {
    NSURL *httpUrl = [NSURL URLWithString: url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:60];
    [request setHTTPBody:body];
    [request setHTTPShouldHandleCookies:FALSE];
    for(NSString *key in headers.allKeys) {
        [request setValue:[headers valueForKey:key] forHTTPHeaderField:key];
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(response != nil) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            if(httpResponse.statusCode != 200) {
                NSError *jsonErr = nil;
                NSDictionary<NSString*,NSObject*> *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonErr];
                if(jsonErr == nil) {
                    NSLog(@"Result: %@",[jsonResult description]);
                } else {
                    NSLog(@"%@",[jsonErr localizedDescription]);
                }
            } else {
                NSLog(@"%@",[error localizedDescription]);
            }
        } else {
            NSLog(@"Invalid address: %@",url);
        }
        call(response,error);
    }];
    [task resume];
    [session finishTasksAndInvalidate];
}

-(NSString *)getHostIn: (NSString*) url {
    return [NSURL URLWithString:url].host;
}

@end
