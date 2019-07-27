//
//  KNFileBoxTableViewAdapter.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 21..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol KNFileBoxTableViewAdapterDelegate

- (void)addSubViewWithNoDataMsg:(NSString *)noDataMsg;

@end

@interface KNFileBoxTableViewAdapter : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) id<KNFileBoxTableViewAdapterDelegate> delegate;

- (void)setFileBoxData;

@end
