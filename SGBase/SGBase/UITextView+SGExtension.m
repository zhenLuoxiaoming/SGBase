//
//  UITextView+SGExtension.m
//  SGBase
//
//  Created by  on 2018/8/29.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "UITextView+SGExtension.h"
#import <objc/runtime.h>
static const void *sgPlaceHolderKey;

@interface UITextView ()
@property (nonatomic, readonly) UILabel *sgPlaceHolderLabel;
@end

@implementation UITextView (SGExtension)
+(void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class, @selector(zwPlaceHolder_swizzling_layoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(zwPlaceHolder_swizzled_dealloc)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class, @selector(zwPlaceHolder_swizzled_setText:)));
}
#pragma mark - swizzled
- (void)zwPlaceHolder_swizzled_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self zwPlaceHolder_swizzled_dealloc];
}
- (void)zwPlaceHolder_swizzling_layoutSubviews {
    if (self.sgPlaceHolder) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.sgPlaceHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.sgPlaceHolderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self zwPlaceHolder_swizzling_layoutSubviews];
}
- (void)zwPlaceHolder_swizzled_setText:(NSString *)text{
    [self zwPlaceHolder_swizzled_setText:text];
    if (self.sgPlaceHolder) {
        [self updatePlaceHolder];
    }
}
#pragma mark - associated
-(NSString *)sgPlaceHolder{
    return objc_getAssociatedObject(self, &sgPlaceHolderKey);
}
-(void)setSgPlaceHolder:(NSString *)sgPlaceHolder{
    objc_setAssociatedObject(self, &sgPlaceHolderKey, sgPlaceHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}
-(UIColor *)sgPlaceHolderColor{
    return self.sgPlaceHolderLabel.textColor;
}
-(void)setSgPlaceHolderColor:(UIColor *)sgPlaceHolderColor{
    self.sgPlaceHolderLabel.textColor = sgPlaceHolderColor;
}
-(NSString *)placeholder{
    return self.sgPlaceHolder;
}
-(void)setPlaceholder:(NSString *)placeholder{
    self.sgPlaceHolder = placeholder;
}
- (NSInteger)maxLength{
    return self.maxLength;
}
- (void)setMaxLength:(NSInteger)maxLength{
    self.maxLength = maxLength;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTextViewText) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark - update
- (void)updatePlaceHolder{
    if (self.text.length) {
        [self.sgPlaceHolderLabel removeFromSuperview];
        return;
    }
    self.sgPlaceHolderLabel.font = self.font?self.font:self.cacutDefaultFont;
    self.sgPlaceHolderLabel.textAlignment = self.textAlignment;
    self.sgPlaceHolderLabel.text = self.sgPlaceHolder;
    [self insertSubview:self.sgPlaceHolderLabel atIndex:0];
}
- (void)updateTextViewText{
    if (self.text.length == self.maxLength) {
        self.text = [self.text substringToIndex:self.maxLength];
    }
}

#pragma mark - lazzing
-(UILabel *)sgPlaceHolderLabel{
    UILabel *placeHolderLab = objc_getAssociatedObject(self, @selector(sgPlaceHolderLabel));
    if (!placeHolderLab) {
        placeHolderLab = [[UILabel alloc] init];
        placeHolderLab.numberOfLines = 0;
        placeHolderLab.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(sgPlaceHolderLabel), placeHolderLab, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder) name:UITextViewTextDidChangeNotification object:self];
    }
    return placeHolderLab;
}
- (UIFont *)cacutDefaultFont{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textview = [[UITextView alloc] init];
        textview.text = @" ";
        font = textview.font;
    });
    return font;
}
@end
