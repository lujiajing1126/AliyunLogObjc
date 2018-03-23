//
//  Log.m
//  AliyunLogObjc
//
//  Created by 陆家靖 on 2016/10/27.
//  Copyright © 2016年 陆家靖. All rights reserved.
//

#import "RawLog.h"

@implementation RawLog

-(id)init {
    if(self = [super init]) {
        _mContent = [[NSMutableDictionary alloc] init];
        NSTimeInterval epoch = [[[NSDate alloc] init] timeIntervalSince1970];
        _time = [[NSNumber alloc] initWithLong:epoch];
    }
    return self;
}

-(void)PutContent:(NSString *)value withKey:(NSString *) key {
    if (key == nil || [key isEqualToString: @""]) {
        return;
    }
    if (value == nil || [value isEqualToString:@""]) {
        return;
    }
    [_mContent setValue:value forKey:key];
}

-(void)PutTime:(NSInteger) time {
    _time = [[NSNumber alloc] initWithLong: time];
}

-(NSNumber *)GetTime {
    return _time;
}

-(NSDictionary<NSString*,NSString*> *) GetContent {
    return _mContent;
}

-(NSUInteger) GetContentCount {
    return [_mContent count];
}

@end

