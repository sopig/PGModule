//
//  AntCommand.h
//  CardSDK
//
//  Created by xiaoxian on 2016/12/14.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

#undef AntCommandCreate 
#define AntCommandCreate \
[AntCommand new]



typedef NS_ENUM(NSUInteger , AntCommandActionType)
{
    AntCommandActionTypeUNKNOWN,
    AntCommandActionTypeURL,      //url跳转
    AntCommandActionTypeSelector  //选择器寻找
};


@interface AntCommand : NSObject

//url方式描述 目标 + 动作 + 参数
// scheme://host/path?query#fragment
// https://www.baidu.com/a/index.html?a=1&b=2#part3
@property (nonatomic , strong , nullable) NSString *url;

/* 描述字符串（string）schema/反射描述 */
@property (nonatomic , strong , nullable) NSString *target;

/* 行为描述 */ 
@property (nonatomic , strong , nullable) NSString *action;

/* 输入参数 */
@property (nonatomic , strong , nullable) id input;

/* 目标类型 */
@property (nonatomic , assign) AntCommandActionType actionType;

@property (nonatomic , assign) BOOL cacheTarget;  //是否cache target


//构造
@property (nonatomic , strong , nullable)  AntCommand *_Nullable(^bUrl)(NSString *_Nonnull);
@property (nonatomic , strong , nullable)  AntCommand *_Nullable(^bTarget)(NSString *_Nonnull);
@property (nonatomic , strong , nullable)  AntCommand *_Nullable(^bAction)(NSString *_Nonnull);
@property (nonatomic , strong , nullable)  AntCommand *_Nullable(^bInput)(id _Nullable);
@property (nonatomic , strong , nullable)  AntCommand *_Nullable(^bActionType)(AntCommandActionType);



@end
