//
//  SGBaseRefresh.m
//  SGBase
//
//  Created by  on 2018/8/30.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "SGBaseRefresh.h"
#import "MJRefresh.h"
@implementation SGBaseRefresh

#pragma mark - 刷新
+ (MJRefreshNormalHeader *)addBH_NormalRefreshHeaderWithBlock:(MJRefreshComponentRefreshingBlock)block {
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    refreshHeader.stateLabel.hidden = YES;
    refreshHeader.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    return refreshHeader;
}

+ (MJRefreshGifHeader *)addBH_CustomRefreshHeaderWithBlock:(MJRefreshComponentRefreshingBlock)block {
    MJRefreshGifHeader *refreshHeader = [MJRefreshGifHeader headerWithRefreshingBlock:block];
    //  设置gif图片数组
    return refreshHeader;
}

#pragma mark - 加载
+ (MJRefreshAutoNormalFooter *)addBH_AutoNormalFooterWithBlock:(MJRefreshComponentRefreshingBlock)block {
    MJRefreshAutoNormalFooter *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
    //  设置
    return refreshFooter;
}

+ (MJRefreshBackNormalFooter *)addBH_BackNormalFooterWithBlock:(MJRefreshComponentRefreshingBlock)block {
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:block];
    return refreshFooter;
}

+ (MJRefreshAutoGifFooter *)addBH_AutoCustomFooterWithBlock:(MJRefreshComponentRefreshingBlock)block {
    MJRefreshAutoGifFooter *refreshFooter = [MJRefreshAutoGifFooter footerWithRefreshingBlock:block];
    //  按状态设置图片数组
    return refreshFooter;
}

+ (MJRefreshBackGifFooter *)addBH_BackCustomFooterWithBlock:(MJRefreshComponentRefreshingBlock)block {
    MJRefreshBackGifFooter *refreshFooter = [MJRefreshBackGifFooter footerWithRefreshingBlock:block];
    return refreshFooter;
}

@end
