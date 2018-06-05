
//带最大文字输入量的textField
//  Created by lwq on 2018/6/5.
//  Copyright © 2018年 lwq. All rights reserved.
//

#import <UIKit/UIKit.h>
//
@interface JJTextField : UITextField

@property(nonatomic , assign) NSInteger  maxNum;

@property(nonatomic , assign) BOOL  isShowEnterNum;


-(instancetype)initWithMaxCount:(NSInteger)maxNum;
@end
