//
//  KNTabBarControllerViewController.m
//  KNUEclass
//
//  Created by user on 2018. 2. 14..
//  Copyright © 2018년 user. All rights reserved.
//

#import "KNTabBarController.h"
#import "KNRecentNaviContorller.h"
#import "KNRecentViewController.h"
#import "KNLectureListNaviController.h"
#import "KNLectureListViewController.h"
#import "KNImageManager.h"
#import "KNFileBoxViewController.h"
#import "KNSettingViewController.h"

@interface KNTabBarController ()

@end

@implementation KNTabBarController

#pragma mark TabBarController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"KNU e-class";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.selectedViewController isKindOfClass:[KNLectureListNaviController class]]) {
        self.navigationItem.title= @"";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.selectedColor = [UIImage imageNamed:@"blueBackground"];
    self.selectedColor = [KNImageManager resizeTabBarBackgroundImageWithImage:self.selectedColor
                                                          withHeight:self.tabBar.frame.size.height
                                                           withWidth:self.tabBar.frame.size.width / 2];
    [self.tabBar setSelectionIndicatorImage:self.selectedColor];
}

- (void)setTabBarProcess {
    [self setRecentAndLectureListTabBar];
    [self setSettingButton];
    [self setFileBoxButton];
}

#pragma Set Home Tab Bar

- (void)setRecentAndLectureListTabBar {
    KNRecentViewController *recentVC = [[KNRecentViewController alloc] init];
    KNRecentNaviContorller *recentNV = [[KNRecentNaviContorller alloc] initWithRootViewController:recentVC];
    KNLectureListViewController *lectureListVC = [[KNLectureListViewController alloc] init];
    KNLectureListNaviController *lectureListNV = [[KNLectureListNaviController alloc] initWithRootViewController:lectureListVC];
    self.nvList = @[recentNV, lectureListNV];
    [self setViewControllers:self.nvList];
}

#pragma mark Button Setting

- (void)setSettingButton {
    UIImage *settingIcon = [UIImage imageNamed:@"settings"];
    settingIcon = [KNImageManager resizeImage:settingIcon WithHeighAndWidth:self.navigationController.navigationBar.frame.size.height];
    UIBarButtonItem *settingBtn = [[UIBarButtonItem alloc] initWithImage:settingIcon style:UIBarButtonItemStyleDone target:self action:@selector(settingBtnTouch)];
    self.navigationItem.rightBarButtonItem = settingBtn;
}

- (void)setFileBoxButton {
    UIImage *fileBoxIcon = [UIImage imageNamed:@"file_box"];
    fileBoxIcon = [KNImageManager resizeImage:fileBoxIcon WithHeighAndWidth:self.navigationController.navigationBar.frame.size.height];
    UIBarButtonItem *fileBoxIconBtn = [[UIBarButtonItem alloc] initWithImage:fileBoxIcon style:UIBarButtonItemStyleDone target:self action:@selector(fileBoxBtnTouch)];
    self.navigationItem.leftBarButtonItem = fileBoxIconBtn;
}

#pragma mark Button Touch Event

- (void)settingBtnTouch {
    KNSettingViewController *settingViewController = [[KNSettingViewController alloc] init];
    settingViewController.title = @"설정";
    [[KNParentNaviController sharedInstance] pushViewController:settingViewController animated:YES];
}

- (void)fileBoxBtnTouch {
    KNFileBoxViewController *fileBoxController = [[KNFileBoxViewController alloc] init];
    fileBoxController.title = @"파일함";
    [[KNParentNaviController sharedInstance] pushViewController:fileBoxController animated:YES];
}

@end
