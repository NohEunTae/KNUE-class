//
//  KNALectureNoteNaviController.m
//  KNUEclass
//
//  Created by user on 2018. 2. 21..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNALectureNoteNaviController.h"
#import "KNImageManager.h"

@interface KNALectureNoteNaviController ()

@end

@implementation KNALectureNoteNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.navigationBarHidden = YES;
    }
    self.tabBarItem.title = @"강의노트";
    UIImage *image = [UIImage imageNamed:@"note"];
    self.tabBarItem.image = [[KNImageManager resizeTabBarIconImageWithImageWithImage:image scaledToSize:CGSizeMake(50, 50)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
