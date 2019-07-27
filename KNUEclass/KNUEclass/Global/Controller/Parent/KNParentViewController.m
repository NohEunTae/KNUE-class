//
//  KNParentViewController.m
//  KNUEclass
//
//  Created by user on 2018. 2. 14..
//  Copyright © 2018년 user. All rights reserved.
//

#import "KNParentViewController.h"

@interface KNParentViewController ()

@end

@implementation KNParentViewController

#pragma mark Parent View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"[Info] ViewDidLoad .... %@", [self class]);
    
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"[Info] didReceiveMemoryWarning .... %@", [self class]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"[Info] viewWillAppear .... %@", [self class]);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"[Info] viewDidAppear .... %@", [self class]);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"[Info] viewWillDisappear .... %@", [self class]);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"[Info] viewDidDisappear .... %@", [self class]);
}

- (BOOL)shouldAutorotate {
    return NO;
}

@end
