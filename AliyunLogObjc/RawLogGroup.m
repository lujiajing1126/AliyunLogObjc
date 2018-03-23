//
//  LogGroup.m
//  AliyunLogObjc
//
//  Created by 陆家靖 on 2016/10/27.
//  Copyright © 2016年 陆家靖. All rights reserved.
//

#import "RawLogGroup.h"
#import "RawLog.h"
#import "JSONSerializer.h"
#import "ProtobufSerializer.h"

@implementation RawLogGroup

- (id)initWithTopic: (NSString *) topic andSource:(NSString *) source {
    if(self = [super init]) {
        _mTopic = topic;
        _mSource = source;
        _rawLogs = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)PutTopic: (NSString *)topic {
    _mTopic = topic;
}

- (void)PutSource: (NSString *)source {
    _mSource = source;
}

- (void)PutLog: (RawLog *)log {
    [_rawLogs addObject:log];
}

- (NSData *) serialize: (AliSLSSerializer) serdeType {
    if (serdeType == AliSLSJSONSerializer) {
        return [(JSONSerializer*)[JSONSerializer sharedInstance] serialize: self];
    } else {
        return [(ProtobufSerializer*)[ProtobufSerializer sharedInstance] serialize: self];;
    }
}

- (NSString *) GetTopic {
    return _mTopic;
}

- (NSString *) GetSource {
    return _mSource;
}

- (NSArray<RawLog *> *) GetLogs {
    return _rawLogs;
}

@end
