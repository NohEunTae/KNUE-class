//
//  ViewController.h
//  KNUEclass
//
//  Created by user on 2018. 2. 14..
//  Copyright © 2018년 user. All rights reserved.
//

#import "KNParentViewController.h"

@protocol KNLoginViewContollerDelegate

- (BOOL)checkTextfieldUserInfoWithKeychainAccount:(NSString *)account withPassworkd:(NSString *)password;

@end

@interface KNLoginViewController : KNParentViewController

@property (nonatomic, strong) id<KNLoginViewContollerDelegate> delegate;

@end

