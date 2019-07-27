//
//  KNLectureListNaviController.m
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNLectureListNaviController.h"
#import "KNLectureListViewController.h"
#import "KNImageManager.h"
#import "KNImageManager.h"

@implementation KNLectureListNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.navigationBarHidden = YES;
    }
    self.tabBarItem.title = @"수강현황";
    UIImage *image = [UIImage imageNamed:@"lecture_list"];
    self.tabBarItem.image = [[KNImageManager resizeTabBarIconImageWithImageWithImage:image scaledToSize:CGSizeMake(50, 50)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
