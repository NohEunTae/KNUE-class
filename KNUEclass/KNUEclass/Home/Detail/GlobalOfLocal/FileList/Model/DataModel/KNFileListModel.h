//
//  KNFileListDataModel.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 18..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KNParentHomeModel.h"

@interface KNFileListModel : KNParentHomeModel 

@property (nonatomic, strong) NSString *regiDttm, *fileSeq, *downCnt, *regiFileNm, *workSeq;

@end
