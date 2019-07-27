//
//  KNALectureTableView.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNALectureTableView.h"
#import "KNNoDataView.h"

@interface KNALectureTableView () <KNALectureTableViewAdapterAddNoDataViewDelegate>

@property (nonatomic, strong) KNALectureTableViewAdapter *aLectureTableViewAdapter;

@end

@implementation KNALectureTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style withIdentifier:(ParsingType)identifier withALectureViewContorller:(KNParentViewController *)aLectureViewContorller {
    self = [super initWithFrame:frame style:style];
    if (self) {
        _aLectureTableViewAdapter = [[KNALectureTableViewAdapter alloc] initWithIdentifier:identifier];
        _aLectureTableViewAdapter.aLectureVC = aLectureViewContorller;
        _aLectureTableViewAdapter.addNoDataViewDelegate = self;
    }

    return self;
}

#pragma Recent Table View Set

- (void)setDataSourceWithDelegate {
    self.dataSource = self.aLectureTableViewAdapter;
    self.delegate = self.aLectureTableViewAdapter;
}

- (void)setData:(id)data withParsingType:(ParsingType)parsingType{
    [self.aLectureTableViewAdapter parsingLectureListData:data withParsingType:parsingType];
}

- (void)addSubViewWithNoDataMsg:(NSString *)msg {
    KNNoDataView *noDataView = [[KNNoDataView alloc] initWithFrame:self.frame withMsg:msg];
    [self addSubview: noDataView];
}

@end
