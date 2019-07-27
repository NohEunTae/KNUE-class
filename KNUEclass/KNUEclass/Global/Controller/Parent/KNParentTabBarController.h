//
//  KNParentTabBarController.h
//  KNUEclass
//
//  Created by user on 2018. 2. 14..
//  Copyright © 2018년 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KNParentNaviController;

@interface KNParentTabBarController : UITabBarController

@property (nonatomic, strong) NSArray <KNParentNaviController *> *nvList;
@property (nonatomic, strong) UIImage *selectedColor;

@end
