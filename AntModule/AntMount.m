//
//  AntMount.m
//  AntModulePlayground
//
//  Created by xiaoxian on 2016/12/19.
//  Copyright © 2016年 sopig.cn. All rights reserved.
//

#import "AntMount.h"
#import "AntRuntime.h"

@implementation NSObject (AntMount)

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

@end
