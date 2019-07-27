//
//  KNImageManager.h
//  KNUEclass
//
//  Created by user on 2018. 2. 21..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KNImageManager : NSObject

+ (UIImage *)resizeTabBarIconImageWithImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)resizeImage:(UIImage *)oldImage WithHeighAndWidth:(CGFloat)heightAndWidth;
+ (UIImage *)resizeTabBarBackgroundImageWithImage:(UIImage *)image withHeight:(CGFloat)height withWidth:(CGFloat)width;

@end
