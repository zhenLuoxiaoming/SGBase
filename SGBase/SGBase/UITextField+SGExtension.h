//
//  UITextField+SGExtension.h
//  SGBase
//
//  Created by  on 2018/8/29.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SGExtension)<UITextFieldDelegate>

/**
 * 最多字数
 */
@property (nonatomic, assign)IBInspectable NSUInteger sgMaxLength;

/**
 *  PlaceHolder 字体颜色
 */
@property (nonatomic, strong)IBInspectable UIColor    *sgPlaceHolderColor;

@end
