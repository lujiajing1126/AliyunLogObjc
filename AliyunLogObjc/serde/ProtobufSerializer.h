//
//  ProtobufSerializer.h
//  AliyunLogObjc
//
//  Created by 陆家靖 on 23/03/2018.
//  Copyright © 2018 陆家靖. All rights reserved.
//

#import "Serializer.h"

#ifndef ProtobufSerializer_h
#define ProtobufSerializer_h

@interface ProtobufSerializer : NSObject <SerializerProtocol>
+ (id) sharedInstance;
@end

#endif /* ProtobufSerializer_h */
