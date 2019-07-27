//
//  KNLectureListTableViewAdapter.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KNXmlParser.h"

@class KNLectureListViewController;

@interface KNLectureListTableViewAdapter : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *view;
@property (nonatomic, weak) KNLectureListViewController *lectureListVC;

- (void)parsingLectureListData:(id)data withParsingType:(ParsingType)parsingType;

@end
