//
//  AntRuntime.m
//  CardSDK
//
//  Created by xiaoxian on 2016/12/14.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "AntRuntime.h"
#import <objc/objc-runtime.h>

id doAntInstanceImp(Class clazz ,SEL selector ,id target ,void *params)
{
    Method method = class_getInstanceMethod( clazz, selector );
    if ( method )
    {
        AntImp imp = (AntImp)method_getImplementation( method );
        if ( imp )
        {
          return  imp( target,selector,params);
        }
    }
    
    return nil;
}

id doAntClassImp(Class clazz ,SEL selector ,id target ,void *params)
{
    Method method = class_getClassMethod( clazz, selector );
    if ( method )
    {
        AntImp imp = (AntImp)method_getImplementation( method );
        if ( imp )
        {
          return imp( target,selector,params);
        }
    }
    return nil;
}


@implementation NSObject (AntRuntime)

- (void)take:(SEL)selector from:(Class)from to:(Class)to
{
    [[self class] take:selector from:from to:to];
}

+ (void)take:(SEL)selector from:(Class)from to:(Class)to
{
    //from 中有 sel
    if (class_respondsToSelector(from, selector)) {
        //
        Method method = class_getInstanceMethod(from, selector);
        
        IMP imp = method_getImplementation(method);
        
        
        //将imp盗用给to
        if (!class_addMethod(to, selector, imp, method_getTypeEncoding(method))) {
            Method toMethod = class_getInstanceMethod(to, selector);
            method_setImplementation(toMethod, imp);
        }
    }
}

+ (NSArray *)loadedClassNames
{
    static dispatch_once_t		once;
    static NSMutableArray *		classNames;
    
    dispatch_once( &once, ^
                  {
                      classNames = [[NSMutableArray alloc] init];
                      
                      unsigned int 	classesCount = 0;
                      Class *		classes = objc_copyClassList( &classesCount );
                      
                      for ( unsigned int i = 0; i < classesCount; ++i )
                      {
                          Class classType = classes[i];
                          
                          if ( class_isMetaClass( classType ) )
                              continue;
                          
                          Class superClass = class_getSuperclass( classType );
                          
                          if ( nil == superClass )
                              continue;
                          
                          [classNames addObject:[NSString stringWithUTF8String:class_getName(classType)]];
                      }
                      
                      [classNames sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                          return [obj1 compare:obj2];
                      }];
                      
                      free( classes );
                  });
    
    return classNames;
}




@end
