//
//  KNNetworkModel.m
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNNetworkModel.h"
#import "AFNetwork.h"

@interface KNNetworkModel ()

@property (nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation KNNetworkModel

#pragma mark Shared Instance NetworkModel

+ (instancetype)sharedInstance {
    static KNNetworkModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KNNetworkModel alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.securityPolicy = securityPolicy;
    }
    return self;
}

#pragma mark Request

- (void)requestGetWithUrl:(NSString *)url withDic:(NSDictionary *)dic withCompletionBlock:(void (^)(NetworkResult success, id data))completionBlock {
    self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.sessionManager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionBlock(ConnectSuccess, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(ConnectFail, nil);
        NSLog(@"[Error] Network Error .... %@", [self class]);
    }];
}

- (void)requestPostWithUrl:(NSString *)url withDic:(NSDictionary *)dic withCompletionBlock:(void (^)(NetworkResult success, id data))completionBlock {
    self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.sessionManager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionBlock(ConnectSuccess, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(ConnectFail, nil);
        NSLog(@"[Error] Network Error .... %@", [self class]);
    }];
}

@end
