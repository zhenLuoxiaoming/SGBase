//
//  SGAppHelper.h
//  SGFreamwoke
//
//  Created by Rowling on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SGAppHelper : NSObject
/**
 * 当前时间戳
 **/
+ (long long)currentTime;

/**
 * 将view的内容生成一张图片
 **/
+(UIImage *)imageWithCaputureView:(UIView *)view;

/**
 * 裁剪某个图片的某一个区域
 */
+(UIImage *)clipWithImageRect:(CGRect)clipRect clipImage:(UIImage *)clipImage;

/**
 * 压缩图片
 */
+(UIImage *)litleImage:(UIImage *)myimage;

/**
 * 生成二维码
 **/
+(UIImage *)QRcodeWithStr:(NSString *)str;

/**
 * json字符串转字典
 **/
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 * 数组转json字符串
 */
+(NSString *)arrayToJSONString:(NSArray *)array;

/**
 * json字符串转字典
 */
+(NSDictionary *)dicWithjasonSring:(NSString *)str;

/**
 * 加载storyBoard
 */
+(UIViewController *)loadStoryBoradSBID:(NSString *)SBID VCID:(NSString *)VCID;

/**
 * 优化后的打电话
 */
+ (void)callPhoneStr:(NSString*)phoneStr  withVC:(UIViewController *)selfvc;

/**
 * 当前设备型号
 **/
+ (NSString *)getCurrentDeviceModel;

/****************************************时间相关*******************************************/
/**
 * 时间戳转时间字符串(秒)
 **/
+(NSString *)TimeStampFromStr:(long long)stamp;

/**
 * 时间戳转时间字符串（毫秒）
 */
+(NSString *)TimeStampFromStrMS:(long long)stamp;

/**
 * 时间戳转自定义格式化时间字符串 (毫秒)
 */
+(NSString *)TimeStampFromStrMS:(long long)stamp FormaterStr:(NSString *)formaterStr;

/**
 * 距离现在的时间
 **/
+(NSString *)dateFormNow:(NSString *)dateStr;

/**
 * 传入date类型值 返回一个自定义格式化的字符串
 */
+(NSString *)dateStr:(NSDate *)date andFormatterStr:(NSString *)FormatterStr;

/**
 * 星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

/**
 设置某个视图某些角圆角
 @param view 视图
 @param corners 需要设置的圆角
 @param num 圆角度数，传0取view高度一半
 */
+ (CAShapeLayer *)setFillet:(UIView *)view withByRoundingCorners:(UIRectCorner)corners withReadii:(CGFloat)num;

/**
 判断输入价格是否合法
 @param number 当前字符
 @param textFieldText 输入框字符
 @param floatCount 小数位数
 */
+ (BOOL)validateNumber:(NSString*)number text:(NSString *)textFieldText floatCount:(NSInteger)floatCount;


/**
 获取验证码倒计时
 @param timeCount 倒计时
 @param btn 按钮
 */
+ (void)countdownTimeCount:(NSInteger)timeCount withButton:(UIButton *)btn;

@end
