//
//  InfoView.m
//  KNUEclass
//
//  Created by user on 2018. 2. 19..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNLoginInfoView.h"
#import "KNImageManager.h"
#import "KNKeychainManager.h"


@interface KNLoginInfoView () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *accountLine, *passwordLine;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation KNLoginInfoView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createAccountTfAndPasswordTF];
        [self createLoginBtn];
        [self createLines];
    }
    return self;
}

#pragma mark Set Login Information View Instances

- (void)createAccountTfAndPasswordTF {
    self.accountTf = [[UITextField alloc]init];
    self.accountTf.textColor = [UIColor blackColor];
    self.accountTf.placeholder = @"학번";
    self.accountTf.keyboardType = UIKeyboardTypeNumberPad;
    self.accountTf.delegate = self;
    [self addSubview:self.accountTf];
    
    self.passwordTf = [[UITextField alloc]init];
    self.passwordTf.textColor = [UIColor blackColor];
    self.passwordTf.secureTextEntry = true; // password mode
    self.passwordTf.placeholder = @"비밀번호";
    self.passwordTf.delegate = self;
    [self addSubview:self.passwordTf];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.accountTf) {
        [self.passwordTf becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
        [self loginBtnPressed];
    }
    return YES;
}

- (void)createLoginBtn {
    self.loginBtn = [[UIButton alloc] init];
    self.loginBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.loginBtn setTitle:@"로그인" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.loginBtn.backgroundColor = [UIColor colorWithRed:81.0f/255.0f green:128.0f/255.0f blue:1.0f alpha:1.0f];
    self.loginBtn.titleLabel.font = [UIFont fontWithName:@"NanumBarunGothicOTF-YetHangul" size:20];
    [self.loginBtn.layer setCornerRadius:5.0f];
    [self.loginBtn.layer setBorderWidth:1.0f];
    [self.loginBtn.layer setBorderColor:[[UIColor whiteColor]CGColor]];
    [self.loginBtn setTitleColor: [UIColor grayColor] forState: UIControlStateHighlighted];
    [self.loginBtn addTarget:self action:@selector(loginBtnPressed) forControlEvents: UIControlEventTouchUpInside];
    [self.loginBtn setUserInteractionEnabled:YES];
    [self addSubview:self.loginBtn];
}

- (void)createLines {
    self.accountLine = [[UIView alloc] init];
    self.accountLine.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:223.0f/255.0f alpha:1.0f];
    [self addSubview:self.accountLine];
    
    self.passwordLine = [[UIView alloc] init];
    self.passwordLine.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:223.0f/255.0f alpha:1.0f];
    [self addSubview:self.passwordLine];
}

#pragma mark Login Information View LayoutSubviews

- (void)layoutSubviews {
    self.accountTf.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.accountTf
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeWidth multiplier:0.9f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.accountTf
                                  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeHeight multiplier:0.2f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.accountTf
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.accountTf
                                  attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterY multiplier:0.4f constant:0.0f] setActive:YES];
    
    self.accountLine.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.accountLine
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.accountTf
                                  attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.accountLine
                                  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.accountTf
                                  attribute:NSLayoutAttributeHeight multiplier:0.03f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.accountLine
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.accountTf
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.accountLine
                                  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.accountTf
                                  attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f] setActive:YES];
    
    self.passwordTf.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.passwordTf
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.accountTf
                                  attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.passwordTf
                                  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.accountTf
                                  attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.passwordTf
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.accountTf
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.passwordTf
                                  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.accountTf
                                  attribute:NSLayoutAttributeBottom multiplier:1.2f constant:0.0f] setActive:YES];
    
    self.passwordLine.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.passwordLine
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.passwordTf
                                  attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.passwordLine
                                  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.passwordTf
                                  attribute:NSLayoutAttributeHeight multiplier:0.03f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.passwordLine
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.passwordTf
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.passwordLine
                                  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.passwordTf
                                  attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f] setActive:YES];
    
    self.loginBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.loginBtn
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.accountTf
                                  attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.loginBtn
                                  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.accountTf
                                  attribute:NSLayoutAttributeHeight multiplier:0.7f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.loginBtn
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.accountTf
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.loginBtn
                                  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeBottom multiplier:0.9f constant:0.0f] setActive:YES];
}

#pragma mark Set Login Button

- (void)loginBtnPressed {
    [self.delegate startLoginProcessWithAccount:self.accountTf.text withPassword:self.passwordTf.text];
}

- (void)setLoginButtonEnable:(BOOL)flag {
    self.loginBtn.enabled = flag;
}

@end
