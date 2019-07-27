//
//  KNUserModel.h
//  KNUEclass
//
//  Created by user on 2018. 2. 14..
//  Copyright © 2018년 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNUserModel : NSObject

@property (nonatomic) NSString *userAccount, *userPassword;

@end

@interface KNUserModel(Login)

+ (instancetype)sharedInstance;

- (void)setUserAccount:(NSString *)userAccount withUserPassword:(NSString *)userPassword;

@end
