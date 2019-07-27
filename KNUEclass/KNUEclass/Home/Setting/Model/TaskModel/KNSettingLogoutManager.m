//
//  KNSettingLogoutManager.m
//  KNUEclass
//
//  Created by user on 2018. 2. 27..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNSettingLogoutManager.h"
#import "KNNetworkModel.h"

@implementation KNSettingLogoutManager

#pragma mark Logout Manager Shared Instance

+ (instancetype)sharedInstance {
    static KNSettingLogoutManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KNSettingLogoutManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark Logout Process

- (void)processLogoutWithCompletionBlock:(void (^)(LogOutResult success, NSString *msg))completionBlock {
    [[KNNetworkModel sharedInstance] requestPostWithUrl:@"http://eclass.kangnam.ac.kr/eclass/eclass/Logout.action?null" withDic:nil withCompletionBlock:^(NetworkResult success, id data) {
        NSString *msg = data;
        if(success == ConnectSuccess) {
            completionBlock(LogOutSuccess, msg);
        } else {
            completionBlock(LogOutFailed, msg);
        }
    }];
}

@end
