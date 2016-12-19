//
//  AntModuleManager.m
//  CardSDK
//
//  Created by xiaoxian on 2016/12/15.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "AntModuleManager.h"
#import <objc/runtime.h>
#import "AntRuntime.h"


@implementation NSObject (AntModuleManager)

+ (void)load
{
    for ( NSString *className in [self loadedClassNames] )
    {
        Class classType = NSClassFromString( className );
        if ( classType == self )
            continue;
        
        if ([classType instancesRespondToSelector:NSSelectorFromString(@"mount")])
        {
            @autoreleasepool
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [[classType new] performSelector:NSSelectorFromString(@"mount")];
#pragma clang diagnostic pop

            }
        }

    }
    
}


- (BOOL)registerComponent:(NSString *)URI
{

  return [AntModuleManagerInstance registerModule:URI toClassName:NSStringFromClass(self.class)];
}


- (BOOL)unregisterComponent:(NSString *)URI
{
    
    return [AntModuleManagerInstance unregisterModule:URI];
}

- (id)findComponent:(NSString *)URI
{
    return [AntModuleManagerInstance findModule:URI];
}


@end

#pragma mark -

@interface AntModuleManager ()
{
    NSMutableDictionary *__modules__;
}

@end

@implementation AntModuleManager

AntModuleManager_AutoLoad;

@def_resident(AntModuleManager);

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        __modules__ = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (BOOL)registerModule:(NSString *)URI toClassName:(NSString *)name
{
    if ( !URI )
    {
        return NO;
    }
    
    if ( !name )
    {
        return NO;
    }
    
    NSArray *allURI = [__modules__ allKeys];
    
    NSAssert(![allURI containsObject:URI],([NSString stringWithFormat:@"[%@]组件URI重复，已被注册",URI]));
    
    [__modules__ setObject:name forKey:URI];
    
    return YES;
    
}


- (BOOL)unregisterModule:(NSString *)URI
{
    if ( !URI )
    {
        return NO;
    }
    
    [__modules__ removeObjectForKey:URI];
    
    return YES;
    
}

- (id)findModule:(NSString *)URI
{
    if ( !URI )
    {
        return nil;
    }
    
    return [__modules__ objectForKey:URI];
}

- (BOOL)registerBlock:(NSString *)URI toBlock:(id (^)(NSDictionary *))block
{
    if ( !URI )
    {
        
    }
    
    return NO;
}

- (BOOL)registerRouter:(NSString *)router forScheme:(NSString *)scheme
{
    if (!router || !scheme)
    {
        return NO;
    }
    
    NSArray *allURI = [__modules__ allKeys];
    
    NSAssert(![allURI containsObject:scheme],([NSString stringWithFormat:@"[%@]scheme重复，已被注册",scheme]));
    
    [__modules__ setObject:router forKey:scheme];
    
    
    return YES;
}


@end
