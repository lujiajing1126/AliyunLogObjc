# AliyunLogObjc

> [Aliyun Sls](https://www.aliyun.com/product/sls) Log SDK written in Objective-C

This is an UNOFFICIAL SDK for Aliyun SLS, if you have questions you can just propose an issue.

这是非官方SDK，如有问题，请移步 Issues，但请务必不要滥用 Issues，提问之前，请先 **阅读`常见问题`部分 或 搜索是否有相关的问题**

## Install

### Carthage

```
github "lujiajing1126/AliyunLogObjc"
```

### Cocoapods

```
pod 'AliyunSlsObjc', '~> 1.1.6'
```

## Example

```objc
#import <AliyunLogObjc/AliyunLogObjc.h>
// Use JSON
// AliSLSProtobufSerializer - Protobuf serializer is available now
LogClient *client = [[LogClient alloc] initWithApp: @"endpoint" accessKeyID:@"" accessKeySecret:@"" projectName:@"" serializeType: AliSLSJSONSerializer];
LogGroup *logGroup = [[LogGroup alloc] initWithTopic: @"" andSource:@""];
Log *log1 = [[Log alloc] init];
[log1 PutContent: @"Value" withKey: @"Key"];
[logGroup PutLog:log1];
[client PostLog:logGroup logStoreName: @"" call:^(NSURLResponse* _Nullable response,NSError* _Nullable error) {
	if (error != nil) {
	}
}];

```

## 常见问题

  - 由于最新版本引入了`SLS`的`protobuf`协议，编译如果找不到相应的协议文件，
请参考 [Issue #17](https://github.com/lujiajing1126/AliyunLogObjc/issues/17)

## Acknownledge

https://github.com/aliyun/aliyun-log-ios-sdk

https://github.com/bilby91/HMACSigner

https://github.com/nicklockwood/GZIP

https://github.com/siuying/NSData-MD5
