//
//  logoView.m
//  KNUEclass
//
//  Created by user on 2018. 2. 19..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNLogoView.h"

@interface KNLogoView ()

@end

@implementation KNLogoView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createTitleLb];
    }
    return self;
}

#pragma mark Set Logo View Instances

- (void)createTitleLb {
    self.topLb = [[UILabel alloc] init];
    self.topLb.text = @"KNU";
    [self.topLb setFont:[UIFont fontWithName:@"Arial-BoldMT" size:50]];
    self.topLb.textAlignment = NSTextAlignmentRight;
    self.topLb.textColor = [UIColor whiteColor];
    self.topLb.backgroundColor = [UIColor colorWithRed:81.0f/255.0f green:128.0f/255.0f blue:1.0f alpha:1.0f];
    [self addSubview:self.topLb];
    
    self.titleLb = [[UILabel alloc] init];
    self.titleLb.text = @"e-class";
    [self.titleLb setFont:[UIFont fontWithName:@"Arial" size:45]];
    self.titleLb.textAlignment = NSTextAlignmentLeft;
    self.titleLb.textColor = [UIColor whiteColor];
    self.titleLb.backgroundColor = [UIColor colorWithRed:81.0f/255.0f green:128.0f/255.0f blue:1.0f alpha:1.0f];
    [self addSubview:self.titleLb];
}

#pragma mark Logo View LayoutSubviews

- (void)layoutSubviews {
    self.topLb .translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.topLb
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeWidth multiplier:0.38f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.topLb
                                  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeHeight multiplier:0.1f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.topLb
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterX multiplier:0.5f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.topLb
                                  attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterY multiplier:1.2f constant:0.0f] setActive:YES];
    
    self.titleLb .translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.titleLb
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeWidth multiplier:0.58f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.titleLb
                                  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeHeight multiplier:0.1f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.titleLb
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterX multiplier:1.5f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.titleLb
                                  attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterY multiplier:1.2f constant:0.0f] setActive:YES];
}

@end
