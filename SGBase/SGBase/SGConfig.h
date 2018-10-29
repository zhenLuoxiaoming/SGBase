//
//  SGConfig.h
//  SGBase
//
//  Created by 罗晓明 on 2018/9/6.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SGConfig : NSObject
/**
 * 框架配置文件单例
 */
+(instancetype)shareInstance;
/**
 * 全局base类控制器导航栏左按钮返回图片的名字
 */
@property(nonatomic,strong)NSString * backImageName;
/**
 * 全局base导航标题字体
 */
@property(nonatomic,strong)UIFont * navTitleFont;
/**
 * 全局base导航标题颜色
 */
@property(nonatomic,strong)UIColor * navTileColor;

/**
 * 是否隐藏导航栏的那根黑线 YES:隐藏 NO:显示, 默认 YES
 * 注:在viewDidload里面设置好.
 */
@property (nonatomic,assign) BOOL hideNavLine;

/** 导航背景图片*/
@property (copy, nonatomic) NSString *navBgImg;

@end
