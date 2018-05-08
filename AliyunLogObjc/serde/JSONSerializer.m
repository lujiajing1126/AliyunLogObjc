//
//  JSONSerializer.m
//  AliyunLogObjc
//
//  Created by 陆家靖 on 23/03/2018.
//  Copyright © 2018 陆家靖. All rights reserved.
//

#import "JSONSerializer.h"
#import "RawLogGroup.h"
#import "RawLog.h"
#import "Const.h"

@implementation JSONSerializer

+ (id) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSData *) serialize: (RawLogGroup *) group {
    NSMutableDictionary<NSString*,NSObject*> *package = [[NSMutableDictionary alloc] init];
    [package setValue: [group GetTopic] forKey: KEY_TOPIC];
    [package setValue: [group GetSource] forKey: KEY_SOURCE];
    NSArray<RawLog *> *rawLogs = [group GetLogs];
    NSMutableArray<NSDictionary<NSString *, NSObject *> *> *contents = [[NSMutableArray alloc] init];
    for (int i = 0; i < [rawLogs count]; i++) {
        NSMutableDictionary<NSString *, NSObject *> *rawLog = [[NSMutableDictionary alloc] init];
        NSDictionary<NSString*,NSString*> * logKeyPairs = [[rawLogs objectAtIndex: i] GetContent];
        for (NSString* key in logKeyPairs) {
            [rawLog setValue: [logKeyPairs objectForKey:key] forKey: key];
        }
        [rawLog setValue: [[rawLogs objectAtIndex:i] GetTime] forKey: KEY_TIME];
        [contents addObject: rawLog];
    }
    [package setValue: contents forKey: KEY_LOGS];
    NSError *e = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:package options:NSJSONWritingPrettyPrinted error: &e];
    if(e) {
        return [[NSData alloc] init];
    }
    return data;
}

@end
