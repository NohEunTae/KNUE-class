//
//  KNLectureListModel.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNLectureListModel : NSObject

@property (nonatomic, strong) NSString *clubNm, *clubId;

- (void)setMainContentAndSubContent;
- (NSString *)mainContent;
- (NSString *)subContent;

@end
