//
//  KNFileBoxTableView.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 21..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNFileBoxTableViewAdapter.h"

@interface KNFileBoxTableView : UITableView

@property (nonatomic, strong) KNFileBoxTableViewAdapter *fileBoxTableViewAdapter;

- (void)setDataSourceWithDelegate;
- (void)setFileData;

@end

