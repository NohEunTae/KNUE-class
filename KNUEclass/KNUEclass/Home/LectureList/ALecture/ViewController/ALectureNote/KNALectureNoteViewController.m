//
//  KNALectureNoteViewController.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNALectureNoteViewController.h"
#import "KNHomeManager.h"
#import "KNALectureTableView.h"
#import "KNPublicCustomTableViewCell.h"
#import "KNALectureModel.h"
#import "KNKeychainManager.h"
#import "KNLoginManager.h"

@interface KNALectureNoteViewController ()

@property (nonatomic, strong) KNALectureTableView *aLectureTableView;

@end

@implementation KNALectureNoteViewController

- (instancetype)init {
    self = [super init];
    if(self) {
        _aLectureNoteModel = [[KNALectureModel alloc] init];
    }
    return self;
}

#pragma mark A Lecture Note View Controller LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createALectureTableView];
    [self startALectureDataParsingProcess];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

#pragma mark Create A Lecture Note View Controller Attribute Set

- (void)createALectureTableView {
    self.aLectureTableView = [[KNALectureTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain withIdentifier:PTnote withALectureViewContorller:self];
    [self.aLectureTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.aLectureTableView registerClass:[KNPublicCustomTableViewCell class] forCellReuseIdentifier:@"aLecture"];
    self.aLectureTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.aLectureTableView setDataSourceWithDelegate];
    [self.view addSubview:self.aLectureTableView];
}

#pragma mark A Lecture Note Parsing Process

- (void)startALectureDataParsingProcess {
    NSString *url = [NSString stringWithFormat:@"http://eclass.kangnam.ac.kr/eclass/board/findBoard.action?taskId=F_LECT_DATA&stringLeng=60&sysType=ECLS&menuCode=2002&stringLeng=70&flag=&flag2=&pageSize=999999999&clubId=%@",self.aLectureNoteModel.clubId];
    NSLog(@"[Info] 한개의 강의 강의노트목록 url ... %@",url);
    [[KNHomeManager sharedInstance] requestWithUrl:url :^(RequestResult success, id data) {
        if(success == RequestSuccess) {
            [self.aLectureTableView setData:data withParsingType:PTnote];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.aLectureTableView reloadData];
            });
        } else {
            NSLog(@"[info] lectureList request fail .... ");// 실패 처리
        }
    }];
}

@end
