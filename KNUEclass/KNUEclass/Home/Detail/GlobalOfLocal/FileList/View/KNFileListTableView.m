//
//  KNFileListTableView.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 18..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNFileListTableView.h"
#import "KNFileListTableViewAdapter.h"
#import "KNPublicCustomTableViewCell.h"

@interface KNFileListTableView ()

@property (nonatomic, strong) KNFileListTableViewAdapter *fileListTableViewAdapter;

@end

@implementation KNFileListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style withFileListViewContorller:(KNFileListViewController *)fileListViewController {
    self = [super initWithFrame:frame style:style];

    if (self) {
        _fileListTableViewAdapter = [[KNFileListTableViewAdapter alloc] init];
        _fileListTableViewAdapter.fileListVC = fileListViewController;
    }

    return self;
}

#pragma File List Table View Set

- (void)setDataSourceWithDelegate {
    self.dataSource = self.fileListTableViewAdapter;
    self.delegate = self.fileListTableViewAdapter;
}

- (void)setData:(id)data withParsingType:(ParsingType)parsingType{ 
    [self.fileListTableViewAdapter parsingFileListData:data withParsingType:parsingType];
}

@end
