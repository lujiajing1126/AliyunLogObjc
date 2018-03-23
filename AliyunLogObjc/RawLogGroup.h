//
//  LogGroup.h
//  AliyunLogObjc
//
//  Created by 陆家靖 on 2016/10/27.
//  Copyright © 2016年 陆家靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Serializer.h"
@class RawLog;

#ifndef RawLogGroup_h
#define RawLogGroup_h

@interface RawLogGroup : NSObject {
    NSString *_mTopic;
    NSString *_mSource;
    NSMutableArray<RawLog *> *_rawLogs;
}

- (id)initWithTopic: (NSString *) topic andSource:(NSString *) source;
- (NSString *)GetTopic;
- (NSString *)GetSource;
- (NSMutableArray<RawLog *> *)GetLogs;
- (void)PutTopic: (NSString *)topic;
- (void)PutSource: (NSString *)source;
- (void)PutLog: (RawLog *)log;
- (NSData *)serialize: (AliSLSSerializer) serdeType;

@end


#endif /* RawLogGroup_h */
