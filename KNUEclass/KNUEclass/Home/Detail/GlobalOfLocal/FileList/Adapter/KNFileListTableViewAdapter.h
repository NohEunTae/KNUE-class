//
//  KNFileListTableViewAdapter.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 18..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KNXmlParser.h"

@class KNFileListViewController;

@protocol KNFileListTableViewAdapterDelegate

- (id)getViewController;

@end

@interface KNFileListTableViewAdapter : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<KNFileListTableViewAdapterDelegate> delegate;
@property (nonatomic, weak) KNFileListViewController *fileListVC;

- (void)parsingFileListData:(id)data withParsingType:(ParsingType)parsingType;

@end
