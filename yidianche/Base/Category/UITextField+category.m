//
//  UITextField+category.m
//  yidianche
//
//  Created by 罗文琦 on 2018/7/3.
//  Copyright © 2018年 罗文琦. All rights reserved.
//

#import "UITextField+category.h"

@implementation UITextField (category)
+ (UITextField *)textFieldWithPlaceholder:(nullable NSString *)placeholder placeholderColor:(nullable UIColor *)placeholderColor textColor:(nullable UIColor *)textColor font:(nullable UIFont *)font{
    UITextField *textField = [UITextField new];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: placeholderColor,NSFontAttributeName:font}];
    textField.textColor = textColor;
    textField.font = font;
    textField.layer.masksToBounds = YES;
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}
@end
