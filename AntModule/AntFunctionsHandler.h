//
//  AntFunctionsHandler.h
//  CardSDK
//
//  Created by xiaoxian on 2016/12/14.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>


@class AntFunctionsHandler;
@interface NSObject (AntFunctionsHandler)

- (AntFunctionsHandler *)functionHandler;

- (BOOL)doFunction:(NSString *)name;
- (BOOL)doFunction:(NSString *)name withObject:(id)object;


- (void)addFunction:(id)function forName:(NSString *)name;
- (void)removeFunctionForName:(NSString *)name;
- (void)removeAllFunctions;

@end


@interface AntFunctionsHandler : NSObject

- (BOOL)doHandler:(NSString *)name;
- (BOOL)doHandler:(NSString *)name withObject:(id)object;

- (void)addHandler:(id)handler forName:(NSString *)name;
- (void)removeHandlerForName:(NSString *)name;
- (void)removeAllHandlers;

@end
