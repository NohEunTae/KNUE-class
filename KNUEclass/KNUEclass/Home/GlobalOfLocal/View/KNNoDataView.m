//
//  KNNoDataView.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 23..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNNoDataView.h"

@interface KNNoDataView ()

@property (nonatomic, strong) UILabel *noDataLabel;
@property (nonatomic, strong) UIView *targetView;

@end

@implementation KNNoDataView

- (instancetype)initWithFrame:(CGRect)frame withMsg:(NSString *)msg {
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self createLabel:msg];
    }
    return self;
}

#pragma mark Create No Data Label

- (void)createLabel:(NSString *)msg {
    self.noDataLabel = [[UILabel alloc] init];
    self.noDataLabel.backgroundColor = [UIColor whiteColor];
    self.noDataLabel.text = msg;
    self.noDataLabel.textColor = [UIColor colorWithRed:188.0f/255.0f green:199.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    self.noDataLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.noDataLabel];
}

#pragma mark No Data View LayoutSubviews

- (void)layoutSubviews {
    self.noDataLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.noDataLabel
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.noDataLabel
                                  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.noDataLabel
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.noDataLabel
                                  attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterY multiplier:0.8f constant:0.0f] setActive:YES];
}

@end
