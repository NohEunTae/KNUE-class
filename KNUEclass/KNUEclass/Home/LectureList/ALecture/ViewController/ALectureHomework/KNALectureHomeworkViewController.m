//
//  KNAHomeworkViewController.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNALectureHomeworkViewController.h"
#import "KNHomeManager.h"
#import "KNALectureTableView.h"
#import "KNPublicCustomTableViewCell.h"
#import "KNALectureTableViewAdapter.h"
#import "KNALectureModel.h"
#import "KNLoginManager.h"
#import "KNKeychainManager.h"

@interface KNALectureHomeworkViewController () <KNALectureTableViewAdapterDelegate>

@property (nonatomic, strong) KNALectureTableView *aLectureTableView;

@end

@implementation KNALectureHomeworkViewController

- (instancetype)init {
    self = [super init];
    if(self) {
        _aLectureHwModel = [[KNALectureModel alloc] init];
    }
    return self;
}

#pragma mark A Lecture Homework View Controller LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createALectureTableView];
    [self startALectureDataParsingProcess];
}

- (void)connectLoginSessionAndReloadView {
    NSString *userAccount = [[KNKeychainManager sharedInstance] userInfoAccount];
    NSString *userPassword = [[KNKeychainManager sharedInstance] userInfoPassword];
    [[KNLoginManager sharedInstance] processUserLogin:userAccount withUserPassword:userPassword withCompletionBlock:^(LoginResult success, NSString *msg) {
        if (success == LogInSuccess) {
            if(self.aLectureTableView != nil) {
                [self createALectureTableView];
            }
            [self startALectureDataParsingProcess];
        } else {
            NSLog(@"[info] connect login session failed");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Create A Lecture Homework View Controller Attribute Set

- (void)createALectureTableView {
    self.aLectureTableView = [[KNALectureTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain withIdentifier:PThomework withALectureViewContorller:self];
    [self.aLectureTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.aLectureTableView registerClass:[KNPublicCustomTableViewCell class] forCellReuseIdentifier:@"aLecture"];
    self.aLectureTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.aLectureTableView setDataSourceWithDelegate];
    self.aLectureTableView.aLectureTableViewAdapter.delegate = self;
    [self.view addSubview:self.aLectureTableView];
}

#pragma mark A Lecture Homework Parsing Process

- (void)startALectureDataParsingProcess {
    NSString *url = [NSString stringWithFormat:@"http://eclass.kangnam.ac.kr/eclass/eclass/findHomeWork.action?taskId=F_STUD_HOME_WORK&sysType=ECLS&pageSize=99999999&clubId=%@",self.aLectureHwModel.clubId];
    NSLog(@"[Info] 한개의 강의 과제목록 url ... %@",url);
    [[KNHomeManager sharedInstance] requestWithUrl:url :^(RequestResult success, id data) {
        if(success == RequestSuccess) {
            [self.aLectureTableView setData:data withParsingType:PThomework];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.aLectureTableView reloadData];
            });
        } else {
            NSLog(@"[info] lectureList request fail .... ");// 실패 처리
        }
    }];
}

- (NSString *)clubNm {
    return self.aLectureHwModel.clubNm;
}

@end
