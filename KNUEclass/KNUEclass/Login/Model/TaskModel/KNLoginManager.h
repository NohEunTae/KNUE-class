//
//  KNLoginManager.h
//  KNUEclass
//
//  Created by user on 2018. 2. 14..
//  Copyright © 2018년 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNLoginManager : NSObject

typedef NS_ENUM(NSInteger, LoginResult) {
    LogInSuccess,
    LogInFailed,
    LoginNetworkError
};

typedef NS_ENUM(NSInteger, SSOLoginResult) {
    SSOLogInSuccess,
    SSOLogInFailed
};

+ (instancetype)sharedInstance;

- (void)processUserLogin:(NSString *)userAccount withUserPassword:(NSString *)userPassword withCompletionBlock:(void (^)(LoginResult success, NSString *msg))completionBlock;

@end
