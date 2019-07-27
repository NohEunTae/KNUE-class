//
//  KNSettingLogoutManager.h
//  KNUEclass
//
//  Created by user on 2018. 2. 27..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNSettingLogoutManager : NSObject

typedef NS_ENUM(NSInteger, LogOutResult) {
    LogOutSuccess,
    LogOutFailed,
};

+ (instancetype)sharedInstance;
- (void)processLogoutWithCompletionBlock:(void (^)(LogOutResult success, NSString *msg))completionBlock;

@end
