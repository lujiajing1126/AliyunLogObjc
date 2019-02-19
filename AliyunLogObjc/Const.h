//
//  Const.h
//  AliyunLogObjc
//
//  Created by 陆家靖 on 2016/10/27.
//  Copyright © 2016年 陆家靖. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Const_h
#define Const_h

#define SDK_VERSION 1.1.7
#define POST_VALUE_LOG_UA @"AliyunLogClientObjc/1.1.6.20180508"

#define HTTP_DATE_FORMAT @"EEE, dd MMM yyyy HH:mm:ss"

#define KEY_HOST @"Host"
#define KEY_TIME @"__time__"
#define KEY_TOPIC @"__topic__"
#define KEY_SOURCE @"__source__"
#define KEY_LOGS @"__logs__"

#define KEY_DATE @"Date"

#define KEY_CONTENT_LENGTH @"Content-Length"
#define KEY_CONTENT_MD5 @"Content-MD5"
#define KEY_CONTENT_TYPE @"Content-Type"

#define KEY_LOG_APIVERSION @"x-log-apiversion"
#define KEY_LOG_BODYRAWSIZE @"x-log-bodyrawsize"
#define KEY_LOG_COMPRESSTYPE @"x-log-compresstype"
#define KEY_LOG_SIGNATUREMETHOD @"x-log-signaturemethod"
#define KEY_LOG_CLIENT @"User-Agent"

#define KEY_ACS_SECURITY_TOKEN @"x-acs-security-token"
#define KEY_AUTHORIZATION @"Authorization"

#define POST_VALUE_LOG_APIVERSION @"0.6.0"
#define POST_VALUE_LOG_COMPRESSTYPE @"deflate"
#define POST_VALUE_LOG_JSON_CONTENT_TYPE @"application/json"
#define POST_VALUE_LOG_PB_CONTENT_TYPE @"application/x-protobuf"
#define POST_VALUE_LOG_SIGNATUREMETHOD @"hmac-sha1"


#define POST_METHOD_NAME @"POST"

#define TOKEN_EXPIRE_TIME  60 * 15 //15min

#endif /* Const_h */
