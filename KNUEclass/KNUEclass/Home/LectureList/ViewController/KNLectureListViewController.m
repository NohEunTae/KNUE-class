//
//  KNLectureListViewController.m
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNLectureListViewController.h"
#import "KNHomeManager.h"
#import "KNLectureListTableView.h"
#import "KNPublicCustomTableViewCell.h"
#import "KNALectureNoticeViewController.h"
#import "KNALectureNoteViewController.h"
#import "KNALectureHomeworkViewController.h"
#import "KNLectureListTableViewAdapter.h"
#import "KNLoginManager.h"
#import "KNKeychainManager.h"
#import "KNTabBarController.h"
#import "KNIndicator.h"

@interface KNLectureListViewController () <KNLecutreListTableViewDelegate>

@property (nonatomic, strong) KNLectureListTableView *lectureListTableView;
@property (nonatomic, strong) KNIndicator *lectureListIndicator;
@property (nonatomic) BOOL isRefresh;

@end

@implementation KNLectureListViewController

#pragma mark Lecture List View Controller LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isRefresh = NO;
    [self createLectureListTableView];
    [self createIndicator];
    
    [self.lectureListIndicator startIndicator];
    [self startLectureListDataParsingProcess];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)refreshTable {
    self.isRefresh = YES;
    [self startLectureListDataParsingProcess];
}

- (void)connectLoginSessionAndReloadView {
    NSLog(@"[info] reconnect login session .... %@", [self class]);
    NSString *userAccount = [[KNKeychainManager sharedInstance] userInfoAccount];
    NSString *userPassword = [[KNKeychainManager sharedInstance] userInfoPassword];
    [[KNLoginManager sharedInstance] processUserLogin:userAccount withUserPassword:userPassword withCompletionBlock:^(LoginResult success, NSString *msg) {
        if (success == LogInSuccess) {
            if(self.lectureListTableView == nil) {
                [self createLectureListTableView];
            }
            if (self.isRefresh == NO) {
                [self.lectureListIndicator startIndicator];
            }
            [self startLectureListDataParsingProcess];
        } else {
            NSLog(@"[info] connect login session failed");
        }
    }];
}

#pragma mark Create Lecture List View Controller Attribute Set

- (void)createLectureListTableView {
    self.lectureListTableView = [[KNLectureListTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain withLectureListViewController:self];
    [self.lectureListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.lectureListTableView registerClass:[KNPublicCustomTableViewCell class] forCellReuseIdentifier:@"lectureList"];
    self.lectureListTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.lectureListTableView setDataSourceWithDelegate];
    self.lectureListTableView.lectureListRefreshDelegate = self;
    [self.view addSubview:self.lectureListTableView];
}

- (void)createIndicator {
    self.lectureListIndicator = [[KNIndicator alloc] initWithTarget:self.view];
    [self.view addSubview:self.lectureListIndicator];
}

#pragma mark Lecture List Parsing Process

- (void)startLectureListDataParsingProcess {
    NSString *url = @"http://eclass.kangnam.ac.kr/eclass/eclass/findMain.action?taskId=F_MY_LECT&clubStat=%27S02001%27";
    [[KNHomeManager sharedInstance] requestWithUrl:url :^(RequestResult success, id data) {
        if(success == RequestSuccess) {
            [self.lectureListTableView setData:data withParsingType:PTlectureList];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.lectureListTableView reloadData];
                if(self.isRefresh == YES) {
                    [self.lectureListTableView.lectureRefreshControl endRefreshing];
                    self.isRefresh = NO;
                } else {
                    [self.lectureListIndicator stopIndicator];
                }
            });
        } else {
            NSLog(@"[info] lectureList request fail .... ");// 실패 처리
        }
    }];
}

@end
