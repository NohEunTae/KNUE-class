//
//  KNNoteModel.m
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNNoteModel.h"

@interface KNNoteModel ()

@property (nonatomic, strong) NSString *mainContent, *subContent;

@end

@implementation KNNoteModel

#pragma mark Note Model Set Main Content And Sub Content

- (void)setMainContentAndSubContent {
    if(self.title) {
        self.mainContent = self.title;
        NSString *result_date = @"";
        if(![self.openStDt isEqualToString:@""]){
        NSRange range1 = NSMakeRange(2, 2);
        NSRange range2 = NSMakeRange(5, 2);
        NSRange range3 = NSMakeRange(8, 2);
        NSString *date = self.openStDt;
        result_date = [NSString stringWithFormat:@"%@.%@.%@",[date substringWithRange:range1],
                                 [date substringWithRange:range2],
                                 [date substringWithRange:range3]];
        }
        self.subContent = [NSString stringWithFormat:@"%@   %@", self.clubNm, result_date];
    }
}

@end
