//
//  KNIndicator.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KNIndicator : UIView

- (instancetype)initWithTarget:(UIView *)targetView;
- (void)startIndicator;
- (void)stopIndicator;

@end
