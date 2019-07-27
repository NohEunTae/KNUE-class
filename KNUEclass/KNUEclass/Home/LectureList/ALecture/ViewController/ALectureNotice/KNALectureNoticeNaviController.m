//
//  KNALectureNoticeNaviController.m
//  KNUEclass
//
//  Created by user on 2018. 2. 21..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNALectureNoticeNaviController.h"
#import "KNImageManager.h"

@interface KNALectureNoticeNaviController ()

@end

@implementation KNALectureNoticeNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.navigationBarHidden = YES;
    }
    self.tabBarItem.title = @"공지사항";
    UIImage *image = [UIImage imageNamed:@"notice"];
    self.tabBarItem.image = [[KNImageManager resizeTabBarIconImageWithImageWithImage:image scaledToSize:CGSizeMake(50, 50)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
