//
//  KNLectureListModel.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNLectureListModel.h"

@interface KNLectureListModel ()

@property (nonatomic, strong) NSString *mainContent, *subContent;

@end

@implementation KNLectureListModel

- (void)setMainContentAndSubContent {
    self.mainContent = self.clubNm;
    self.subContent = [NSString stringWithFormat:@"%@", self.clubId];
}

@end
