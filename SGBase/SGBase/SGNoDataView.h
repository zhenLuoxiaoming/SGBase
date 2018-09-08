//
//  SGNoDataView.h
//  IQKeyboardManager
//
//  Created by  on 2018/9/8.
//

#import <UIKit/UIKit.h>

@interface SGNoDataView : UIView
/** 按钮回调*/
@property (nonatomic, copy) void (^ButtonClickBlock)(void);

- (instancetype)initWithFrame:(CGRect)frame imgName:(NSString *)imgName remindStr:(NSString *)remindStr isShowBtn:(BOOL)isShow;

@end
