//
//  ProtobufSerializer.m
//  AliyunLogObjc
//
//  Created by 陆家靖 on 23/03/2018.
//  Copyright © 2018 陆家靖. All rights reserved.
//

#import "ProtobufSerializer.h"
#import "Sls.pbobjc.h"
#import "RawLogGroup.h"
#import "RawLog.h"

@implementation ProtobufSerializer

+ (id) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSData *) serialize: (RawLogGroup *) rawGroup {
    LogGroup *logGroup = [[LogGroup alloc] init];
    [logGroup setTopic: [rawGroup GetTopic]];
    [logGroup setSource: [rawGroup GetSource]];
    NSMutableArray<Log *> *logs = [[NSMutableArray alloc] init];
    NSArray<RawLog *> *rawLogs = [rawGroup GetLogs];
    for (NSUInteger i=0; i < [rawLogs count]; i++) {
        RawLog *rawLog = [rawLogs objectAtIndex: i];
        Log *log = [[Log alloc] init];
        [log setTime: [[rawLog GetTime] unsignedIntValue]];
        NSDictionary<NSString *, NSString *> *dict = [rawLog GetContent];
        for (NSString* key in dict) {
            Log_Content *logContent = [[Log_Content alloc] init];
            [logContent setKey: key];
            [logContent setValue: [dict objectForKey:key]];
            [[log contentsArray] addObject: logContent];
        }
        [logs addObject:log];
    }
    [logGroup setLogsArray: logs];
    return [logGroup data];
}

@end
