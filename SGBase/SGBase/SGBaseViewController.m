//
//  SGBaseViewController.m
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "SGBaseViewController.h"
#import "SGBaseMacro.h"
#import "UIView+SGExtension.h"
#import "SGConfig.h"
#import "SGNoDataView.h"

@interface SGBaseViewController ()

@property (weak, nonatomic) SGNoDataView *noDataView;;

@end

@implementation SGBaseViewController
#pragma -mark:BaseTabelView懒加载及相关设置与代理绑定
-(UITableView *)BaseTableView {
    if (_BaseTableView == nil) {
        CGRect tableFrame;
        if (self.navigationController) {
            tableFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - SG_NAVSTA_HEIGHT -SG_BOTTOM_SPACE) ;
        }else {
            tableFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) ;
        }
        _BaseTableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
        _BaseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _BaseTableView.delegate = self;
        _BaseTableView.dataSource = self;
        _BaseTableView.tableFooterView = [[UIView alloc]init];
        _BaseTableView.estimatedSectionFooterHeight = 0;
        _BaseTableView.estimatedSectionHeaderHeight = 0;
        _BaseTableView.estimatedRowHeight = 0;
        _BaseTableView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11.0, *)){
            _BaseTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _BaseTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    return cell;
}

#pragma -mark:隐藏导航栏的那根黑线
//隐藏line
- (void)NavgationBarLineHidden:(BOOL)hidden {
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)])
    {
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list)
        {
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
            {//10.0的系统字段不一样
                UIView *view =   (UIView*)obj;
                for (id obj2 in view.subviews) {
                    if ([obj2 isKindOfClass:[UIImageView class]])
                    {
                        UIImageView *image =  (UIImageView*)obj2;
                        if (image.sgHeight < 2) {
                            image.hidden = hidden;
                        }
                    }
                }
            }else{
                if ([obj isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageView = (UIImageView *)obj;
                    NSArray *list2 = imageView.subviews;
                    for (id obj2 in list2) {
                        if ([obj2 isKindOfClass:[UIImageView class]]) {
                            UIImageView *imageView2 = (UIImageView *)obj2;
                            if (imageView2.sgHeight < 2) {
                                imageView2.hidden = hidden;
                            }
                        }
                    }
                }
            }
        }
    }
}

#pragma -mark:生命周期
-(void)viewDidLoad {
    [super viewDidLoad];
    if ([SGConfig shareInstance].backImageName) {
        [self addBackButton:[SGConfig shareInstance].backImageName];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 判断是否需要隐藏黑线
    if ([SGConfig shareInstance].hideNavLine) {
        [self NavgationBarLineHidden:YES];
    }
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 在该控制器消失前，恢复黑线显示
    if ([SGConfig shareInstance].hideNavLine) {
        [self NavgationBarLineHidden:NO];
    }
}

#pragma -mark:导航栏左右按钮设置
// 导航左按钮
-(void)setLeftButton:(UIButton *)leftButton {
    _leftButton = leftButton;
    [_leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

-(void)setLeftButtonImage:(UIImage *)image {
    UIButton * btn = [[UIButton alloc]init];
    [btn setImage:image forState:UIControlStateNormal];
    [btn sizeToFit];
    [self setLeftButton:btn];
}
// 导航右按钮
-(void)setRightButton:(UIButton *)rightButton {
    _rightButton = rightButton;
    [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}

-(void)setRightButtonImage:(UIImage *)image {
    UIButton * btn = [[UIButton alloc]init];
    [btn setImage:image forState:UIControlStateNormal];
    [btn sizeToFit];
    [self setRightButton:btn];
}

- (void)setLeftButtonTitle:(NSString *)title titleColor:(UIColor *)color titleSize:(CGFloat)size{
    UIButton * btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = SG_FONT(size);
    [btn sizeToFit];
    [self setLeftButton:btn];
}

- (void)setRightButtonTitle:(NSString *)title titleColor:(UIColor *)color titleSize:(CGFloat)size{
    UIButton * btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = SG_FONT(size);
    [btn sizeToFit];
    [self setRightButton:btn];
}

-(void)leftButtonClick {
}

-(void)rightButtonClick {
}

#pragma -mark:设置有导航栏的情况下普遍返回按钮的样式
-(void)addBackButton:(NSString *)imgName{
    if (self.navigationController.childViewControllers.count > 1) { // 非根控制器
        self.navigationItem.leftBarButtonItem = [self itemWithimage:[UIImage imageNamed:imgName] selImage:[UIImage imageNamed:imgName] target:self action:@selector(goback)];
    }
}

- (UIBarButtonItem *)itemWithimage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    btn.sgSize = CGSizeMake(40, 40);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)goback {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)dealloc {
    NSLog(@"[%@ is dealloced]",NSStringFromClass([self class]));
}

- (void)showNoDataView:(NSString *)imgName remindStr:(NSString *)remindStr addView:(UIView *)superView{
    CGRect rect             = superView == nil ? self.view.bounds : CGRectMake(0, 0, superView.sgWidth, superView.sgHeight);
    SGNoDataView *noData    = [[SGNoDataView alloc] initWithFrame:rect imgName:imgName remindStr:remindStr isShowBtn:NO];
    _noDataView             = noData;
    if (superView) {
        [superView addSubview:noData];
    }else{
        [self.view addSubview:noData];
    }
}

- (void)showErrorMessage:(NSString *)imgName viewframe:(CGRect)frame addView:(UIView *)view retryBlock:(void (^)(void))retry{
    CGRect viewRect         = frame.size.width==0 ? frame : self.view.bounds;
    SGNoDataView *noData    = [[SGNoDataView alloc] initWithFrame:viewRect imgName:imgName remindStr:@"网络不给力，检查网络再试试" isShowBtn:YES];
    _noDataView             = noData;
    noData.ButtonClickBlock = ^{
        if (retry) {
            retry();
        }
    };
    if (view) {
        [view addSubview:noData];
    }else{
        [self.view addSubview:noData];
    }
}

- (void)removeNoDataView{
    [_noDataView removeFromSuperview];
}

@end
