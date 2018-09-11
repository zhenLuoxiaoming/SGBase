//
//  SGNoDataView.m
//  IQKeyboardManager
//
//  Created by  on 2018/9/8.
//

#import "SGNoDataView.h"
#import "SGBaseMacro.h"
#import "UIView+SGExtension.h"

@interface SGNoDataView()
@property (nonatomic, copy) NSString    *imgName;           // 图片名称
@property (nonatomic, copy) NSString    *remindStr;         // 提示文字
@property (nonatomic, assign) BOOL      isShow;             // 是否显示按钮
@property (nonatomic, copy) NSString    *btnText;           // 按钮文字

@end

@implementation SGNoDataView

- (instancetype)initWithFrame:(CGRect)frame imgName:(NSString *)imgName remindStr:(NSString *)remindStr isShowBtn:(BOOL)isShow{
    if (self == [super initWithFrame:frame]) {
        self.frame           = frame;
        self.backgroundColor = SG_COLOR_RGB(0xF7F7F7);
        _imgName             = imgName;
        _remindStr           = remindStr?remindStr:@"暂无数据";
        _isShow              = isShow;
        [self setUpInterFace];
    }
    return self;
}
#pragma mark * 构建UI
- (void)setUpInterFace{
    UIImageView *imgV       = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, 140, 140)];
    imgV.sgCenterX          = self.sgCenterX;
    imgV.image              = [UIImage imageNamed:_imgName];
    [self addSubview:imgV];
    
    UILabel *noDataLb       = [[UILabel alloc] init];
    noDataLb.text           = _remindStr;
    noDataLb.font           = [UIFont systemFontOfSize:15];
    noDataLb.textColor      = SG_COLOR_RGB(0x999999);
    noDataLb.numberOfLines  = 0;
    noDataLb.textAlignment  = NSTextAlignmentCenter;
    CGSize size             = [noDataLb.text boundingRectWithSize:CGSizeMake(SG_SCREEN_WIDTH-40, MAXFLOAT)
                                                          options:1
                                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                          context:nil].size;
    noDataLb.frame          = CGRectMake(0, _imgName.length==0 ? 100 : imgV.sgBottom+30, size.width, size.height);
    noDataLb.sgCenterX      = imgV.sgCenterX;
    [self addSubview:noDataLb];
    
    UIButton *button        = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame            = CGRectMake(0, noDataLb.sgBottom+20, 100, 40);
    button.sgCenterX        = self.sgCenterX;
    button.titleLabel.font  = [UIFont systemFontOfSize:16];
    button.layer.borderWidth    = 0.5;
    button.layer.cornerRadius   = 5;
    button.layer.borderColor    = SG_COLOR_RGB(0x999999).CGColor;
    [button setTitle:@"重试" forState:UIControlStateNormal];
    [button setTitleColor:SG_COLOR_RGB(0x999999) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_isShow) {
        [self addSubview:button];
    }
}

- (void)buttonClicked:(UIButton *)sender{
    if (self.ButtonClickBlock) {
        self.ButtonClickBlock();
    }
}



@end
