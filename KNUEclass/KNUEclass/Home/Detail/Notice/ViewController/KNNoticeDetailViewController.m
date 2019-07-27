//
//  KNNoticeDetailViewController.m
//  KNUEclass
//
//  Created by user on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNNoticeDetailViewController.h"
#import "KNDetailCustomView.h"
#import "KNNoticeDetailModel.h"
#import "KNHomeManager.h"
#import "KNXmlParser.h"
#import "KNParentNaviController.h"
#import "KNFileStoreAndViewerModel.h"
#import "KNFileListViewController.h"
#import "KNFileListParamModel.h"
#import "KNImageManager.h"
#import "KNIndicator.h"
#import "KNLoginManager.h"
#import "KNKeychainManager.h"

@interface KNNoticeDetailViewController () <KNXmlParserDelegate>

@property (nonatomic, strong) KNDetailCustomView *detailView;
@property (nonatomic, strong) KNXmlParser *xmlParser;
@property (nonatomic, strong) KNIndicator *indicator;

@end

@implementation KNNoticeDetailViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _xmlParser = [[KNXmlParser alloc] init];
        _noticeDetailModel = [[KNNoticeDetailModel alloc] init];
    }
    return self;
}

#pragma mark Notice Detail View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createIndicator];
    [self createNoticeDetailView];
    
    [self.indicator startIndicator];
    [self startNoticeDetailDataParsingProcess];
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
            if(self.detailView == nil) {
                [self createNoticeDetailView];
            }
            [self startNoticeDetailDataParsingProcess];
        } else {
            NSLog(@"[info] connect login session failed");
        }
    }];
}

#pragma mark Create Notice Detail View Controller Attribute Set

- (void)createIndicator {
    self.indicator = [[KNIndicator alloc] initWithTarget:self.view];
    [self.view addSubview:self.indicator];
}

- (void)createNoticeDetailView {
    self.detailView = [[KNDetailCustomView alloc] initWithFrame:self.view.frame withType:@"공지사항"];
    [self.view addSubview:self.detailView];

    self.detailView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.detailView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]setActive:YES];
    [[self.detailView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
    [[self.detailView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor]setActive:YES];
    [[self.detailView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor]setActive:YES];
}

#pragma mark Notice Detail Parsing Process

- (void)startNoticeDetailDataParsingProcess {
    NSString *url = [[NSString alloc]initWithFormat:@"http://eclass.kangnam.ac.kr/eclass/eclass/findMain.action?taskId=findBoardView&noteSeq=%@&sysType=ECLS&clubId=%@&menuCode=1005&menuNo=1",self.noticeDetailModel.noteSeq, self.noticeDetailModel.clubId];
    [[KNHomeManager sharedInstance] requestWithUrl:url :^(RequestResult success, id data) {
        if(success == RequestSuccess) {
            [self setData:data withParsingType:PTnoticeDetail];
            NSLog(@"[Info] Success to request notice detail url .... %@", [self class]);
        } else {
            // 실패 처리
        }
    }];
}

- (void)setData:(id)data withParsingType:(ParsingType)parsingType {
    NSLog(@"[info] notice detail parsing start ....");
    self.xmlParser.delegate = self;
    [self.xmlParser startParsingWithData:data withParsingType:PTnoticeDetail];
}

- (void)parsingDidFinishedWithParsingType:(ParsingType)parsingType withParsingList:(id)parsingList {
    switch (parsingType) {
        case PTnoticeDetail: {
            NSLog(@"[info] notice detail parsing finished");
            self.noticeDetailModel = parsingList;
            if([self.noticeDetailModel.fileYn isEqualToString:@"Y"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *fileIcon = [UIImage imageNamed:@"clip"];
                    fileIcon = [KNImageManager resizeImage:fileIcon WithHeighAndWidth:self.navigationController.navigationBar.frame.size.height * 2 / 3];
                    UIBarButtonItem *fileIconBtn = [[UIBarButtonItem alloc] initWithImage:fileIcon style:UIBarButtonItemStyleDone target:self action:@selector(openFileListBtnPressed)];
                    self.navigationItem.rightBarButtonItem = fileIconBtn;
                });
            }
            NSRange range1 = NSMakeRange(2, 2);
            NSRange range2 = NSMakeRange(5, 2);
            NSRange range3 = NSMakeRange(8, 2);
            NSString *date = [NSString stringWithFormat:@"%@",self.noticeDetailModel.regiDttm];
            NSString *result_date = [NSString stringWithFormat:@"%@.%@.%@",[date substringWithRange:range1],
                                     [date substringWithRange:range2],
                                     [date substringWithRange:range3]];
            [self.detailView modifyTitleLabelText:self.noticeDetailModel.title withNickNmbLabelText:self.noticeDetailModel.nickNm withDateLabelText:result_date withViewsLabelText:self.noticeDetailModel.readCnt withContentTextViewText:self.noticeDetailModel.noteCont];
            [self.indicator stopIndicator];
            break;
        }
        case PTLoginSessionHasExpired: {
            [self connectLoginSessionAndReloadView];
            break;
        }
        default:
            break;
    }
}

#pragma Notice Detail File Button Click Event

- (void)openFileListBtnPressed {
    KNFileListParamModel *paramModel = [[KNFileListParamModel alloc] init];
    paramModel.clubId = self.noticeDetailModel.clubId;
    paramModel.noteSeq = self.noticeDetailModel.noteSeq;
    paramModel.parsingType = PTnoticeAndNoteFileList;
    KNFileListViewController *fileListViewController = [[KNFileListViewController alloc] initWithParamModel:paramModel];
    [self.navigationController pushViewController:fileListViewController animated:YES];
}

@end
