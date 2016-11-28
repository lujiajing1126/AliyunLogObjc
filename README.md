# AliyunLogObjc

> [Aliyun Sls](https://www.aliyun.com/product/sls) Log SDK written in Objective-C

## Motivation

For the official Aliyun Sls SDK is written in Swift 2.3, it's improper for objc app to be packaged with the large Swift Core Lib and Swift Foundation Lib, about 30 Mb.

This SDK is mostly interpreted from the official one, but the quality of code has been improved compared with the unreasonable style in the original one.

## Install

### Carthage

```
github "lujiajing1126/AliyunLogObjc"
```

CocoaPods is not supported now

## Example

```objc
#import <AliyunLogObjc/AliyunLogObjc.h> 
LogClient *client = [[LogClient alloc] initWithApp: @"endpoint" accessKeyID:@"" accessKeySecret:@"" projectName:@""];
LogGroup *logGroup = [[LogGroup alloc] initWithTopic: @"" andSource:@""];
Log *log1 = [[Log alloc] init];
[log1 PutContent: @"Value" withKey: @"Key"];
[logGroup PutLog:log1];
[client PostLog:logGroup logStoreName: @"" call:^(NSURLResponse* _Nullable response,NSError* _Nullable error) {
	if (error != nil) {
	}
}];

```

## Acknownledge

https://github.com/aliyun/aliyun-log-ios-sdk

https://github.com/bilby91/HMACSigner

https://github.com/nicklockwood/GZIP

https://github.com/siuying/NSData-MD5
