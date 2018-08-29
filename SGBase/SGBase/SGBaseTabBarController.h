//
//  SGBaseTabBarController.h
//  SGBase
//
//  Created by  on 2018/8/29.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGBaseTabBarController : UITabBarController

/** item默认图片*/
@property (copy, nonatomic) NSArray *itemImages;
/** item选中图片*/
@property (copy, nonatomic) NSArray *itemSelectImages;
/** item名字*/
@property (copy, nonatomic) NSArray *itemTitles;

/** item图片上偏移量*/
@property (assign, nonatomic) CGFloat itemImageInset;
/** 突出item下标，
 *  图标超出tabbar的特殊item
 */
@property (copy, nonatomic) NSString  *itemIndex;

/** controllers
 *  注：先为图片和文字赋值，最后controls赋值
 */
@property (copy, nonatomic) NSArray *controls;

/** 默认字体颜色(默认灰色)*/
@property (copy, nonatomic) UIColor *tabBarItemColor;
/** 选中字体颜色(默认红色)*/
@property (copy, nonatomic) UIColor *tabBarItemSelectColor;

/** tabBar线条颜色，默认是系统的*/
@property (copy, nonatomic) UIColor *tabBarShadowColor;

/** tabBar背景图片,默认是系统的
 *  如果是纯色背景，用 [UIImage imageWithColor:color] 进行转换
 */
@property (copy, nonatomic) UIImage *tabBarBgImg;

@end
