//
//  KNUserModel.m
//  KNUEclass
//
//  Created by user on 2018. 2. 14..
//  Copyright © 2018년 user. All rights reserved.
//

#import "KNUserModel.h"

@implementation KNUserModel

#pragma mark User Model Shared Instance

+ (instancetype)sharedInstance {
    static KNUserModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KNUserModel alloc] init];
    });
    return sharedInstance;
}

#pragma mark Set User Model

- (void)setUserAccount:(NSString *)userAccount withUserPassword:(NSString *)userPassword {
    self.userAccount = userAccount;
    self.userPassword = userPassword;
}

@end
