//
//  UITextField+SGExtension.m
//  SGBase
//
//  Created by  on 2018/8/29.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "UITextField+SGExtension.h"
#import <objc/runtime.h>

static char kMaxLength;

@interface UItextFieldMaxLengthObserver : NSObject

@end

@implementation UItextFieldMaxLengthObserver

- (void)textChange:(UITextField *)textField {
    NSString *destText = textField.text;
    NSUInteger maxLength = textField.sgMaxLength;
    UITextRange *selectedRange = [textField markedTextRange];
    if (!selectedRange || !selectedRange.start) {
        if (destText.length > maxLength) {
            textField.text = [destText substringToIndex:maxLength];
        }
    }
}

@end

static UItextFieldMaxLengthObserver *observer;

@implementation UITextField (SGExtension)
@dynamic sgMaxLength;

+ (void)load {
    observer = [[UItextFieldMaxLengthObserver alloc] init];
}

- (void)setSgMaxLength:(NSUInteger)sgMaxLength{
    objc_setAssociatedObject(self, &kMaxLength, @(sgMaxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (sgMaxLength) {
        [self addTarget:observer
                 action:@selector(textChange:)
       forControlEvents:UIControlEventEditingChanged];
    }
}

- (NSUInteger)sgMaxLength {
    NSNumber *number = objc_getAssociatedObject(self, &kMaxLength);
    return [number integerValue];
}

- (void)setSgPlaceHolderColor:(UIColor *)sgPlaceHolderColor{
    ((UILabel *)[self valueForKey:@"placeholderLabel"]).textColor = sgPlaceHolderColor;
}

- (UIColor *)sgPlaceHolderColor{
    return ((UILabel *)[self valueForKey:@"placeholderLabel"]).textColor;
}

@end
