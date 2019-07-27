//
//  KNFileListViewController.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 18..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNParentViewController.h"

@class KNFileListParamModel;

@interface KNFileListViewController : KNParentViewController

- (instancetype)initWithParamModel:(KNFileListParamModel *)paramModel;
- (void)connectLoginSessionAndReloadView;

@end
