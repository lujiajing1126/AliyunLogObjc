//
//  LogGroup.h
//  AliyunLogObjc
//
//  Created by 陆家靖 on 2016/10/27.
//  Copyright © 2016年 陆家靖. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Log;

#ifndef LogGroup_h
#define LogGroup_h

@interface LogGroup : NSObject {
    NSString *_mTopic;
    NSString *_mSource;
    NSMutableArray<NSDictionary<NSString*,NSObject*>*> *_mContent;
}

- (id)initWithTopic: (NSString *) topic andSource:(NSString *) source;
- (void)PutTopic: (NSString *)topic;
- (void)PutSource: (NSString *)source;
- (void)PutLog: (Log *)log;
- (NSString *)GetJsonPackage;

@end


#endif /* LogGroup_h */
