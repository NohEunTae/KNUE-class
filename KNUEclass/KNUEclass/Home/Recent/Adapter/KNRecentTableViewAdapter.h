//
//  KNRecentTableViewAdapter.h
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KNXmlParser.h"

@class KNRecentViewController;

@interface KNRecentTableViewAdapter : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) KNRecentViewController *recentVC;

- (void)parsingRecentData:(id)data withParsingType:(ParsingType)parsingType;

@end
