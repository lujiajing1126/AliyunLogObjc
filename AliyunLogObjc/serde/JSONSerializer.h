//
//  JSONSerializer.h
//  AliyunLogObjc
//
//  Created by 陆家靖 on 23/03/2018.
//  Copyright © 2018 陆家靖. All rights reserved.
//

#import "Serializer.h"

#ifndef JSONSerializer_h
#define JSONSerializer_h

@interface JSONSerializer : NSObject <SerializerProtocol>
+ (id) sharedInstance;
@end

#endif /* JSONSerializer_h */
