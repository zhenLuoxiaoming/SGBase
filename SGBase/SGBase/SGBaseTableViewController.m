//
//  SGBaseTableViewController.m
//  SGBase
//
//  Created by  on 2018/9/3.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "SGBaseTableViewController.h"
#import "UIView+SGExtension.h"
#import "SGConfig.h"
@interface SGBaseTableViewController ()

@end

@implementation SGBaseTableViewController

#pragma -mark:隐藏导航栏的那根黑线
//隐藏line
- (void)NavgationBarLineHidden:(BOOL)hidden {
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list){
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0){
                //10.0的系统字段不一样
                UIView *view =   (UIView*)obj;
                for (id obj2 in view.subviews) {
                    if ([obj2 isKindOfClass:[UIImageView class]]){
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
    self.tableView.tableFooterView = [UIView new];
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

- (UIBarButtonItem *)itemWithimage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action{
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

@end
