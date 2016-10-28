//
//  NSString+Crypto.m
//  AliyunLogObjc
//
//  Created by 陆家靖 on 2016/10/28.
//  Copyright © 2016年 陆家靖. All rights reserved.
//

#import "NSString+Crypto.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Crypto)

-(NSString *)SHA1WithSecret:(NSString *)secret {
    const char *cKey   = [secret cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData  = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC   = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    NSString *hash = [HMAC base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    return hash;
}

@end
