//
//  SGHeader.h
//  SGFreamwoke
//
//  Created by Rowling on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//
/*******************************************使用规范说明***************************************************/
/**
 * 1.当添加新的宏时，请以SG开头，为了不与其他变量名混淆，所有宏定义的名字用下划线分隔关键字命名，不使用驼峰命名。
 * 2.如果是判断类型的宏请统一以 SG_IS+（判断描述）命名。
 */

#ifndef SGBaseMacro_h
#define SGBaseMacro_h
/*******************************************UI相关宏***************************************************/
/**
 * 屏幕宽高
 */
#define SG_SCREEN_BOUNDS     ([UIScreen mainScreen].bounds)
#define SG_SCREEN_WIDTH      ([UIScreen mainScreen].bounds.size.width)
#define SG_SCREEN_HEIGHT     ([UIScreen mainScreen].bounds.size.height)

/**
 * StatusBar的高
 */
#define SG_STATUS_HEIGHT     (CGRectGetMaxY([UIApplication sharedApplication].statusBarFrame))
/**
 * 导航栏的高度
 */
#define SG_NAV_HEIGHT        44
/**
 * 导航栏+状态栏的高度
 */
#define SG_NAVSTA_HEIGHT     (SG_STATUS_HEIGHT + 44)
/**
 * 屏幕下方预留出来的高度  当设备为iphoneX时 该值为34，其他情况下均为0
 * 注：主要是针对iPhoneX，在距离iPhoneX底部布局一些UI控件时，为使得操作不被iPhoneX的横条home键遮挡需要空出来的间隙
 */
#define SG_BOTTOM_SPACE     (SG_IS_IPHONE_X ? 34.0 : 0.0)

/**
 * 颜色
 */
#define SG_COLOR(R,G,B,A)       [UIColor colorWithRed:(R) / 255.0 green:(G) / 255.0 blue:(B) / 255.0 alpha:A]

/**
 * 16进制颜色
 */
#define SG_COLOR_RGB(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 * 16进制颜色+alpha值
 */
#define SG_COLOR_RGB_ALPHA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

/**
 * 系统字体
 */
#define SG_FONT(fontSize)       [UIFont systemFontOfSize:fontSize]
#define SG_BoldFONT(fontSize)   [UIFont boldSystemFontOfSize:fontSize]

/**
 * __weak修饰
 */
#define WeakSelf(type)          __weak typeof(type) weak##type = type;

/*******************************************判断相关宏***************************************************/
/**
 * 判断设备
 * 该判断主要是用于做屏幕适配用，只能判断所属屏幕的规格，并不能精确的判断所属机型。
 */
#define SG_IS_IPHONE_4       ((double)[[UIScreen mainScreen] bounds].size.height == (double )480)
#define SG_IS_IPHONE_5       ((double)[[UIScreen mainScreen] bounds].size.height == (double )568)
#define SG_IS_IPHONE_6       ((double)[[UIScreen mainScreen] bounds].size.height == (double )667)
#define SG_IS_IPHONE_6_PLUS  ((double)[[UIScreen mainScreen] bounds].size.height == (double )736)
#define SG_IS_IPHONE_X       ((double)[[UIScreen mainScreen] bounds].size.height == (double )812)
#define SG_IS_IPhoneX_All    ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)
/**
 * 判断字符串是否为空
 */
#define SG_IS_EMPTY_STR(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

/*******************************************系统相关宏***************************************************/

/**
 * 加载 storyboard
 */
#define SG_VC_STORYBOARD(storyboardName, storyboardId)    [[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateViewControllerWithIdentifier:storyboardId]
/**
 * 获取keyWindow
 */
#define SG_KEYWINDOW            [UIApplication sharedApplication].keyWindow
/**
 * 获取 plist版本号
 */
#define SG_BUNDLE_VERSERION     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/**
 * 获取设备UUID
 */
#define SG_DEVICE_UUId          [[UIDevice currentDevice].identifierForVendor UUIDString]
/**
 * 获取设备系统版本
 */
#define SG_DEVICE_SYSTEM_VERSION    [[[UIDevice currentDevice] systemVersion] floatValue]
/**
 * NSUserDefaults
 */
#define SG_USERDEFAULTS         [NSUserDefaults standardUserDefaults]

/*******************************************调试相关***************************************************/
/**
 * 打印
 */
#if DEBUG
#define SGLog(format, ...) do {                                             \
fprintf(stderr, "<%s : line(%d)> %s\n",     \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                        \
printf("%s\n", [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);           \
fprintf(stderr, "-------------------\n");   \
} while (0)
#else
#define SGLog(format, ...) nil
#endif

#endif /* SGHeader_h */
