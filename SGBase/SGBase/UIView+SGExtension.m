//
//  UIView+SGUIView_Extension.m
//  SGFreamwoke
//
//  Created by Rowling on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "UIView+SGExtension.h"

@implementation UIView (SGExtension)
-(void)setSgX:(CGFloat)sgX {
    CGRect frame = self.frame;
    frame.origin.x = sgX;
    self.frame = frame;
}

- (CGFloat)sgX {
    return self.frame.origin.x;
}

-(void)setSgY:(CGFloat)sgY {
    CGRect frame = self.frame;
    frame.origin.y = sgY;
    self.frame = frame;
}

-(CGFloat)sgY {
    return self.frame.origin.y;
}

- (CGFloat)sgBottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setSgBottom:(CGFloat)sgBottom {
    CGRect frame = self.frame;
    frame.origin.y = sgBottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)sgRight {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSgRight:(CGFloat)sgRight {
    CGRect frame = self.frame;
    frame.origin.x = sgRight - frame.size.width;
    self.frame = frame;
}

-(void)setSgCenterX:(CGFloat)sgCenterX {
    CGPoint center = self.center;
    center.x = sgCenterX;
    self.center = center;
}

-(CGFloat)sgCenterX {
    return self.center.x;
}

-(void)setSgCenterY:(CGFloat)sgCenterY {
    CGPoint center = self.center;
    center.y = sgCenterY;
    self.center = center;
}

-(CGFloat)sgCenterY {
    return self.center.y;
}

-(void)setSgWidth:(CGFloat)sgWidth {
    CGRect frame = self.frame;
    frame.size.width = sgWidth;
    self.frame = frame;
}

-(CGFloat)sgWidth {
    return self.frame.size.width;
}

-(void)setSgHeight:(CGFloat)sgHeight {
    CGRect frame = self.frame;
    frame.size.height = sgHeight;
    self.frame = frame;
}

-(CGFloat)sgHeight {
    return self.frame.size.height;
}

-(void)setSgSize:(CGSize)sgSize {
    CGRect frame = self.frame;
    frame.size = sgSize;
    self.frame = frame;
}

-(CGSize)sgSize {
    return self.frame.size;
}

-(void)setSgOrigin:(CGPoint)sgOrigin {
    CGRect frame = self.frame;
    frame.origin = sgOrigin;
    self.frame = frame;
}

-(CGPoint)sgOrigin {
    return self.frame.origin;
}

- (UIViewController *)sgController {
    for (UIView *view = self; view; view = view.superview)
    {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)addDottedLineWithDirection:(DottedLineDirection)direction
                             color:(UIColor *)color
                            length:(CGFloat)length
                             space:(CGFloat)space {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = nil;
    
    shapeLayer.lineDashPattern = @[[NSNumber numberWithDouble:length],
                                   [NSNumber numberWithDouble:space]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    if (direction == DottedLineDirectionHorizontal) {
        shapeLayer.lineWidth = CGRectGetHeight(self.frame);
        CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
    } else {
        shapeLayer.lineWidth = CGRectGetWidth(self.frame);
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(self.frame));
    }
    shapeLayer.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:shapeLayer];
}

- (void)addDottedBorderWithColor:(UIColor *)color
                           width:(CGFloat)width
                          length:(CGFloat)length
                           space:(CGFloat)space {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = nil;
    shapeLayer.lineWidth = width;
    
    shapeLayer.lineDashPattern = @[[NSNumber numberWithDouble:length],
                                   [NSNumber numberWithDouble:space]];
    shapeLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    [self.layer addSublayer:shapeLayer];
    
}

/***************************************** XIB属性 *************************************************/
- (void)setSgCornerRadius:(CGFloat)sgCornerRadius{
    self.layer.cornerRadius = sgCornerRadius;
}

- (CGFloat)sgCornerRadius{
    return self.layer.cornerRadius;
}

- (void)setSgBorderColor:(UIColor *)sgBorderColor{
    self.layer.borderColor = sgBorderColor.CGColor;
}

- (UIColor *)sgBorderColor{
    CGColorRef cgColor = self.layer.borderColor;
    if (cgColor) {
        return [UIColor colorWithCGColor:cgColor];
    }else{
        return nil;
    }
}

- (void)setSgBorderWidth:(CGFloat)sgBorderWidth{
    self.layer.borderWidth = sgBorderWidth;
}

- (CGFloat)sgBorderWidth{
    return self.layer.borderWidth;
}

- (void)setSgMasksToBounds:(BOOL)sgMasksToBounds{
    self.layer.masksToBounds = sgMasksToBounds;
}

- (BOOL)sgMasksToBounds{
    return self.layer.masksToBounds;
}

@end
