//
//  AntCommand.m
//  CardSDK
//
//  Created by xiaoxian on 2016/12/14.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "AntCommand.h"

@interface AntCommand ()

@end

@implementation AntCommand

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        _actionType = AntCommandActionTypeUNKNOWN;
        _cacheTarget = YES;
    }
    
    return self;
}


#pragma mark -
//构造

- (AntCommand * _Nullable (^)(NSString * _Nonnull))bUrl
{
    AntCommand *(^b)(NSString * _Nonnull) = ^AntCommand *(NSString *name)
    {
        _url = name;
        return self;
    };
    return b;
}

- (AntCommand * _Nullable (^)(NSString * _Nonnull))bTarget
{
    AntCommand *(^b)(NSString * _Nonnull) = ^AntCommand *(NSString *name)
    {
        _target = name;
        return self;
    };
    return b;
}

- (AntCommand * _Nullable (^)(NSString * _Nonnull))bAction
{
    AntCommand *(^b)(NSString * _Nonnull) = ^AntCommand *(NSString *name)
    {
        _action = name;
        return self;
    };
    return b;
}

- (AntCommand * _Nullable (^)(id _Nullable))bInput
{
    AntCommand *(^b)(id _Nullable) = ^AntCommand *(id _Nullable input)
    {
        _input = input;
        return self;
    };
    return b;
}

- (AntCommand * _Nullable (^)(AntCommandActionType))bActionType
{
    AntCommand *(^b)(AntCommandActionType) = ^AntCommand *(AntCommandActionType type)
    {
        _actionType = type;
        return self;
    };
    return b;
}


@end
