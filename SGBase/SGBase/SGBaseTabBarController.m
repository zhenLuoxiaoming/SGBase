//
//  SGBaseTabBarController.m
//  SGBase
//
//  Created by  on 2018/8/29.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "SGBaseTabBarController.h"
#import "SGBase.h"
#import "ViewController.h"

@interface SGBaseTabBarController ()

@end

@implementation SGBaseTabBarController

- (void)setTabBarBgImg:(UIImage *)tabBarBgImg{
    if (tabBarBgImg) {
        self.tabBar.backgroundImage = tabBarBgImg;
    }
}

- (void)setTabBarShadowColor:(UIColor *)tabBarShadowColor{
    if (tabBarShadowColor) {
        self.tabBar.shadowImage = [UIImage imageWithColor:tabBarShadowColor];        
    }
}

- (void)setControls:(NSArray *)controls{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<controls.count; i++) {
        SGBaseNavigationController *nav  = [[SGBaseNavigationController alloc] initWithRootViewController:controls[i]];
        [self controller:controls[i] Title:self.itemTitles[i] itemImage:self.itemImages[i] itemSelectImage:self.itemSelectImages[i] itemImgInset:[self.itemIndex intValue] == i ? self.itemImageInset : 0];
        [arr addObject:nav];
    }
    self.viewControllers = arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)controller:(UIViewController *)controller Title:(NSString *)title itemImage:(NSString *)image itemSelectImage:(NSString *)selectImage itemImgInset:(CGFloat)insets{
    controller.tabBarItem.imageInsets = UIEdgeInsetsMake(-insets, 0, insets, 0);
    controller.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:image];
    // 设置 tabbarItem 选中状态的图片(不被系统默认渲染,显示图像原始颜色)
    UIImage *imageHome = [UIImage imageNamed:selectImage];
    imageHome = [imageHome imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [controller.tabBarItem setSelectedImage:imageHome];
    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
    NSDictionary *selectTitStyle = [NSDictionary dictionaryWithObject:self.tabBarItemSelectColor ? self.tabBarItemSelectColor : [UIColor redColor] forKey:NSForegroundColorAttributeName];
    [controller.tabBarItem setTitleTextAttributes:selectTitStyle forState:UIControlStateSelected];
    NSDictionary *defTitStyle = [NSDictionary dictionaryWithObject:self.tabBarItemColor ? self.tabBarItemColor : [UIColor grayColor] forKey:NSForegroundColorAttributeName];
    [controller.tabBarItem setTitleTextAttributes:defTitStyle forState:UIControlStateNormal];
}

@end
