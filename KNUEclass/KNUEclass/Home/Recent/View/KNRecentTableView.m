//
//  KNRecentTableView.m
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNRecentTableView.h"

@class KNRecentNaviContorller;

@interface KNRecentTableView ()

@property (nonatomic, strong) KNRecentTableViewAdapter *recentTableViewAdapter;

@end

@implementation KNRecentTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style withRecentViewController:(KNRecentViewController *)recentViewController {
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        _recentTableViewAdapter = [[KNRecentTableViewAdapter alloc] init];
        _recentTableViewAdapter.recentVC = recentViewController;
        _recentRefresh = [[UIRefreshControl alloc] init];
        [self addSubview:_recentRefresh];
        [_recentRefresh addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
        _recentRefresh.tintColor = [UIColor colorWithRed:0.25f green:0.72f blue:0.85f alpha:1.0];
    }
    
    return self;
}

- (void)refreshTable {
    NSLog(@"[info] table refreshed .... %@", [self class]);
    [self.recentRefresh beginRefreshing];
    [self.refreshDelegate refreshTable];
}

#pragma Recent Table View Set

- (void)setDataSourceWithDelegate {
    self.dataSource = self.recentTableViewAdapter;
    self.delegate = self.recentTableViewAdapter;
}

- (void)setData:(id)data withParsingType:(ParsingType)parsingType{
    [self.recentTableViewAdapter parsingRecentData:data withParsingType:parsingType];
}

@end
