//
//  KNHomeworkDetailViewController.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNHomeworkDetailViewController.h"
#import "KNDetailCustomView.h"
#import "KNHomeworkModel.h"
#import "KNHomeManager.h"
#import "KNFileListViewController.h"
#import "KNFileListParamModel.h"
#import "KNImageManager.h"
#import "KNIndicator.h"

@interface KNHomeworkDetailViewController ()

@property (nonatomic, strong) KNDetailCustomView *detailView;
@property (nonatomic, strong) KNIndicator *indicator;

@end

@implementation KNHomeworkDetailViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _homeworkDetailModel = [[KNHomeworkModel alloc] init];
    }
    return self;
}

#pragma mark Homework Detail View Controller LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createIndicator];
    [self createHomeworkDetailView];
    [self.indicator startIndicator];
    [self modifyHomeworkDetailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Create Homework Detail View Controller Attribute Set

- (void)createIndicator {
    self.indicator = [[KNIndicator alloc] initWithTarget:self.view];
    [self.view addSubview:self.indicator];
}

- (void)createHomeworkDetailView {
    self.detailView = [[KNDetailCustomView alloc] initWithFrame:self.view.frame withType:@"과제"];
    [self.view addSubview:self.detailView];

    self.detailView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.detailView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]setActive:YES];
    [[self.detailView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
    [[self.detailView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor]setActive:YES];
    [[self.detailView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor]setActive:YES];
}

- (void)modifyHomeworkDetailView {
    if([self.homeworkDetailModel.workAttcYn isEqualToString:@"Y"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *fileIcon = [UIImage imageNamed:@"clip"];
            fileIcon = [KNImageManager resizeImage:fileIcon WithHeighAndWidth:self.navigationController.navigationBar.frame.size.height * 2 / 3];
            UIBarButtonItem *fileIconBtn = [[UIBarButtonItem alloc] initWithImage:fileIcon style:UIBarButtonItemStyleDone target:self action:@selector(openFileListBtnPressed)];
            self.navigationItem.rightBarButtonItem = fileIconBtn;
        });
    }
    NSString *submt = self.homeworkDetailModel.sbmtYn;
    if([submt isEqualToString:@"N"]) {
        submt = @"미제출";
    } else if([submt isEqualToString:@"Y"]) {
        submt = @"제출완료";
    } else {
        submt = @"평가완료";
    }
    NSRange range1 = NSMakeRange(2, 2);
    NSRange range2 = NSMakeRange(4, 2);
    NSRange range3 = NSMakeRange(6, 2);
    NSString *date1 = self.homeworkDetailModel.workStDt;
    NSString *date2 = self.homeworkDetailModel.workEdDt;
    NSString *result_date = [NSString stringWithFormat:@"%@.%@.%@ ~ %@.%@.%@",
                             [date1 substringWithRange:range1],
                             [date1 substringWithRange:range2],
                             [date1 substringWithRange:range3],
                             [date2 substringWithRange:range1],
                             [date2 substringWithRange:range2],
                             [date2 substringWithRange:range3]];
    NSString *info = [[NSString alloc] initWithFormat:@"기간:%@ (%@)", result_date,submt];
    [self.detailView modifyTitleLabelText:self.homeworkDetailModel.workTitle withNickNmbLabelText:info withDateLabelText:@"" withViewsLabelText:@"" withContentTextViewText:self.homeworkDetailModel.workCont];
    [self.indicator stopIndicator];
}

#pragma Homework Detail File Button Click Event

- (void)openFileListBtnPressed {
    KNFileListParamModel *paramModel = [[KNFileListParamModel alloc] init];
    paramModel.clubId = self.homeworkDetailModel.clubId;
    paramModel.workSeq = self.homeworkDetailModel.workSeq;
    paramModel.parsingType = PThomeworkFileList;
    KNFileListViewController *fileListViewController = [[KNFileListViewController alloc] initWithParamModel:paramModel];
    [self.navigationController pushViewController:fileListViewController animated:YES];
}

@end
