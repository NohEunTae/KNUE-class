//
//  KNLoginManager.m
//  KNUEclass
//
//  Created by user on 2018. 2. 14..
//  Copyright © 2018년 user. All rights reserved.
//

#import "KNLoginManager.h"
#import "KNNetworkModel.h"
#import "KNUserModel.h"

@implementation KNLoginManager

#pragma mark LoginManager Shared Instance

+ (instancetype)sharedInstance {
    static KNLoginManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KNLoginManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark Login Process

- (void)processUserLogin:(NSString *)userAccount withUserPassword:(NSString *)userPassword withCompletionBlock:(void (^)(LoginResult success, NSString *msg))completionBlock {
    NSDictionary *dic = @{@"user_id" : userAccount, @"user_pwd" : userPassword};
    [[KNNetworkModel sharedInstance] requestGetWithUrl:@"https://m.kangnam.ac.kr/knusmart/c/c001.do" withDic:dic withCompletionBlock:^(NetworkResult success, id data) {
        if (success == ConnectSuccess) {
            NSString *msg = data[@"result_msg"];
            NSString *result = data[@"result"];
            if ([result isEqualToString:@"success"]) {
                NSLog(@"[Info] Success Login : %@ .... %@", msg, [self class]);
                [[KNUserModel sharedInstance] setUserAccount:userAccount withUserPassword:userPassword];
                [self processSSOLoginWithCompletionBlock:^(SSOLoginResult success) {
                    if (success == SSOLogInSuccess) {
                        completionBlock(LogInSuccess, msg);
                    } else {
                        completionBlock(LogInFailed, @"SSO 로그인에 실패하였습니다.");
                    }
                }];
            } else {
                NSLog(@"[Error] Faild Login : %@ .... %@", msg, [self class]);
                completionBlock(LogInFailed, msg);
            }
        } else {
            NSLog(@"[Error] Faild Login : Network Error .... %@", [self class]);
            completionBlock(LoginNetworkError, @"인터넷 연결 상태를 확인하세요");
        }
    }];
}

- (void)processSSOLoginWithCompletionBlock:(void (^)(SSOLoginResult success))completionBlock {
    NSString *userAccount = [KNUserModel sharedInstance].userAccount;
    NSString *userPassword = [KNUserModel sharedInstance].userPassword;
    NSDictionary *dic = @{@"gid" : @"gid_web", @"returl" : @"http://eclass.kangnam.ac.kr", @"uid" : userAccount, @"password" : userPassword};
    [[KNNetworkModel sharedInstance] requestPostWithUrl:@"http://knusso.kangnam.ac.kr/sso/pmi-sso-login-uid-password.jsp" withDic:dic withCompletionBlock:^(NetworkResult success, id data) {
        if (success == ConnectSuccess) {
            NSLog(@"[Info] Success SSO Login : .... %@", [self class]);
            [self processLoginPostProcWithCompletionBlock:^(SSOLoginResult success) {
                completionBlock(success);
            }];
        } else {
            NSLog(@"[Error] Faild SSO Login : Network Error .... %@", [self class]);
        }
    }];
}

- (void)processLoginPostProcWithCompletionBlock:(void (^)(SSOLoginResult success))completionBlock {
    [[KNNetworkModel sharedInstance] requestPostWithUrl:@"http://eclass.kangnam.ac.kr/eclass/sso/login_post_proc.jsp?returnurl=http%3A%2F%2Feclass.kangnam.ac.kr%3A80%2Feclass%2Ftotal_main.jsp" withDic:nil withCompletionBlock:^(NetworkResult success, id data) {
        if (success == ConnectSuccess) {
            NSLog(@"[Info] Success Login Post Proc : .... %@", [self class]);
            [self processSSOLoginActionWithCompletionBlock:^(SSOLoginResult success) {
                completionBlock(success);
            }];
        } else {
            NSLog(@"[Error] Faild Login Post Proc : Network Error .... %@", [self class]);
        }
    }];
}

- (void)processSSOLoginActionWithCompletionBlock:(void (^)(SSOLoginResult success))completionBlock {
    [[KNNetworkModel sharedInstance] requestPostWithUrl:@"http://eclass.kangnam.ac.kr/eclass/eclass/SSO_Login.action?task=SSO_LOGIN" withDic:nil withCompletionBlock:^(NetworkResult success, id data) {
        if (success == ConnectSuccess) {
            NSLog(@"[Info] Success SSO Login Action Post Proc : .... %@", [self class]);
            completionBlock(SSOLogInSuccess);
        } else {
            NSLog(@"[Error] Faild SSO Login Action : Network Error .... %@", [self class]);
            completionBlock(SSOLogInFailed);
        }
    }];
}

@end
