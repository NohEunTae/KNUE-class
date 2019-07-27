//
//  KNALectureTabBarController.h
//  KNUEclass
//
//  Created by user on 2018. 2. 22..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNParentTabBarController.h"

@class KNALectureNoticeViewController, KNALectureNoteViewController, KNALectureHomeworkViewController;

@interface KNALectureTabBarController : KNParentTabBarController

- (void)setLectureListTabBarWithNoticeVC:(KNALectureNoticeViewController *)aLectureNoticeVC withNoteVC:(KNALectureNoteViewController *)aLectureNoteVC withHwVC:(KNALectureHomeworkViewController *)aLectureHwVC;

@end
