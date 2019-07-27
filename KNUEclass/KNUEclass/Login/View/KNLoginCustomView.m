//
//  KNLoginCustomView.m
//  KNUEclass
//
//  Created by user on 2018. 2. 14..
//  Copyright © 2018년 user. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KNLoginCustomView.h"
#import "KNLogoView.h"
#import "KNLoginInfoView.h"

@interface KNLoginCustomView ()

@property (nonatomic, strong) UILabel *explainLb;
@property (nonatomic, strong) UIColor *mainColor;
@property (nonatomic, strong) KNLogoView *logoView;
@property (nonatomic, strong) UITapGestureRecognizer *resignTextField;

@end

@implementation KNLoginCustomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        _mainColor = [UIColor colorWithRed:81.0f/255.0f green:128.0f/255.0f blue:1.0f alpha:1.0f];
        self.backgroundColor = [UIColor whiteColor];
        [self createLogoView];
        [self createLoginInfoView];
        [self createExplainLb];
    }
    
    return self;
}

#pragma mark Create SubViews

- (void)createResignTextField {
    self.resignTextField = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMethod:)];
    [self addGestureRecognizer:self.resignTextField];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

-(void)tapMethod:(UITapGestureRecognizer *)Gesture{
    [self resignFirstResponder];
}

- (void)createLogoView {
    self.logoView = [[KNLogoView alloc] init];
    self.logoView.backgroundColor = self.mainColor;
    [self addSubview:self.logoView];
}

- (void)createLoginInfoView {
    self.loginInfoView = [[KNLoginInfoView alloc] init];
    self.loginInfoView.backgroundColor = [UIColor whiteColor];
    self.loginInfoView.layer.masksToBounds = NO;
    self.loginInfoView.layer.shadowOffset = CGSizeMake(5, -5);
    self.loginInfoView.layer.shadowRadius = 1;
    self.loginInfoView.layer.shadowOpacity = 0.1;
    [self.loginInfoView.layer setCornerRadius:5.0f];
    [self.loginInfoView.layer setBorderWidth:0.5f];
    [self.loginInfoView.layer setBorderColor:[[UIColor grayColor]CGColor]];
    [self addSubview:self.loginInfoView];
}

- (void)createExplainLb {
    self.explainLb = [[UILabel alloc] init];
    self.explainLb.textColor = [UIColor colorWithRed:188.0f/255.0f green:199.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    self.explainLb.text = @"KNU e-class는 개인정보를 수집하지 않습니다.";
    [self.explainLb setFont:[UIFont fontWithName:@"NanumBarunGothicOTF-YetHangul" size:13]];
    self.explainLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.explainLb];
}

#pragma mark Login Custom View LayoutSubviews

- (void)layoutSubviews {
    self.logoView.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.logoView
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.logoView
                                  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeHeight multiplier:0.7f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.logoView
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.logoView
                                  attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterY multiplier:0.5f constant:0.0f] setActive:YES];

    self.loginInfoView.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.loginInfoView
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeWidth multiplier:0.8f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.loginInfoView
                                  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeHeight multiplier:0.4f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.loginInfoView
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.loginInfoView
                                  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.logoView.titleLb
                                  attribute:NSLayoutAttributeBottom multiplier:1.1f constant:0.0f] setActive:YES];
    
    
    self.explainLb.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.explainLb
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.explainLb
                                  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-15.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.explainLb
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];
}

@end

