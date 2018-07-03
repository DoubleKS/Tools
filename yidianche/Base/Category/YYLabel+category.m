//
//  YYLabel+category.m
//  yidianche
//
//  Created by 罗文琦 on 2018/7/3.
//  Copyright © 2018年 罗文琦. All rights reserved.
//

#import "YYLabel+category.h"
#import <YYText.h>

@implementation YYLabel (category)

+ (YYLabel*)labelWith:(NSString*)title font:(UIFont*)font fontColor:(UIColor*)color{
    YYLabel* lab = [YYLabel new];
    lab.text = title;
    lab.font = font;
    lab.textColor = color;
    return lab;
    /*
     YYLabel* lab = [YYLabel new];
     NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"接下来，请您咨询阅读《xxx协议》！点击以下同意按钮，即表示您已阅读且完全知悉《xxx协议》约定事项并表示同意！同意后您将正式拥有xxxxxx身份。"];
     text.yy_lineSpacing = 5;
     text.yy_font = [UIFont systemFontOfSize:14];
     text.yy_color = [UIColor blackColor];
     
     [text yy_setTextHighlightRange:NSMakeRange(10, 7) color:UIColor.redColor  backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
     NSLog(@"xxx协议被点击了");
     }];
     lab.numberOfLines = 0;  //设置多行显示
     lab.preferredMaxLayoutWidth = KScreenWidth - 30; //设置最大的宽度
     lab.attributedText = text;  //设置富文本
     
     [self.view addSubview:lab];
     [lab mas_makeConstraints:^(MASConstraintMaker *make) {
     [make center];
     }];
     */
}

- (CGFloat)getHeightByLimitiWidth:(CGFloat)width{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    attributedString.yy_font = self.font;
    YYTextLayout* layout =  [YYTextLayout layoutWithContainerSize:CGSizeMake(width, CGFLOAT_MAX) text:attributedString];
    return layout.textBoundingSize.height;
}


- (CGFloat)getWidth{
    //设置属性
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    attributedString.yy_font = self.font;
    CGSize introSize =  CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:attributedString];
    return  layout.textBoundingSize.width;
}


- (void)adjustWidth:(CGFloat)width{
    if (self.text.length <=1) {
        return;
    }
    CGFloat textWidth = [self getWidth];
    if (width - textWidth < 0) {
        return;
    }
    CGFloat margin = (width- textWidth)/(self.text.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attM = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attM addAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:self.textColor} range:NSMakeRange(0, self.text.length)];
    [attM addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
    self.attributedText = attM;
}

@end
