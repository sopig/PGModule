//
//  NSObject+AntResident.h
//  CardSDK
//
//  Created by xiaoxian on 2016/12/14.
//  Copyright © 2016年 Alipay. All rights reserved.
//

//常驻模块管理 Resident body
#import <Foundation/Foundation.h>

#undef resident
#define resident( __class ) \
property (nonatomic, readonly) __class * sharedInstance; \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;

#define def_resident( __class ) \
dynamic sharedInstance; \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static __strong id __instance__ = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
    __instance__ = self.new; \
}); \
return __instance__; \
}


@interface NSObject (AntResident)

+ (id)sharedInstance;
- (id)sharedInstance;

@end
