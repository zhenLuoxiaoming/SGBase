//
//  UIColor+SGExtension.h
//  SGFreamwoke
//
//  Created by Rowling on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SGExtension)
/**
 * 16进制颜色初始化方法
 */
+ (UIColor*)sgColorForHex:(NSString*)hexColor;

/**
 * rgba
 */
+ (UIColor*)sgColorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;

@end
