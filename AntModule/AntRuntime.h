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



#undef AntAutoLoadBegin
#define AntAutoLoadBegin \
__attribute__((constructor)) \
static void __com_auto_load__(void) {

#undef AntAutoLoadEnd
#define AntAutoLoadEnd \
}

#undef AntKW
#define AntKW \
try {} @catch (...) {}

#undef AntContact
#define AntContact(x,y) x ## y


//模仿swift的defer
typedef void(^defer_block_t)();
static inline void defer_exeute_function (__strong defer_block_t *block) {
    (*block)();
}

#undef defer
#define defer \
  AntKW \
__strong defer_block_t AntContact(_com_defer_, __LINE__) __attribute__((cleanup(defer_exeute_function), unused)) = ^



typedef id ( *AntImp )( id a, SEL b, void * c );

extern id doAntInstanceImp(Class clazz ,SEL selector ,id target ,void *params);

extern id doAntClassImp(Class clazz ,SEL selector ,id target ,void *params);

@interface NSObject (AntRuntime)

// 盗用from 的 selector 给 to
+ (void)take:(SEL)selector from:(Class)from to:(Class)to;
- (void)take:(SEL)selector from:(Class)from to:(Class)to;

+ (NSArray *)loadedClassNames;
@end


