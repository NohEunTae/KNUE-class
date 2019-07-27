//
//  KNNoteDetailNaviController.m
//  KNUEclass
//
//  Created by user on 2018. 2. 21..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNNoteDetailNaviController.h"

@interface KNNoteDetailNaviController ()

@end

@implementation KNNoteDetailNaviController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        if (@available(iOS 10.0, *)) {
            self.navigationBarHidden = YES;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
