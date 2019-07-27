//
//  KNHomeManager.h
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestResult) {
    RequestSuccess,
    RequestFailed
};

@interface KNHomeManager : NSObject

+ (instancetype)sharedInstance;

- (void)requestWithUrl:(NSString *)url :(void (^)(RequestResult success, id data))completionBlock;

@end
