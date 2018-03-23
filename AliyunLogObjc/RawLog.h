//
//  Log.h
//  AliyunLogObjc
//
//  Created by 陆家靖 on 2016/10/27.
//  Copyright © 2016年 陆家靖. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef RawLog_h
#define RawLog_h

@interface RawLog : NSObject {
    NSMutableDictionary<NSString *,NSString *> *_mContent;
    NSNumber *_time;
}

-(void)PutContent: (NSString *)value withKey:(NSString *) key;
-(void)PutTime: (NSInteger) time;
-(NSNumber *)GetTime;
-(NSDictionary<NSString *,NSString *> *)GetContent;
-(NSUInteger)GetContentCount;

@end

#endif /* RawLog_h */
