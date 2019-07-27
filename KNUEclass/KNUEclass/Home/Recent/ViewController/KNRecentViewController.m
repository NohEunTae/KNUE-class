//
//  KNRecentViewController.m
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNRecentViewController.h"
#import "KNRecentNaviContorller.h"
#import "KNRecentTableView.h"
#import "KNPublicCustomTableViewCell.h"
#import "KNHomeManager.h"
#import "KNLoginManager.h"
#import "KNIndicator.h"
#import "KNKeychainManager.h"

#define MAX_PARSING_CNT 3
#define MIN_PARSING_CNT 0

@interface KNRecentViewController () <KNRecentTableViewDelegate>

@property (nonatomic, strong) KNRecentTableView *recentTableView;
@property (nonatomic, strong) KNIndicator *indicator;
@property (nonatomic, assign) NSInteger parsingCnt;
@property (nonatomic, assign) BOOL isRefresh;

@end

@implementation KNRecentViewController

#pragma mark Recent View Controller LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.parsingCnt = MIN_PARSING_CNT;
    self.isRefresh = NO;
    
    [self createRecentTableView];
    [self createIndicator];

    [self.indicator startIndicator];
    [self startNoticeDataParsingProcess];
    [self startNoteDataParsingProcess];
    [self startHwDataParsingProcess];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)connectLoginSessionAndReloadView {
    NSLog(@"[info] reconnect login session .... %@", [self class]);
    NSString *userAccount = [[KNKeychainManager sharedInstance] userInfoAccount];
    NSString *userPassword = [[KNKeychainManager sharedInstance] userInfoPassword];
    [[KNLoginManager sharedInstance] processUserLogin:userAccount withUserPassword:userPassword withCompletionBlock:^(LoginResult success, NSString *msg) {
        if (success == LogInSuccess) {
            self.parsingCnt = MIN_PARSING_CNT;
            if(self.recentTableView == nil) {
                [self createRecentTableView];
            }
            if (self.isRefresh == NO) {
                [self.indicator startIndicator];
            }
            [self startNoticeDataParsingProcess];
            [self startNoteDataParsingProcess];
            [self startHwDataParsingProcess];
        } else {
            NSLog(@"[info] connect login session failed");
        }
    }];
}

- (void)refreshTable {
    self.isRefresh = YES;
    [self startNoticeDataParsingProcess];
    [self startNoteDataParsingProcess];
    [self startHwDataParsingProcess];
}

#pragma mark Create Recent View Controller Attribute Set

- (void)createIndicator {
    self.indicator = [[KNIndicator alloc] initWithTarget:self.view]; 
    [self.view addSubview:self.indicator];
}

- (void)createRecentTableView {
    self.recentTableView = [[KNRecentTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain withRecentViewController:self];
    [self.recentTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.recentTableView registerClass:[KNPublicCustomTableViewCell class] forCellReuseIdentifier:@"newRise"];
    self.recentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.recentTableView setDataSourceWithDelegate];
    self.recentTableView.refreshDelegate = self;
    [self.view addSubview:self.recentTableView];
    
    self.recentTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.recentTableView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]setActive:YES];
    [[self.recentTableView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
    [[self.recentTableView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor]setActive:YES];
    [[self.recentTableView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor]setActive:YES];
}

#pragma mark Recent Parsing Process

// NSOperation
// ios 색 검색

- (void)startNoticeDataParsingProcess {
    NSString *url = @"http://eclass.kangnam.ac.kr/eclass/eclass/findMain.action?taskId=F_STU_MAIN&sysType=ECLS&clubId=ECLS_MAIN&menuCode=1005&menuNo=1&flag=class";
    [[KNHomeManager sharedInstance] requestWithUrl:url :^(RequestResult success, id data) {
        if(success == RequestSuccess) {
            [self.recentTableView setData:data withParsingType:PTnotice];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.parsingCnt++;
                if(self.parsingCnt == MAX_PARSING_CNT) {
                    [self.recentTableView reloadData];
                    if(self.isRefresh == YES) {
                        [self.recentTableView.recentRefresh endRefreshing];
                        self.isRefresh = NO;
                    } else {
                        [self.indicator stopIndicator];
                    }
                    self.parsingCnt = MIN_PARSING_CNT;
                }
            });
            NSLog(@"[Info] Success to request notice url .... %@", [self class]);
        } else {
            // 실패 처리
        }
    }];
}

- (void)startNoteDataParsingProcess {
    NSString *url = @"http://eclass.kangnam.ac.kr/eclass/eclass/findMain.action?taskId=F_STU_LECTDATA&sysType=ECLS&menuCode=2002";
    [[KNHomeManager sharedInstance] requestWithUrl:url :^(RequestResult success, id data) {
        if(success == RequestSuccess) {
            [self.recentTableView setData:data withParsingType:PTnote];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.parsingCnt++;
                if(self.parsingCnt == MAX_PARSING_CNT) {
                    [self.recentTableView reloadData];
                    if(self.isRefresh == YES) {
                        [self.recentTableView.recentRefresh endRefreshing];
                        self.isRefresh = NO;
                    } else {
                        [self.indicator stopIndicator];
                    }
                    self.parsingCnt = MIN_PARSING_CNT;
                }
            });
            NSLog(@"[Info] Success to request note url .... %@", [self class]);
        } else {
            // 실패 처리
        }
    }];
}

- (void)startHwDataParsingProcess {
    NSString *url = @"http://eclass.kangnam.ac.kr/eclass/eclass/findMain.action?taskId=F_STU_MAIN&flag=homeWork";
    [[KNHomeManager sharedInstance] requestWithUrl:url :^(RequestResult success, id data) {
        if(success == RequestSuccess) {
            [self.recentTableView setData:data withParsingType:PThomework];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.parsingCnt++;
                if(self.parsingCnt == MAX_PARSING_CNT) {
                    [self.recentTableView reloadData];
                    if(self.isRefresh == YES) {
                        [self.recentTableView.recentRefresh endRefreshing];
                        self.isRefresh = NO;
                    } else {
                        [self.indicator stopIndicator];
                    }
                    self.parsingCnt = MIN_PARSING_CNT;
                }
            });
            NSLog(@"[Info] Success to request homework url .... %@", [self class]);
        } else {
            // 실패 처리
        }
    }];
}

@end
