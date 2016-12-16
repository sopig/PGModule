//
//  AntFunctionsHandler.m
//  CardSDK
//
//  Created by xiaoxian on 2016/12/14.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "AntFunctionsHandler.h"
#import <objc/runtime.h>
@implementation NSObject (AntFunctionsHandler)


- (AntFunctionsHandler *)functionHandler
{
    AntFunctionsHandler *handler = objc_getAssociatedObject(self, _cmd);
    
    if (nil == handler)
    {
        handler = [AntFunctionsHandler new];
        objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_RETAIN);
    }
    
    return handler;
}

- (void)addFunction:(id)function forName:(NSString *)name
{
    AntFunctionsHandler *handler = [self functionHandler];
    
    if (handler)
    {
        [handler addHandler:function forName:name];
    }
}

- (void)removeFunctionForName:(NSString *)name
{
    AntFunctionsHandler *handler = [self functionHandler];
    
    if (handler)
    {
        [handler removeHandlerForName:name];
    }
}

- (void)removeAllFunctions
{
    AntFunctionsHandler *handler = [self functionHandler];
    
    if (handler)
    {
        [handler removeAllHandlers];
    }
    
    objc_setAssociatedObject(self, @selector(functionHandler), nil, OBJC_ASSOCIATION_RETAIN);
}


- (BOOL)doFunction:(NSString *)name
{
    return [self doFunction:name withObject:nil];
}

- (BOOL)doFunction:(NSString *)name withObject:(id)object
{
    AntFunctionsHandler *handler = [self functionHandler];
    
    if ( handler )
    {
      return  [handler doHandler:name withObject:object];
    }
    
    return NO;
}

@end


#pragma mark -

@implementation AntFunctionsHandler
{
    NSMutableDictionary * _functions;
}

- (id)init
{
    self = [super init];
    if ( self )
    {
        _functions = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_functions removeAllObjects];
    _functions = nil;
}

- (BOOL)doHandler:(NSString *)name
{
    return [self doHandler:name withObject:nil];
}

- (BOOL)doHandler:(NSString *)name withObject:(id)object
{
    if ( nil == name )
        return NO;
    
    void(^func)(id object) = (void(^)(id object))[_functions objectForKey:name];
    if ( nil == func )
        return NO;
    
    func( object );
    return YES;

}

- (void)addHandler:(id)handler forName:(NSString *)name
{
    if ( nil == name )
        return;
    
    if ( nil == handler )
    {
        [_functions removeObjectForKey:name];
    }
    else
    {
        [_functions setObject:handler forKey:name];
    }
}

- (void)removeHandlerForName:(NSString *)name
{
    if ( nil == name )
        return;
    
    [_functions removeObjectForKey:name];
}

- (void)removeAllHandlers
{
    [_functions removeAllObjects];
}



@end
