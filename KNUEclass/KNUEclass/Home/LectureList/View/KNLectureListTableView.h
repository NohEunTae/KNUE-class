//
//  KNLectureListTableView.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNLectureListTableViewAdapter.h"

@protocol KNLecutreListTableViewDelegate

- (void)refreshTable;

@end

@interface KNLectureListTableView : UITableView

@property (nonatomic, strong) UIRefreshControl *lectureRefreshControl;
@property (nonatomic, weak) id <KNLecutreListTableViewDelegate> lectureListRefreshDelegate;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style withLectureListViewController:(KNLectureListViewController *)lectureListViewContorller;
- (KNLectureListTableViewAdapter *)lectureListTableViewAdapter;
- (void)setDataSourceWithDelegate;
- (void)setData:(id)data withParsingType:(ParsingType)parsingType; 

@end
