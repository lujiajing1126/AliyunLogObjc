//
//  LogClient.h
//  AliyunLogObjc
//
//  Created by 陆家靖 on 2016/10/27.
//  Copyright © 2016年 陆家靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Serializer.h"
@class LogGroup;

#ifndef LogClient_h
#define LogClient_h

@interface LogClient : NSObject {
    NSString *_mEndPoint;
    NSString *_mAccessKeyID;
    NSString *_mAccessKeySecret;
    NSString *_mProject;
    NSString *_mAccessToken;
    AliSLSSerializer _sType;
}

- (id)initWithApp:(NSString*) endPoint accessKeyID:(NSString *)ak accessKeySecret: (NSString *)as projectName: (NSString *)name serializeType: (AliSLSSerializer) sType;

- (void)SetToken: (NSString*) token;
- (NSString*)GetToken;
- (NSString*)GetEndPoint;
- (NSString*)GetKeyID;
- (NSString*)GetKeySecret;
- (void)PostLog: (RawLogGroup*)logGroup logStoreName:(NSString*)name call:(void (^)(NSURLResponse* _Nullable response,NSError* _Nullable error) )errorCallback;

@end

#endif /* LogClient_h */
