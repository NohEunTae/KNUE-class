//
//  KNALectureTableView.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNALectureTableViewAdapter.h"

@interface KNALectureTableView : UITableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style withIdentifier:(ParsingType)identifier withALectureViewContorller:(KNParentViewController *)aLectureViewContorller;
- (KNALectureTableViewAdapter *)aLectureTableViewAdapter;
- (void)setDataSourceWithDelegate;
- (void)setData:(id)data withParsingType:(ParsingType)parsingType;

@end
