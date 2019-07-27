//
//  KNRecentTableView.h
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNRecentTableViewAdapter.h"

@protocol KNRecentTableViewDelegate

- (void)refreshTable;

@end

@interface KNRecentTableView : UITableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style withRecentViewController:(KNRecentViewController *)recentViewController;
- (void)setDataSourceWithDelegate;
- (void)setData:(id)data withParsingType:(ParsingType)parsingType;

@property (nonatomic, weak) id <KNRecentTableViewDelegate> refreshDelegate;
@property (nonatomic, strong) UIRefreshControl *recentRefresh;

@end
