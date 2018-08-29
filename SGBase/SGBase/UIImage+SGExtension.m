//
//  UIImage+SGExtension.m
//  SGBase
//
//  Created by  on 2018/8/29.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "UIImage+SGExtension.h"

@implementation UIImage (SGExtension)
+ (UIImage *)imageWithColor:(UIColor *)color {
    if (!color) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
