//
//  KNFileBoxTableView.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 21..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNFileBoxTableView.h"
#import "KNNoDataView.h"

@interface KNFileBoxTableView () <KNFileBoxTableViewAdapterDelegate>

@end

@implementation KNFileBoxTableView

#pragma mark File Box Table View

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        _fileBoxTableViewAdapter = [[KNFileBoxTableViewAdapter alloc] init];
        _fileBoxTableViewAdapter.delegate = self;
    }
    return self;
}

- (void)setDataSourceWithDelegate {
    self.dataSource = self.fileBoxTableViewAdapter;
    self.delegate = self.fileBoxTableViewAdapter;
}

- (void)setFileData {
    [self.fileBoxTableViewAdapter setFileBoxData];
}

- (void)addSubViewWithNoDataMsg:(NSString *)msg {
    KNNoDataView *noDataView = [[KNNoDataView alloc] initWithFrame:self.frame withMsg:msg];
    [self addSubview: noDataView];
}

@end
