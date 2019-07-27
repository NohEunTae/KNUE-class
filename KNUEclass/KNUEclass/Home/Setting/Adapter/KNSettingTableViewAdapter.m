//
//  KNSettingTableViewAdapter.m
//  KNUEclass
//
//  Created by user on 2018. 2. 22..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNSettingTableViewAdapter.h"
#import "KNLoginViewController.h"
#import "KNKeychainManager.h"
#import "KNSettingLogoutManager.h"

@interface KNSettingTableViewAdapter ()

@property (nonatomic, strong) NSMutableArray *keys;
@property (nonatomic, strong) NSMutableArray *set, *appInfo, *developerInfo;
@property (nonatomic, strong) UISwitch *autoLoginSwitch;

@end

@implementation KNSettingTableViewAdapter

#pragma mark Setting Table View Adapter

- (instancetype)init {
    self = [super init];
    if(self) {
        _keys = [[NSMutableArray alloc] initWithObjects:@"설정", @"앱 정보", @"개발자 정보", @"본 앱의 문의나 버그 신고는 개발자에게 연락 부탁드립니다.", nil];
        _set = [[NSMutableArray alloc] initWithObjects:@"자동 로그인", nil];
        NSString *version = [[NSString alloc] initWithFormat:@"배포 버전 : %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        NSString *build = [[NSString alloc] initWithFormat:@"빌드 버전 : %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]];
        _appInfo = [[NSMutableArray alloc] initWithObjects:version, build, nil];
        _developerInfo = [[NSMutableArray alloc] initWithObjects:@"강남대학교 컴퓨터공학과 노은태", @"강남대학교 컴퓨터미디어정보공학부 권재환", @"컴퓨터미디어정보공학부 학부 동아리 NetApp", nil];
    }
    
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 3: {
            [[KNSettingLogoutManager sharedInstance] processLogoutWithCompletionBlock:^(LogOutResult success, NSString *msg) {
                if(success == LogOutSuccess) {
                    [[KNKeychainManager sharedInstance] removeUserInfoKeychainValue];
                    [[KNKeychainManager sharedInstance] removeAutoLoginKeychainValue];
                    NSLog(@"[info] Logout msg : %@", [[NSString alloc] initWithData:msg encoding:NSUTF8StringEncoding]);
                    KNLoginViewController *loginVC = [[KNLoginViewController alloc] init];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
                    });
                } else {
                    NSLog(@"[info] Logout failed");
                }
            }];
            break;
        }
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [self.set count];
        case 1:
            return [self.appInfo count];
        case 2:
            return [self.developerInfo count];
        case 3:
            return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.keys count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.keys objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIApplication sharedApplication].keyWindow.frame.size.height / 14;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting" forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"setting"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0: {
            cell.textLabel.text = [self.set objectAtIndex:indexPath.row];
            self.autoLoginSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
            if(![[[KNKeychainManager sharedInstance] autoLoginKeychainValue] isEqualToString:@"NO"])
                [self.autoLoginSwitch setOn:YES];
            else
                [self.autoLoginSwitch setOn:NO];
            
            [self.autoLoginSwitch addTarget:self action:@selector(switchDidChanged) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = self.autoLoginSwitch;
            break;
        }
        case 1: {
            cell.textLabel.text = [self.appInfo objectAtIndex:indexPath.row];
            break;
        }
        case 2: {
            cell.textLabel.text = [self.developerInfo objectAtIndex:indexPath.row];;
            break;
        }
        case 3: {
            cell.backgroundColor = [UIColor colorWithRed:81.0f/255.0f green:128.0f/255.0f blue:1.0f alpha:1.0f];
            cell.textLabel.text = @"로그아웃";
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            break;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [UIApplication sharedApplication].keyWindow.frame.size.height / 13.5;
}

#pragma mark Modify Switch

- (void)switchDidChanged {
    if([self.autoLoginSwitch isOn]) {
        NSLog(@"switch on");
        [[KNKeychainManager sharedInstance] setAutoLoginKeychainValue:@"YES"];
    } else {
        NSLog(@"switch off");
        [[KNKeychainManager sharedInstance] setAutoLoginKeychainValue:@"NO"];
        [[KNKeychainManager sharedInstance] removeUserInfoKeychainValue];
    }
}

@end
