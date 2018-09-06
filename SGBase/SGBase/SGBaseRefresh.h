//
//  SGBaseRefresh.h
//  SGBase
//
//  Created by  on 2018/8/30.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
typedef NS_ENUM(NSUInteger, BHLoadType) {
    BHLoadTypRefresh = 0,   //刷新
    BHLoadTypeMore = 1, //加载
};

@interface SGBaseRefresh : UIView

#pragma mark - 下拉刷新
/**
 * 创建normalRefreshHeader
 */
+ (MJRefreshNormalHeader *)addBH_NormalRefreshHeaderWithBlock:(MJRefreshComponentRefreshingBlock)block;

/**
 * 创建自定义refreshHeader
 */
+ (MJRefreshGifHeader *)addBH_CustomRefreshHeaderWithBlock:(MJRefreshComponentRefreshingBlock)block;

#pragma mark - 上拉加载
/**
 * 创建自动加载的normalRefreshFooter
 */
+ (MJRefreshAutoNormalFooter *)addBH_AutoNormalFooterWithBlock:(MJRefreshComponentRefreshingBlock)block;

/**
 * 创建返回加载的normalRefreshFooter
 */
+ (MJRefreshBackNormalFooter *)addBH_BackNormalFooterWithBlock:(MJRefreshComponentRefreshingBlock)block;

/**
 * 创建自动加载的自定义refreshFooter
 */
+ (MJRefreshAutoGifFooter *)addBH_AutoCustomFooterWithBlock:(MJRefreshComponentRefreshingBlock)block;

/**
 * 创建返回自定义的refreshFooter
 */
+ (MJRefreshBackGifFooter *)addBH_BackCustomFooterWithBlock:(MJRefreshComponentRefreshingBlock)block;

@end
