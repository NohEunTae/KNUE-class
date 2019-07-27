//
//  KNDetailCustomView.h
//  KNUEclass
//
//  Created by user on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNDetailCustomView : UIView

- (instancetype)initWithFrame:(CGRect)frame withType:(NSString *)type;

- (void)modifyTitleLabelText:(NSString *)titleText withNickNmbLabelText:(NSString *)nickNmLbText withDateLabelText:(NSString *)dateLbText withViewsLabelText:(NSString *)viewsLbText  withContentTextViewText:(NSString *)contentText;

@end
