//
//  AntNotification.h
//  CardSDK
//
//  Created by xiaoxian on 2016/12/14.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

#undef LISTEN_NOTIFICATION
#define LISTEN_NOTIFICATION(__name) \
[self observeNotification:__name]

#undef POST_NOTIFICATION
#define POST_NOTIFICATION(__name,__object) \
[self postNotification:__name withObject:__object]

#undef OFF_LISTEN_NOTIFICATION
#define OFF_LISTEN_NOTIFICATION \
[self unobserveAllNotifications]

#undef	ON_NOTIFICATION
#define ON_NOTIFICATION( __notification ) \
- (void)handleNotification:(NSNotification *)__notification


#pragma mark -


@interface NSNotification(AntNotification)

- (BOOL)is:(NSString *)name;
- (BOOL)isKindOf:(NSString *)prefix;

@end


@interface NSObject (AntNotification)

- (void)handleNotification:(NSNotification *)notification;

- (void)observeNotification:(NSString *)name;


- (void)unobserveNotification:(NSString *)name;
- (void)unobserveAllNotifications;

+ (BOOL)postNotification:(NSString *)name;
+ (BOOL)postNotification:(NSString *)name withObject:(NSObject *)object;

- (BOOL)postNotification:(NSString *)name;
- (BOOL)postNotification:(NSString *)name withObject:(NSObject *)object;


@end

