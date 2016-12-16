//
//  AntCommandExecutor.h
//  CardSDK
//
//  Created by xiaoxian on 2016/12/14.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AntResident.h"


#undef AntCommandExecute
#define AntCommandExecute(antcmdInstance) \
[[AntCommandExecutor sharedInstance] execute:antcmdInstance];


typedef NS_ENUM(NSUInteger,AntCommandExecuteResult)
{
    AntCommandExecuteResultUnknown,
    AntCommandExecuteResultFailure,
    AntCommandExecuteResultSuccess,
    AntCommandExecuteResultCancel,
    AntCommandExecuteResultArrived,
    AntCommandExecuteResultExecuting
    
};


@class AntCommand;

@interface AntCommandExecutor : NSObject

@resident(AntCommandExecutor);   //常驻模块

- (AntCommandExecutor *)execute:(AntCommand *)command ;

- (AntCommandExecuteResult)result;

@end
