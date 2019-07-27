//
//  KNNetworkModel.h
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNNetworkModel : NSObject

typedef NS_ENUM(NSInteger, NetworkResult) {
    ConnectSuccess,
    ConnectFail
};

+ (instancetype)sharedInstance;

- (void)requestGetWithUrl:(NSString *)url withDic:(NSDictionary *)dic withCompletionBlock:(void (^)(NetworkResult success, id data))completionBlock;
- (void)requestPostWithUrl:(NSString *)url withDic:(NSDictionary *)dic withCompletionBlock:(void (^)(NetworkResult success, id data))completionBlock;

@end
