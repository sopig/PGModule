//
//  main.m
//  AntModulePlayground
//
//  Created by xiaoxian on 2016/12/15.
//  Copyright © 2016年 sopig.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AntRuntime.h"



AntAutoLoadBegin

AntAutoLoadEnd


int main(int argc, char * argv[]) {
    
    NSLog(@"main");
    
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
