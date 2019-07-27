//
//  KNKeychainManager.h
//  KNUEclass
//
//  Created by user on 2018. 2. 22..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"

@interface KNKeychainManager : NSObject

+ (instancetype)sharedInstance;

- (void)setUserInfoKeychainWithAccount:(NSString *)account withPassworkd:(NSString *)password;
- (void)removeUserInfoKeychainValue;
- (NSString *)userInfoAccount;
- (NSString *)userInfoPassword;

- (void)setAutoLoginKeychainValue:(NSString *)autoLoginKeychainValue;
- (void)removeAutoLoginKeychainValue;
- (NSString *)autoLoginKeychainValue;

- (void)setInitialAutoLoginKeychain;

@end
