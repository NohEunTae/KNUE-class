//
//  ParentModel.m
//  KNUEclass
//
//  Created by user on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNParentHomeModel.h"

@interface KNParentHomeModel ()

@property (nonatomic, strong) NSString *mainContent, *subContent;

@end

@implementation KNParentHomeModel

#pragma mark Default Main Content And Sub Content

- (void)setMainContentAndSubContent {
    self.mainContent = @"데이터가 없습니다.";
    self.subContent = @"";
}

@end
