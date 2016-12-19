//
//  AntCommandExecutor.m
//  CardSDK
//
//  Created by xiaoxian on 2016/12/14.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "AntCommandExecutor.h"
#import "AntCommand.h"
#import "AntRuntime.h"
#import "AntModuleManager.h"
#import "AntFunctionsHandler.h"
#import "AntString.h"
#import "AntRouter.h"

@interface AntCommandExecutor ()
{
    AntCommandExecuteResult __result__;
    NSMutableDictionary *__cachedTarget__;
}

@end

@implementation AntCommandExecutor

@def_resident(AntCommandExecutor);

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        __cachedTarget__ = [NSMutableDictionary dictionary];
        __result__ = AntCommandExecuteResultUnknown;
    }
    return self;
}

- (void)dealloc
{
    [__cachedTarget__ removeAllObjects];
    __cachedTarget__ = nil;
}

- (AntCommandExecuteResult)result
{
    return __result__;
}

- (AntCommandExecutor *)execute:(AntCommand *)command
{
    NSAssert([NSThread mainThread], @"Antcommand must executing in mainThread");
    
    if (!command)
    {
       [self changeStatus:AntCommandExecuteResultFailure];
       return self;
    }
    
    if (AntCommandActionTypeUNKNOWN == command.actionType )
    {
       [self changeStatus:AntCommandExecuteResultFailure];
       return self;
    }
    
    //command到达
    [self changeStatus:AntCommandExecuteResultArrived];
    
    //选择器 selector寻找
    if ( AntCommandActionTypeSelector == command.actionType)
    {
        [self doSeletorCommand:command];
        
        return self;
    }
    
    //url寻找
    else if ( AntCommandActionTypeURL == command.actionType)
    {
        [self doURLCommand:command];
        return self;
    }
    
//    //指定寻找
//    else
//    {
//        [self doNativeCommand:command];
//        return self;
//    }
    
    return self;
}

#pragma mark - 


- (void)changeStatus:(NSUInteger)newStatus
{
    if (__result__ == newStatus)
    {
        return;
    }
    
    __result__ = newStatus;
}


#pragma mark - 

- (void)doSeletorCommand:(AntCommand *)cmd
{
    NSString* targetName = (NSString*)[self findComponent:cmd.target];
    
    if (![targetName isKindOfClass:[NSString class]]) {
        
        [self changeStatus:AntCommandExecuteResultFailure];
        
    }

    id target = __cachedTarget__[targetName];
    
    if ( !target )
    {
        Class targetClass = NSClassFromString(targetName);
        
        if ( !targetClass )
        {
            [self changeStatus:AntCommandExecuteResultFailure];
        }
        
        target = [[targetClass alloc] init];
        
        if ( !target )
        {
            //处理找不到target的逻辑
        }
        
        if (cmd.cacheTarget)
        {
            __cachedTarget__[targetName] = target;
        }
        
    }
    
    [self changeStatus:AntCommandExecuteResultExecuting];
    
    SEL action = NSSelectorFromString(cmd.action);
    
    if ([target respondsToSelector:action])
    {
        doAntInstanceImp([target class], action, target, (__bridge_retained void *)(cmd));
        [self changeStatus:AntCommandExecuteResultSuccess];
        
    }
    else
    {
#if 0
        // 处理action找不到的逻辑
        SEL action = NSSelectorFromString(@"notFound:");
        if ([target respondsToSelector:action])
        {
            
            doAntInstanceImp([target class], action, target, (__bridge_retained void *)(cmd));
            
        }
        else
        {
            
            [__cachedTarget__ removeObjectForKey:targetName];
            
        }
#endif
        [self changeStatus:AntCommandExecuteResultFailure];
    }

}

- (void)doURLCommand:(AntCommand *)cmd
{

    NSURL *url = [NSURL URLWithString:cmd.url];
    
    if ( !url )
    {
        [self changeStatus:AntCommandExecuteResultFailure];
        return;
    }
    
    
    NSString *router =  [AntModuleManagerInstance findModule:url.scheme];
    
    Class routerClazz = NSClassFromString(router);
    
    if (!routerClazz)
    {
        [self changeStatus:AntCommandExecuteResultFailure];
        return;
    }
    
    id<AntRouter> routerTarget = __cachedTarget__[router];
    
    if (!routerTarget)
    {
       routerTarget = [routerClazz new];
        [__cachedTarget__ setObject:routerTarget forKey:router];
    }
    
    [routerTarget openUrl:url patch:cmd];
    
    
}

//- (void)doNativeCommand:(AntCommand *)cmd
//{
//    
//}

@end
