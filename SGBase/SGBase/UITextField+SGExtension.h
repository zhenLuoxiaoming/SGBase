//
//  UITextField+SGExtension.h
//  SGBase
//
//  Created by  on 2018/8/29.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SGExtension)<UITextFieldDelegate>
@property (nonatomic, assign)IBInspectable NSUInteger sgMaxLength;
@property (nonatomic, strong)IBInspectable UIColor    *sgPlaceHolderColor;
@end
