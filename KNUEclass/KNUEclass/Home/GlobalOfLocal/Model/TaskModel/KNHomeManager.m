//
//  KNHomeManager.m
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNHomeManager.h"
#import "KNNetworkModel.h"

@implementation KNHomeManager

#pragma mark HomeManager Shared Instance

+ (instancetype)sharedInstance {
    static KNHomeManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KNHomeManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark HomeManager Request

- (void)requestWithUrl:(NSString *)url :(void (^)(RequestResult success, id data))completionBlock {
    [[KNNetworkModel sharedInstance] requestPostWithUrl:url withDic:nil withCompletionBlock:^(NetworkResult success, id data) {
        if (success == ConnectSuccess) {
            completionBlock(RequestSuccess, data);
        } else {
            NSLog(@"[Error] Faild to request : Network Error .... %@", [self class]);
        }
    }];
}

@end
