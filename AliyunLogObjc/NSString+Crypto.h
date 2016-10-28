//
//  NSString+Crypto.h
//  AliyunLogObjc
//
//  Created by 陆家靖 on 2016/10/28.
//  Copyright © 2016年 陆家靖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Crypto)

/**
 *  Calculates the SHA1 with the given secret
 *
 *  @param secret The secret used
 *
 *  @return The SHA1 hashed string
 */
- (NSString *)SHA1WithSecret:(NSString *)secret;

@end
