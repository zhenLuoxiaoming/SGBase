//
//  SGBaseNetConfig.h
//  SGBase
//
//  Created by  on 2018/9/11.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface SGBaseNetConfig : NSObject
singleton_interface(SGBaseNetConfig)

/** 状态码 key，默认code*/
@property (copy, nonatomic) NSString *statusKey;

/** 请求成功状态码，默认 0*/
@property (assign, nonatomic) NSInteger requestSuccessStatusCode;

/** 请求失败提示文字，默认是“请求失败”
 *  注：此失败非 requestSuccessCode != 0 的情况
 */
@property (copy, nonatomic) NSString *requestErrorString;


@end
