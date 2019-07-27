//
//  KNALectureTableViewAdapter.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KNXmlParser.h"

@class KNParentViewController;

@protocol KNALectureTableViewAdapterDelegate

- (NSString *)clubNm;

@end

@protocol KNALectureTableViewAdapterAddNoDataViewDelegate

- (void)addSubViewWithNoDataMsg:(NSString *)noDataMsg;

@end

@interface KNALectureTableViewAdapter : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<KNALectureTableViewAdapterDelegate> delegate;
@property (nonatomic, weak) id<KNALectureTableViewAdapterAddNoDataViewDelegate> addNoDataViewDelegate;
@property (nonatomic, weak) KNParentViewController *aLectureVC;

- (instancetype)initWithIdentifier:(ParsingType)identifier;
- (void)parsingLectureListData:(id)data withParsingType:(ParsingType)parsingType;

@end
