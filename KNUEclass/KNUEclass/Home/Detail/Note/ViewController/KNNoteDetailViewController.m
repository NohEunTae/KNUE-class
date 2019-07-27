//
//  KNNoteDetailViewController.m
//  KNUEclass
//
//  Created by user on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNNoteDetailViewController.h"
#import "KNDetailCustomView.h"
#import "KNXmlParser.h"
#import "KNNoteDetailModel.h"
#import "KNHomeManager.h"
#import "KNFileStoreAndViewerModel.h"
#import "KNFileListViewController.h"
#import "KNFileListParamModel.h"
#import "KNImageManager.h"
#import "KNIndicator.h"
#import "KNLoginManager.h"
#import "KNKeychainManager.h"

@interface KNNoteDetailViewController () <KNXmlParserDelegate>

@property (nonatomic, strong) KNDetailCustomView *detailView;
@property (nonatomic, strong) KNXmlParser *xmlParser;
@property (nonatomic, strong) KNIndicator *indicator;

@end

@implementation KNNoteDetailViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _xmlParser = [[KNXmlParser alloc] init];
        _noteDetailModel = [[KNNoteDetailModel alloc] init];
    }
    return self;
}

#pragma mark Note Detail View Controller LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createIndicator];
    [self createNoteDetailView];
    [self.indicator startIndicator];
    [self startNoteDetailDataParsingProcess];
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
            if(self.detailView != nil) {
                [self createNoteDetailView];
            }
            [self startNoteDetailDataParsingProcess];
        } else {
            NSLog(@"[info] connect login session failed");
        }
    }];
}

#pragma mark Create Note Detail View Controller Attribute Set

- (void)createIndicator {
    self.indicator = [[KNIndicator alloc] initWithTarget:self.view];
    [self.view addSubview:self.indicator];
}

- (void)createNoteDetailView {
    self.detailView = [[KNDetailCustomView alloc] initWithFrame:self.view.frame withType:@"강의노트"];
    [self.view addSubview:self.detailView];
    
    self.detailView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.detailView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]setActive:YES];
    [[self.detailView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
    [[self.detailView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor]setActive:YES];
    [[self.detailView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor]setActive:YES];
}

#pragma mark Note Detail Parsing Process

- (void)startNoteDetailDataParsingProcess {
    NSString *url = [NSString stringWithFormat:@"http://eclass.kangnam.ac.kr/eclass/board/findBoard.action?taskId=F_NOTE&cmmnCd=&gradCode=E0006003&sysType=ECLS&menuCode=2002&adminYn=N&stringLeng=70&formName=&flag=&flag2=&page=1&pageSize=99999999&noteSeq=%@&clubId=%@",self.noteDetailModel.noteSeq, self.noteDetailModel.clubId];
    [[KNHomeManager sharedInstance] requestWithUrl:url :^(RequestResult success, id data) {
        if(success == RequestSuccess) {
            [self setData:data withParsingType:PTnoteDetail];
            NSLog(@"[Info] Success to request note detail url .... %@", [self class]);
        } else {
            // 실패 처리
        }
    }];
}

- (void)setData:(id)data withParsingType:(ParsingType)parsingType {
    NSLog(@"[info] note detail parsing start ....");
    self.xmlParser.delegate = self;
    [self.xmlParser startParsingWithData:data withParsingType:PTnoteDetail];
}

- (void)parsingDidFinishedWithParsingType:(ParsingType)parsingType withParsingList:(id)parsingList {
    switch (parsingType) {
        case PTnoteDetail: {
            NSLog(@"[info] note detail parsing finished");
            self.noteDetailModel = parsingList;
            if([self.noteDetailModel.fileYn isEqualToString:@"Y"]) {
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
            NSString *date = [NSString stringWithFormat:@"%@",self.noteDetailModel.regiDttm];
            NSString *result_date = [NSString stringWithFormat:@"%@.%@.%@",[date substringWithRange:range1],
                                     [date substringWithRange:range2],
                                     [date substringWithRange:range3]];
            [self.detailView modifyTitleLabelText:self.noteDetailModel.title withNickNmbLabelText:self.noteDetailModel.nickNm withDateLabelText:result_date withViewsLabelText:self.noteDetailModel.readCnt withContentTextViewText:self.noteDetailModel.noteCont];
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

#pragma Note Detail File Button Click Event

- (void)openFileListBtnPressed {
    NSLog(@"File List Button Clicked!!!");
    KNFileListParamModel *paramModel = [[KNFileListParamModel alloc] init];
    paramModel.clubId = self.noteDetailModel.clubId;
    paramModel.noteSeq = self.noteDetailModel.noteSeq;
    paramModel.parsingType = PTnoticeAndNoteFileList;
    KNFileListViewController *fileListViewController = [[KNFileListViewController alloc] initWithParamModel:paramModel];
    [self.navigationController pushViewController:fileListViewController animated:YES];
}

@end
