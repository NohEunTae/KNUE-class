//
//  KNFileListDataModel.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 18..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNFileListModel.h"

@interface KNFileListModel ()

@property (nonatomic, strong) NSString *mainContent, *subContent;

@end

@implementation KNFileListModel

- (void)setMainContentAndSubContent {
    if(self.regiFileNm) {
        self.mainContent = self.regiFileNm;
        NSString *result_date;
        if(![self.regiDttm isEqualToString:@""]){
            NSRange range1 = NSMakeRange(2, 2);
            NSRange range2 = NSMakeRange(5, 2);
            NSRange range3 = NSMakeRange(8, 2);
            NSString *date = self.regiDttm;
            result_date = [NSString stringWithFormat:@"%@.%@.%@",[date substringWithRange:range1],
                           [date substringWithRange:range2],
                           [date substringWithRange:range3]];
        }
        self.subContent = [NSString stringWithFormat:@"%@   다운로드수 : %@", result_date, self.downCnt];
    }
}

@end 
