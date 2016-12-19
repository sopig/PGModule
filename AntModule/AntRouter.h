//
//  AntRouter.h
//  CardSDK
//
//  Created by xiaoxian on 2016/12/16.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AntCommand.h"

@protocol AntRouter <NSObject>

@required
- (void)mount; //挂载

- (void)openUrl:(NSURL *)url patch:(id)patch;

@end


