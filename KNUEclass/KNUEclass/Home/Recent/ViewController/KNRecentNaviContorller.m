//
//  KNRecentNaviContorller.m
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNRecentNaviContorller.h"
#import "KNImageManager.h"

@interface KNRecentNaviContorller ()

@end

@implementation KNRecentNaviContorller

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"[info] viewDidLoad .... %@", [self class]);

    if (@available(iOS 11.0, *)) {
        self.navigationBarHidden = YES;
    }
    
    self.tabBarItem.title = @"최근 알림";
    
    UIImage *image = [UIImage imageNamed:@"recent"];
    self.tabBarItem.image = [[KNImageManager resizeTabBarIconImageWithImageWithImage:image scaledToSize:CGSizeMake(50, 50)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
