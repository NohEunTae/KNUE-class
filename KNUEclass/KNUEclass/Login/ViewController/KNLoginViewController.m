//
//  ViewController.m
//  KNUEclass
//
//  Created by user on 2018. 2. 14..
//  Copyright © 2018년 user. All rights reserved.
//

#import "KNLoginViewController.h"
#import "KNLoginCustomView.h"
#import "KNLoginInfoView.h"
#import "KNLoginManager.h"
#import "KNUserModel.h"
#import "KNTabBarController.h"
#import "KNParentNaviController.h"
#import "KNIndicator.h"
#import "KNKeychainManager.h"

@interface KNLoginViewController () <KNLoginInfoView>

@property (nonatomic) KNLoginCustomView *loginView;
@property (nonatomic, strong) KNIndicator *indicator; // 부모로

@end

@implementation KNLoginViewController

#pragma mark Login View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createLoginView];
    [self createIndicator];

    NSString *userAccount = [[KNKeychainManager sharedInstance] userInfoAccount];
    NSString *userPassword = [[KNKeychainManager sharedInstance] userInfoPassword];
    if((userAccount != nil && userAccount.length != 0)
       && (userPassword != nil && userPassword.length != 0)
       && [[[KNKeychainManager sharedInstance] autoLoginKeychainValue] isEqualToString:@"YES"]) {
        self.loginView.loginInfoView.accountTf.text = userAccount;
        self.loginView.loginInfoView.passwordTf.text = userPassword;
        [self startLoginProcessWithAccount:userAccount withPassword:userPassword];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Create Indicator

- (void)createIndicator {
    self.indicator = [[KNIndicator alloc] initWithTarget: self.view];
    [self.view addSubview: self.indicator];
}

#pragma mark Create Login View

- (void)createLoginView {
    self.loginView = [[KNLoginCustomView alloc] initWithFrame:self.view.frame];
    self.loginView.loginInfoView.delegate = self;
    
    [self.view addSubview:self.loginView];
    
    self.loginView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.loginView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]setActive:YES];
    [[self.loginView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
    [[self.loginView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor]setActive:YES];
    [[self.loginView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor]setActive:YES];
}

#pragma mark Start Login Process

- (void)startLoginProcessWithAccount:(NSString *)account withPassword:(NSString *)password {
    [self.loginView.loginInfoView setLoginButtonEnable:NO];
    [self.indicator startIndicator];
    
    // weak self로  (블록 안에서는 무조건, retain cycle 때문)
    [[KNLoginManager sharedInstance] processUserLogin:account withUserPassword:password withCompletionBlock:^(LoginResult success, NSString *msg) {
        if (success == LogInSuccess) {
            [[KNKeychainManager sharedInstance] setAutoLoginKeychainValue:@"YES"];
            [[KNKeychainManager sharedInstance] removeUserInfoKeychainValue];
            [[KNKeychainManager sharedInstance] setUserInfoKeychainWithAccount:account withPassworkd:password];
            KNTabBarController *tabBarController = [[KNTabBarController alloc] init];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[KNParentNaviController sharedInstance] popToRootViewControllerAnimated:NO];
                [[KNParentNaviController sharedInstance] pushViewController:tabBarController animated:YES];
                [UIApplication sharedApplication].keyWindow.rootViewController = [KNParentNaviController sharedInstance];
                [tabBarController setTabBarProcess];
            });
        } else {
            [self setLoginFailedAlertWithLoginResult:success withResultMsg:msg];
        }
        [self.indicator stopIndicator];
        [self.loginView.loginInfoView setLoginButtonEnable:YES];
    }];
}


#pragma mark Login Fail Alert

- (void)setLoginFailedAlertWithLoginResult:(LoginResult)LoginFailResult withResultMsg:(NSString *)msg {
    NSString *loginFailTitle = nil;
    switch (LoginFailResult) {
        case LogInFailed: {
            loginFailTitle = @"로그인 실패";
            break;
        }
        case LoginNetworkError: {
            loginFailTitle = @"네트워크 연결 실패";
            break;
        }
        default:
            break;
    }
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:loginFailTitle
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [alert dismissViewControllerAnimated:YES completion:nil];
                                                          }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
