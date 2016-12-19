//
//  AntRouterCenter.m
//  AntModulePlayground
//
//  Created by xiaoxian on 2016/12/19.
//  Copyright © 2016年 sopig.cn. All rights reserved.
//

#import "AntRouterCenter.h"
#import "AntModuleManager.h"
@implementation AntRouterCenter

- (void)mount
{
    [AntModuleManagerInstance registerRouter:NSStringFromClass(self.class) forScheme:@"alipays"];
     [AntModuleManagerInstance registerRouter:NSStringFromClass(self.class) forScheme:@"https"];
}

- (void)openUrl:(NSURL *)url patch:(id)patch
{
    
}

@end
