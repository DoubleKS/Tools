//
//  JJTextField.m
//  JJCustomCamera
//
//  Created by lwq on 2018/6/5.
//  Copyright © 2018年 lwq. All rights reserved.
//

#import "BaseTextField.h"

@interface BaseTextField()
@property(nonatomic , strong) UILabel * enterNumLab;

@end

@implementation BaseTextField

-(instancetype)initWithMaxCount:(NSInteger)maxNum{
        if (self = [super init]) {
            self.maxNum = maxNum <=0 ? NSIntegerMax : maxNum ;
            [self setupUI];
        }
        return self;
}

-(void)setupUI{
    //设置leftView,不然挨得太近不好看
    self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 1)];
    self.leftViewMode = UITextFieldViewModeAlways;
    //设置右侧统计输入文字的lab
    self.enterNumLab = [[UILabel alloc]init];
    //初始状态显示可以输入的最大值
    _enterNumLab.text = [NSString stringWithFormat:@"%zd",self.maxNum];
    _enterNumLab.textColor = [UIColor lightGrayColor];
    self.rightView = self.enterNumLab;
    self.rightView.frame = CGRectMake(0, 0, 30, 40);//这个宽度也可以根据自己的需求进行改变
    self.rightViewMode = UITextFieldViewModeAlways;
    [self addTarget:self action:@selector(editChanged) forControlEvents:UIControlEventEditingChanged];
    self.layer.borderColor = [[UIColor redColor] CGColor];
    self.layer.borderWidth = 2;

}
-(void)editChanged{
        if (self.maxNum > 0 ) {
            NSString *lang = [self.textInputMode primaryLanguage]; //获取输入的方式
            if ([lang isEqualToString:@"zh-Hans"])// 如果是简体中文输入
            {
                UITextRange *selectedRange = [self markedTextRange]; //获取高亮部分的范围(系统九宫格输入法或者其他的小型第三方输入法会触发)
//                UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0]; //获取光标位置
                // 如果是中文输入法，则对已输入的文字进行字数统计和限制
                if (!selectedRange)  //如果没有高亮部分,截取规定长度的文字,这样可以防止出现最后几个字不能输入的问题
                {
                    if (self.text.length > _maxNum)  self.text = [self.text substringToIndex:self.maxNum]; //如果已经超长 
                    
                }
//                else{//有选中的部分
//                    if (self.text.length > _maxNum) {
//                         self.text = [self.text substringToIndex:self.maxNum];
//                    }
//
//                }
            }
            else // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            {
                if (self.text.length > self.maxNum) self.text = [self.text substringToIndex:self.maxNum];
            }
        }
    self.enterNumLab.text = [NSString stringWithFormat:@"%zd",(self.maxNum - self.text.length)];
}

@end
