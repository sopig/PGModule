//
//  AntModuleManager.h
//  CardSDK
//
//  Created by xiaoxian on 2016/12/15.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AntResident.h"

#undef AntRegisterModule
#define AntRegisterModuleURI( URI ) \
[AntModuleManagerInstance registerModule:URI toClassName:NSStringFromClass(self.class)]; 



#undef AntModuleManager_AutoLoad
#define AntModuleManager_AutoLoad \
+ (void)load \
{ \
    [AntModuleManager sharedInstance]; \
}

#undef AntModuleManagerInstance
#define AntModuleManagerInstance \
[AntModuleManager sharedInstance]


@class AntModuleManager;

@interface NSObject (AntModuleManager)

- (BOOL)registerComponent:(NSString *)URI;

- (BOOL)unregisterComponent:(NSString *)URI;

- (id)findComponent:(NSString *)URI;

@end

@interface AntModuleManager : NSObject

@resident(AntModuleManager); //常驻实例

- (BOOL)registerModule:(NSString *)URI toClassName:(NSString*)name;

- (BOOL)unregisterModule:(NSString *)URI;

- (id)findModule:(NSString *)URI;

- (BOOL)registerBlock:(NSString *)URI toBlock:(id (^)(NSDictionary *option))block;
@end
