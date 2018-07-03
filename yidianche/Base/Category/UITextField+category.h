//
//  UITextField+category.h
//  yidianche
//
//  Created by 罗文琦 on 2018/7/3.
//  Copyright © 2018年 罗文琦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (category)

+ (UITextField *)textFieldWithPlaceholder:(nullable NSString *)placeholder placeholderColor:(nullable UIColor *)placeholderColor textColor:(nullable UIColor *)textColor font:(nullable UIFont *)font;

@end
