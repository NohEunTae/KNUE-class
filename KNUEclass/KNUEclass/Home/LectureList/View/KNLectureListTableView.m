//
//  KNLectureListTableView.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNLectureListTableView.h"

@interface KNLectureListTableView ()

@property (nonatomic, strong) KNLectureListTableViewAdapter *lectureListTableViewAdapter;

@end

@implementation KNLectureListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style withLectureListViewController:(KNLectureListViewController *)lectureListViewContorller {
    self = [super initWithFrame:frame style:style];

    if (self) {
        _lectureListTableViewAdapter = [[KNLectureListTableViewAdapter alloc] init];
        _lectureListTableViewAdapter.view = self;
        _lectureListTableViewAdapter.lectureListVC = lectureListViewContorller;
        _lectureRefreshControl = [[UIRefreshControl alloc] init];
        [self addSubview:_lectureRefreshControl];
        [_lectureRefreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
        _lectureRefreshControl.tintColor = [UIColor colorWithRed:0.25f green:0.72f blue:0.85f alpha:1.0];
    }

    return self;
}

- (void)refreshTable {
    NSLog(@"[info] table refreshed .... %@", [self class]);
    [self.lectureRefreshControl beginRefreshing];
    [self.lectureListRefreshDelegate refreshTable];
}

#pragma mark Lecture List Table Set

- (void)setDataSourceWithDelegate {
    self.dataSource = self.lectureListTableViewAdapter;
    self.delegate = self.lectureListTableViewAdapter;
}

- (void)setData:(id)data withParsingType:(ParsingType)parsingType{
    [self.lectureListTableViewAdapter parsingLectureListData:data withParsingType:parsingType];
}

@end
