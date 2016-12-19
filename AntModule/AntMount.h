//
//  AntMount.h
//  AntModulePlayground
//
//  Created by xiaoxian on 2016/12/19.
//  Copyright © 2016年 sopig.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AntMount <NSObject>

@required
- (void)mount; //挂载

@end

@interface NSObject (AntMount)

@end


