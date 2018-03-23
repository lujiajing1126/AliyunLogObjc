//
//  Serializer.m
//  AliyunLogObjc
//
//  Created by 陆家靖 on 23/03/2018.
//  Copyright © 2018 陆家靖. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RawLogGroup;

typedef NS_ENUM(NSInteger, AliSLSSerializer) {
    AliSLSJSONSerializer,
    AliSLSProtobufSerializer
};

@protocol SerializerProtocol
- (NSData *) serialize: (RawLogGroup *) group;
@end
