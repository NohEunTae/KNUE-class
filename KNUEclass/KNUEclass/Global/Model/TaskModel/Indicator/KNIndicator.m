//
//  KNIndicator.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNIndicator.h"

@interface KNIndicator ()

@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation KNIndicator

- (instancetype)initWithTarget:(UIView *)targetView {
    self = [super init];
    if(self){
        _targetView = targetView;
        [self createIndicator];
    }
    return self;
}

#pragma mark Create Indicator

- (void)createIndicator {
    self.activityView = [[UIActivityIndicatorView alloc]  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:self.activityView];
}

- (void)layoutSubviews {
    self.activityView.frame = CGRectMake(0, 0, 50, 50);
    self.activityView.center = self.targetView.center;
}

#pragma mark Operate Indicator

- (void)startIndicator {
    [self.activityView startAnimating];
}

- (void)stopIndicator {
    [self.activityView stopAnimating];
}

@end
