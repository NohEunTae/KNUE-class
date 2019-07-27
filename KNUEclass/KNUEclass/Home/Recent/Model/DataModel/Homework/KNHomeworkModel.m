//
//  KNHomeworkModel.m
//  KNUEclass
//
//  Created by user on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNHomeworkModel.h"

@interface KNHomeworkModel ()

@property (nonatomic, strong) NSString *mainContent, *subContent;

@end

@implementation KNHomeworkModel

#pragma mark Hw Model Set Main Content And Sub Content

- (void)setMainContentAndSubContent {
    if(self.workTitle) {
        self.mainContent = self.workTitle;
        NSString *result_date = @"";
        if(![self.workStDt isEqualToString:@""]){
        NSRange range1 = NSMakeRange(2, 2);
        NSRange range2 = NSMakeRange(4, 2);
        NSRange range3 = NSMakeRange(6, 2);
        NSString *date1 = self.workStDt;
        NSString *date2 = self.workEdDt;
        result_date = [NSString stringWithFormat:@"%@.%@.%@ ~ %@.%@.%@",
                                 [date1 substringWithRange:range1],
                                 [date1 substringWithRange:range2],
                                 [date1 substringWithRange:range3],
                                 [date2 substringWithRange:range1],
                                 [date2 substringWithRange:range2],
                                 [date2 substringWithRange:range3]];
        }
        self.subContent = [NSString stringWithFormat:@"%@  %@", self.clubNm, result_date];
    }
}

@end
