//
//  UIView+SGUIView_Extension.h
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 虚线方向
typedef NS_ENUM(NSUInteger, DottedLineDirection) {
    DottedLineDirectionHorizontal,
    DottedLineDirectionVertical
};

@interface UIView (SGExtension)
/*
 * view的x
 **/
@property (assign, nonatomic) CGFloat sgX;
/*
 * view的y
 **/
@property (assign, nonatomic) CGFloat sgY;
/*
 * view的centerX
 **/
@property (assign, nonatomic) CGFloat sgCenterX;
/*
 * view的centerY
 **/
@property (assign, nonatomic) CGFloat sgCenterY;
/*
 * view的width
 **/
@property (assign, nonatomic) CGFloat sgWidth;
/*
 * view的height
 **/
@property (assign, nonatomic) CGFloat sgHeight;
/*
 * view的Size
 **/
@property (assign, nonatomic) CGSize  sgSize;
/*
 * view的Origin
 **/
@property (assign, nonatomic) CGPoint sgOrigin;

/*
 * view的x
 **/
-(UIViewController *)sgController;

/**
 * 添加虚线
 * @param direction   虚线方向： 横 或 竖
 * @param color       虚线颜色
 * @param length      虚线长度
 * @param space       虚线间距
 */
- (void)addDottedLineWithDirection:(DottedLineDirection)direction
                             color:(UIColor *)color
                            length:(CGFloat)length
                             space:(CGFloat)space;

/**
 * 添加虚线边框
 * @param color   虚线颜色
 * @param width   虚线高度
 * @param length  虚线宽度
 * @param space   虚线间距
 */
- (void)addDottedBorderWithColor:(UIColor *)color
                           width:(CGFloat)width
                          length:(CGFloat)length
                           space:(CGFloat)space;

/***************************************** XIB属性 *************************************************/
/**
 * 边框宽度
 */
@property (nonatomic,assign) IBInspectable CGFloat  sgBorderWidth;
/**
 * 边框颜色
 */
@property (nonatomic,assign) IBInspectable UIColor  *sgBorderColor;
/**
 * 圆角度数
 */
@property (nonatomic,assign) IBInspectable CGFloat  sgCornerRadius;
/**
 * 边框颜色
 */
@property (nonatomic,assign) IBInspectable BOOL     sgMasksToBounds;
@end





