//
//  KNPublicCustomTableViewCell.h
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNPublicCustomTableViewCell : UITableViewCell

- (void)modifyTitleLabel:(NSString *)titleText withContLabel:(NSString *)contText;
- (NSString *)titlaLabelText;

@end
