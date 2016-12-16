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
    
    //指定寻找
    else
    {
        [self doNativeCommand:command];
        return self;
    }
    
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
// scheme://host/path?query#fragment
// https://www.baidu.com/a/index.html?a=1&b=2#part3
    NSURL *url = [NSURL URLWithString:cmd.url];
    
    if ( !url )
    {
        [self changeStatus:AntCommandExecuteResultFailure];
        return;
    }
    
    NSString *scheme = url.scheme;
    NSString *host = url.host;
    NSString *path = url.path;
    NSString *query = url.query;
    NSString *fragment = url.fragment;
    
//    if ([scheme is:@"https"] || [scheme is:@"http"])
//    {
//        [DTContextGet() startApplication:@"20000067" params:params animated:YES];
//    }
//    
//    
//
//       else if ([urlString hasPrefix:@"http://"] || [urlString hasPrefix:@"https://"]) {
//        NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:6];
//        if (tmpParams &&
//            [tmpParams isKindOfClass:[NSDictionary class]] &&
//            [tmpParams count] > 0) {
//            [params addEntriesFromDictionary:tmpParams];
//        }
//        [params setObjectOrNil:urlString
//                        forKey:@"url"];
//        [params setObjectOrNil:@YES
//                        forKey:@"showProgress"];
//        [params setObjectOrNil:@"YES"
//                        forKey:@"startMultApp"];
//        [params setObjectOrNil:(customParams?:@"")
//                        forKey:@"customParams"];
//        [[self class] openRouterUrlCost:start];
//        
//        return [DTContextGet() startApplication:@"20000067" params:params animated:YES];
//    }
//    else {
//        //拼接埋点数据
//        
//        NSMutableString * realSceheme = [[NSMutableString alloc] initWithString:urlString];
//        if ([bizLogMonitor length] > 0) {
//            [realSceheme appendFormat:@"&%@=%@",CCardSDKBizLogMonitor , bizLogMonitor];
//        }
//        if ([dtLogMonitor length] > 0) {
//            [realSceheme appendFormat:@"&%@=%@",CCardSDKDTLogMonitor, dtLogMonitor];
//        }
//        if ([customParams length] > 0) {
//            [realSceheme appendFormat:@"&%@=%@",@"customParams", customParams];
//        }
//        
//        //  预处理
//        NSString *preparedScheme = [CRouterCenter prepareScheme:realSceheme context:context];
//        CLogInfo(preparedScheme);
//        
//        NSURL * url = [NSURL URLWithString:preparedScheme];
//        if (!url) {
//            NSString *logInfo = [NSString stringWithFormat:@"url encoding error %@", preparedScheme];
//            CLogInfo(logInfo);
//        }
//        
//        CLogInfo(([NSString stringWithFormat:@"open url : %@", preparedScheme]));
//        
//        id <DTSchemeService> service =  [DTContextGet() findServiceByName:@"DTSchemeService"];
//        if (service && [service canHandleURL:url]) {
//            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//            
//            [[self class] openRouterUrlCost:start];
//            
//            [userInfo setObjectOrNil:context forKey:CardSDKContextKey];
//            return [service handleURL:url userInfo:userInfo];
//        } else {
//            [[self class] openRouterUrlCost:start];
//            
//            return [[UIApplication sharedApplication] openURL:url];
//        }
//    }
//    

    
}

- (void)doNativeCommand:(AntCommand *)cmd
{
    
}




//- (void)startapp
//{
//    
//}
//- (void)openUrl:(NSString *url) {
//    PUSH,POP TARGET
//    
//    //alipays://asdf
////alipays://platform?startapp=h5&param
//    //
//    if (urlList.find(head) {
//        []
//    }else {
//        RETURN
//    }
//}
@end
