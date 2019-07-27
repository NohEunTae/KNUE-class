//
//  KNFileListTableView.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 18..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNFileListTableViewAdapter.h"

@interface KNFileListTableView : UITableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style withFileListViewContorller:(KNFileListViewController *)fileListViewController;
- (KNFileListTableViewAdapter *)fileListTableViewAdapter;
- (void)setDataSourceWithDelegate;
- (void)setData:(id)data withParsingType:(ParsingType)parsingType;

@end
