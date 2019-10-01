//
//  UITextView+SGExtension.h
//  SGBase
//
//  Created by  on 2018/8/29.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (SGExtension)
/**
 *  UITextView+placeholder
 */
@property (nonatomic, copy) NSString *sgPlaceHolder;
/**
 *  IQKeyboardManager等第三方框架会读取placeholder属性并创建UIToolbar展示
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  placeHolder颜色
 */
@property (nonatomic, strong) UIColor *sgPlaceHolderColor;

/**
 *  最多字数
 */
@property (assign, nonatomic) NSInteger  maxLength;

@end
