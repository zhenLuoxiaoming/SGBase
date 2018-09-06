//
//  SGConfig.m
//  SGBase
//
//  Created by 罗晓明 on 2018/9/6.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "SGConfig.h"

@implementation SGConfig
+(instancetype)shareInstance {
    static SGConfig * mananger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mananger = [[SGConfig alloc]init];
        mananger.navTileColor = [UIColor blackColor];
        mananger.navTitleFont = [UIFont systemFontOfSize:17];
        mananger.hideNavLine  = YES;
    });
    return mananger;
}


@end
