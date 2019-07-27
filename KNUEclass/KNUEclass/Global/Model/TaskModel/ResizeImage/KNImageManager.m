//
//  KNImageManager.m
//  KNUEclass
//
//  Created by user on 2018. 2. 21..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNImageManager.h"

@implementation KNImageManager

// 카테고리로

#pragma mark Resize Image

+ (UIImage *)resizeImage:(UIImage *)oldImage WithHeighAndWidth:(CGFloat)heightAndWidth {
    UIGraphicsBeginImageContext(CGSizeMake(heightAndWidth, heightAndWidth));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, heightAndWidth);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, heightAndWidth, heightAndWidth), [oldImage CGImage]);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return newImage;
}

+ (UIImage *)resizeTabBarIconImageWithImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage; 
}

+ (UIImage *)resizeTabBarBackgroundImageWithImage:(UIImage *)oldImage withHeight:(CGFloat)height withWidth:(CGFloat)width {
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, height);
    CGContextScaleCTM(context, 1.0, -1.0);

    CGContextDrawImage(context, CGRectMake(0.0, 0.0, width, height), [oldImage CGImage]);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return newImage;
}

@end
