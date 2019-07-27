//
//  KNParentNaviController.m
//  KNUEclass
//
//  Created by user on 2018. 2. 14..
//  Copyright © 2018년 user. All rights reserved.
//

#import "KNParentNaviController.h"

@interface KNParentNaviController ()

@end

@implementation KNParentNaviController

#pragma mark Parent NaviController Shared Instance

+ (instancetype)sharedInstance {
    static KNParentNaviController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KNParentNaviController alloc] init];
    });
    return sharedInstance;
}

#pragma mark Parent NaviController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotate {
    return NO;
}

@end
