//
//  KNALectureTabBarController.m
//  KNUEclass
//
//  Created by user on 2018. 2. 22..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNALectureTabBarController.h"
#import "KNALectureNoticeNaviController.h"
#import "KNALectureNoteNaviController.h"
#import "KNALectureHomeworkNaviController.h"
#import "KNALectureNoticeViewController.h"
#import "KNALectureNoteViewController.h"
#import "KNALectureHomeworkViewController.h"
#import "KNImageManager.h"

@implementation KNALectureTabBarController

#pragma mark Lecture Tab Bar LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.selectedColor = [UIImage imageNamed:@"blueBackground"];
    self.selectedColor = [KNImageManager resizeTabBarBackgroundImageWithImage:self.selectedColor
                                                          withHeight:self.tabBar.frame.size.height
                                                           withWidth:self.tabBar.frame.size.width / 3];
    [self.tabBar setSelectionIndicatorImage:self.selectedColor];
}

#pragma mark Lecture List Tab Bar Set

- (void)setLectureListTabBarWithNoticeVC:(KNALectureNoticeViewController *)aLectureNoticeVC withNoteVC:(KNALectureNoteViewController *)aLectureNoteVC withHwVC:(KNALectureHomeworkViewController *)aLectureHwVC {
    KNALectureNoticeNaviController *aLectureNoticeNV = [[KNALectureNoticeNaviController alloc]
                                                        initWithRootViewController:aLectureNoticeVC];
    KNALectureNoteNaviController *aLectureNoteNV = [[KNALectureNoteNaviController alloc]
                                                      initWithRootViewController:aLectureNoteVC];
    KNALectureHomeworkNaviController *aLectureHomeworkNV = [[KNALectureHomeworkNaviController alloc]
                                                          initWithRootViewController:aLectureHwVC];
    self.nvList = @[aLectureNoticeNV, aLectureNoteNV, aLectureHomeworkNV];
    [self setViewControllers:self.nvList];
}

@end
