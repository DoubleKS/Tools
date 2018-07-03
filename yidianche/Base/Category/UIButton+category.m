//
//  UIButton+category.m
//  yidianche
//
//  Created by 罗文琦 on 2018/5/20.
//  Copyright © 2018年 罗文琦. All rights reserved.
//

#import "UIButton+category.h"

@implementation UIButton (category)

#pragma mark - 1文字
+(UIButton*)buttonWithTitle:(nullable NSString*)title titleColor:(nullable UIColor*)titleColor font:(nullable UIFont*)font target:(nullable id)target action:(nullable SEL)action{
    return [UIButton buttonWithTitle:title titleColor:titleColor selTitle:nil selTitleColor:nil font:font image:nil selImage:nil target:target action:action];
}

#pragma mark - 2文字
+(UIButton*)buttonWithTitle:(nullable NSString*)title titleColor:(nullable UIColor*)titleColor selTitle:(nullable NSString*)selTitle selTitleColor:(nullable UIColor*)selTitleColor font:(nullable UIFont*)font  target:(nullable id)target action:(nonnull SEL)action{
     return [UIButton buttonWithTitle:title titleColor:titleColor selTitle:selTitle selTitleColor:selTitleColor font:font image:nil selImage:nil target:target action:action];
}

#pragma mark -  1图片
+(UIButton*)buttonWithImage:(nullable UIImage*)image target:(nullable id)target action:(nonnull SEL)action{
     return [UIButton buttonWithTitle:nil titleColor:nil selTitle:nil selTitleColor:nil font:nil image:image selImage:nil target:target action:action];
}

#pragma mark - 2 图片
+(UIButton*)buttonWithImage:(nullable UIImage*)image selImage:(nullable UIImage*)selImage target:(nullable id)target action:(nonnull SEL)action{
    return [UIButton buttonWithTitle:nil titleColor:nil selTitle:nil selTitleColor:nil font:nil image:image selImage:selImage target:target action:action];
}

#pragma mark - 1文字,1图片
+(UIButton*)buttonWithTitle:(nullable NSString*)title titleColor:(nullable UIColor*)titleColor  font:(nullable UIFont*)font image:(nullable UIImage*)image  target:(nullable id)target action:(nonnull SEL)action{
        return [UIButton buttonWithTitle:title titleColor:titleColor selTitle:nil selTitleColor:nil font:font image:image selImage:nil target:target action:action];
}


#pragma mark - 2文字,2图片
+(UIButton*)buttonWithTitle:(nullable NSString*)title titleColor:(nullable UIColor*)titleColor selTitle:(nullable NSString*)selTitle selTitleColor:(nullable UIColor*)selTitleColor font:(nullable UIFont*)font image:(nullable UIImage*)image selImage:(nullable UIImage*)selImage target:(nullable id)target action:(nonnull SEL)action{
    UIButton* btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:selTitle forState:UIControlStateSelected];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    if (action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}


-(void)setGradientStyle:(UIGradientStyle)gradientStyle gradientSize:(CGSize)gradientSize  andColors:(NSArray *)colors cornerRadius:(CGFloat)cornerRadius shadowColor:(UIColor*)shadowColor shadowOffset:(CGSize)shadowOffset{
        self.backgroundColor = [UIColor colorWithGradientStyle:gradientStyle withSize:gradientSize andColors:colors];
        self.layer.cornerRadius = cornerRadius;
        self.layer.shadowColor = shadowColor.CGColor;
        self.layer.shadowOffset = shadowOffset;
        self.layer.shadowOpacity = 0.8;
}



- (void)setImagePosition:(YDImagePosition)postion spacing:(CGFloat)spacing {
    [self setTitle:self.currentTitle forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:UIControlStateNormal];
    
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop
    
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;//image中心移动的y距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;//label中心移动的y距离
    
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + spacing - tempHeight;
    
    switch (postion) {
        case Left:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case Right:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing/2), 0, imageWidth + spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case Top:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break;
            
        case Bottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
            
        default:
            break;
    }
    
}
@end
