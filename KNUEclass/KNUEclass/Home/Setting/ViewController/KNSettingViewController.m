//
//  KNSettingViewController.m
//  KNUEclass
//
//  Created by user on 2018. 2. 22..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNSettingViewController.h"
#import "KNSettingTableView.h"

@interface KNSettingViewController ()

@property (nonatomic, strong) KNSettingTableView *settingTableView;

@end

@implementation KNSettingViewController

#pragma mark Setting View Controller LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSettingTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Create Setting TableView

- (void)createSettingTableView {
    self.settingTableView = [[KNSettingTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.settingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"setting"];
    self.settingTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.settingTableView setDataSourceWithDelegate];
    [self.view addSubview:self.settingTableView];
    
    self.settingTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.settingTableView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]setActive:YES];
    [[self.settingTableView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
    [[self.settingTableView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor]setActive:YES];
    [[self.settingTableView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor]setActive:YES];

}

@end
