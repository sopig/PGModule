//
//  AntRuntime.h
//  CardSDK
//
//  Created by xiaoxian on 2016/12/14.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

#undef	AntRuntimeClass
#define	AntRuntimeClass( x )		NSClassFromString(@ #x)

#undef	AntRuntimeInstance
#define	AntRuntimeInstance( x )	[[NSClassFromString(@ #x) alloc] init]


typedef id ( *AntImp )( id a, SEL b, void * c );

extern id doAntInstanceImp(Class clazz ,SEL selector ,id target ,void *params);

extern id doAntClassImp(Class clazz ,SEL selector ,id target ,void *params);

@interface NSObject (AntRuntime)

// 盗用from 的 selector 给 to
+ (void)take:(SEL)selector from:(Class)from to:(Class)to;
- (void)take:(SEL)selector from:(Class)from to:(Class)to;

+ (NSArray *)loadedClassNames;
@end


