//
//  UIImage+SGExtension.h
//  SGBase
//
//  Created by  on 2018/8/29.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SGExtension)

/**
 * 根据颜色生成图片
 */
+ (nullable UIImage *)imageWithColor:(UIColor *)color;
@end
