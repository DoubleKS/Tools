//
//  UIButton+category.h
//  yidianche
//
//  Created by 罗文琦 on 2018/5/20.
//  Copyright © 2018年 罗文琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+category.h"


typedef NS_ENUM(NSInteger, YDImagePosition) {
    Left = 0,              //图片在左，文字在右，默认
    Right = 1,             //图片在右，文字在左
    Top = 2,               //图片在上，文字在下
    Bottom = 3,            //图片在下，文字在上
};


@interface UIButton (category)

/*
 设置butto的阴影,圆角,必须在加到父试图,并且设置完约束之后才能调用,不然不会生效
 */
-(void)setGradientStyle:(UIGradientStyle)gradientStyle gradientSize:(CGSize)gradientSize  andColors:(NSArray *)colors cornerRadius:(CGFloat)cornerRadius shadowColor:(UIColor*)shadowColor shadowOffset:(CGSize)shadowOffset;

/**设置图片位置,要先设置图片之后才能调用*/
- (void)setImagePosition:(YDImagePosition)postion spacing:(CGFloat)spacing;

/**1文字*/
+(UIButton*)buttonWithTitle:(nullable NSString*)title titleColor:(nullable UIColor*)titleColor font:(nullable UIFont*)font target:(nullable id)target action:(nullable SEL)action;
/**2文字*/
+(UIButton*)buttonWithTitle:(nullable NSString*)title titleColor:(nullable UIColor*)titleColor selTitle:(nullable NSString*)selTitle selTitleColor:(nullable UIColor*)selTitleColor font:(nullable UIFont*)font  target:(nullable id)target action:(nonnull SEL)action;
/**1图片*/
+(UIButton*)buttonWithImage:(nullable UIImage*)image target:(nullable id)target action:(nonnull SEL)action;
/**2图片*/
+(UIButton*)buttonWithImage:(nullable UIImage*)image selImage:(nullable UIImage*)selImage target:(nullable id)target action:(nonnull SEL)action;
/**1文字,1图片*/
+(UIButton*)buttonWithTitle:(nullable NSString*)title titleColor:(nullable UIColor*)titleColor  font:(nullable UIFont*)font image:(nullable UIImage*)image  target:(nullable id)target action:(nonnull SEL)action;
/**2文字,2图片*/
+(UIButton*)buttonWithTitle:(nullable NSString*)title titleColor:(nullable UIColor*)titleColor selTitle:(nullable NSString*)selTitle selTitleColor:(nullable UIColor*)selTitleColor font:(nullable UIFont*)font image:(nullable UIImage*)image selImage:(nullable UIImage*)selImage target:(nullable id)target action:(nonnull SEL)action;




@end
