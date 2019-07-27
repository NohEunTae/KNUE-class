//
//  KNFileListViewController.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 18..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNFileListViewController.h"
#import "KNFileListTableView.h"
#import "KNPublicCustomTableViewCell.h"
#import "KNFileListParamModel.h"
#import "KNXmlParser.h"
#import "KNHomeManager.h"
#import "KNFileListTableViewAdapter.h"
#import "KNLoginManager.h"
#import "KNKeychainManager.h"

@interface KNFileListViewController () <KNFileListTableViewAdapterDelegate>

@property (nonatomic, strong) KNFileListTableView *fileListTableView;
@property (nonatomic, strong) KNFileListParamModel *fileParamModel;

@end

@implementation KNFileListViewController


- (instancetype)initWithParamModel:(KNFileListParamModel *)paramModel {
    self = [super init];
    if(self){
        _fileParamModel = paramModel;
        self.title = @"파일 목록";
    }
    return self;
}

#pragma mark File List View Controller LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createFileListTableView];
    [self startFileListDataParsingProcess];
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
            if(self.fileListTableView != nil) {
                [self createFileListTableView];
            }
            [self startFileListDataParsingProcess];
        } else {
            NSLog(@"[info] connect login session failed");
        }
    }];
}

#pragma mark Create File LIst View Controller Attribute Set

- (void)createFileListTableView {
    self.fileListTableView = [[KNFileListTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain withFileListViewContorller:self];
    [self.fileListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.fileListTableView registerClass:[KNPublicCustomTableViewCell class] forCellReuseIdentifier:@"fileList"];
    self.fileListTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.fileListTableView setDataSourceWithDelegate];
    self.fileListTableView.fileListTableViewAdapter.delegate = self;
    [self.view addSubview:self.fileListTableView];
}

#pragma mark File List Parsing Process

- (void)startFileListDataParsingProcess {
    switch (self.fileParamModel.parsingType) {
        case PTnoticeAndNoteFileList:{
            NSString *url = [NSString stringWithFormat:@"http://eclass.kangnam.ac.kr/eclass/board/findBoard.action?taskId=F_NOTE&cmmnCd=&gradCode=E0006003&sysType=ECLS&menuCode=2002&adminYn=N&stringLeng=70&formName=&flag=&flag2=&page=1&pageSize=99999999&noteSeq=%@&clubId=%@",self.fileParamModel.noteSeq, self.fileParamModel.clubId];
               NSLog(@"[Info] 선택된 공지사항 or 강의노트 파일목록 url ... %@",url);
            [[KNHomeManager sharedInstance] requestWithUrl:url :^(RequestResult success, id data) {
                if(success == RequestSuccess) {
                    [self.fileListTableView setData:data withParsingType:PTnoticeAndNoteFileList];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.fileListTableView reloadData];
                    });
                } else {
                    NSLog(@"[info] notice or note FileList request fail .... ");// 실패 처리
                }
            }];
            break;
        }
        case PThomeworkFileList:{
            NSString *url = [NSString stringWithFormat:@"http://eclass.kangnam.ac.kr/eclass/eclass/findHomeWork.action?taskId=F_FROF_FILE&sysType=ECLS&menuCode=2003&menuNo=1&clubId=%@&workSeq=%@",self.fileParamModel.clubId, self.fileParamModel.workSeq];
            NSLog(@"[Info] 선택된 과제 파일목록 url ... %@",url);
            [[KNHomeManager sharedInstance] requestWithUrl:url :^(RequestResult success, id data) {
                if(success == RequestSuccess) {
                    [self.fileListTableView setData:data withParsingType:PThomeworkFileList];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.fileListTableView reloadData];
                    });
                } else {
                    NSLog(@"[info] homework FileList request fail .... ");// 실패 처리
                }
            }];
            break;
        }
        default:
            break;
    }
}

- (id)getViewController {
    return self;
}

@end
