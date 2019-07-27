//
//  InfoView.h
//  KNUEclass
//
//  Created by user on 2018. 2. 19..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KNLoginInfoView <NSObject> //KNLoginInfoViewDelegate

@required

- (void)startLoginProcessWithAccount:(NSString *)account withPassword:(NSString *)password;

@end

@interface KNLoginInfoView : UIView

@property (nonatomic, strong) UITextField *accountTf, *passwordTf;
@property (nonatomic, weak) id<KNLoginInfoView> delegate;

- (void)loginBtnPressed;
- (void)setLoginButtonEnable:(BOOL)flag;

@end
