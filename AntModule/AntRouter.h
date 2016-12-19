//
//  AntRouter.h
//  CardSDK
//
//  Created by xiaoxian on 2016/12/16.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AntCommand.h"
#import "AntMount.h"

@protocol AntRouter <NSObject,AntMount>

@required

- (void)openUrl:(NSURL *)url patch:(id)patch;

@end


