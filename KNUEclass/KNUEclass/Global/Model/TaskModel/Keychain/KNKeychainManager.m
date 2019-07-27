//
//  KNKeychainManager.m
//  KNUEclass
//
//  Created by user on 2018. 2. 22..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNKeychainManager.h"

@interface KNKeychainManager ()

@property (nonatomic, strong) KeychainItemWrapper *userInfoKeychain, *autoLoginKeychain;

@end

@implementation KNKeychainManager

#pragma mark Keychain Shared Instance

+ (instancetype)sharedInstance {
    static KNKeychainManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KNKeychainManager alloc] init];
        sharedInstance.userInfoKeychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"KNUEclassLogin" accessGroup:nil];
        sharedInstance.autoLoginKeychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"AutoLogin" accessGroup:nil];
    });
    return sharedInstance;
}

#pragma mark Init AutoLogin Keychain

- (void)setInitialAutoLoginKeychain {
    if(![[self autoLoginKeychainValue] isEqualToString:@"YES"] && ![[self autoLoginKeychainValue] isEqualToString:@"NO"]) {
        [self setAutoLoginKeychainValue:@"YES"];
    }
}

#pragma mark Set Keychains

- (void)setUserInfoKeychainWithAccount:(NSString *)account withPassworkd:(NSString *)password {
    [self.userInfoKeychain setObject:account forKey:(id)kSecAttrAccount];
    [self.userInfoKeychain setObject:password forKey:(id)kSecValueData];
}

- (void)setAutoLoginKeychainValue:(NSString *)autoLoginKeychainValue {
    [self.autoLoginKeychain setObject:autoLoginKeychainValue forKey:(id)kSecValueData];
}

#pragma mark Get Keychains

- (NSString *)userInfoAccount {
    return [self.userInfoKeychain objectForKey:(id)kSecAttrAccount];
}

- (NSString *)userInfoPassword {
    return [self.userInfoKeychain objectForKey:(id)kSecValueData];
}

- (NSString *)autoLoginKeychainValue {
    return [self.autoLoginKeychain objectForKey:(id)kSecValueData];
}

#pragma mark Remove Keychains

- (void)removeUserInfoKeychainValue {
    [self.userInfoKeychain resetKeychainItem];
}

- (void)removeAutoLoginKeychainValue {
    [self.autoLoginKeychain resetKeychainItem];
}

@end
