//
//  Log.m
//  AliyunLogObjc
//
//  Created by 陆家靖 on 2016/10/27.
//  Copyright © 2016年 陆家靖. All rights reserved.
//

#import "Log.h"

@implementation Log

-(id)init {
    if(self = [super init]) {
        _mContent = [[NSMutableDictionary alloc] init];
        NSTimeInterval epoch = [[[NSDate alloc] init] timeIntervalSince1970];
        NSNumber *epochNumber = [[NSNumber alloc]initWithLong:epoch];
        [_mContent setValue: epochNumber forKey:@"__time__"];
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

-(void)PutTime:(int)time {
    if ( time > [[[NSDate alloc] init] timeIntervalSince1970]) {
        [_mContent setValue:[[NSNumber alloc] initWithInt:time] forKey:@"__time__"];
    }
}

-(NSDictionary<NSString*,NSObject*> *)GetContent {
    return _mContent;
}

-(NSUInteger)GetContentCount {
    return [_mContent count];
}

@end

