//
//  PRPageControl.m
//  esee
//
//  Created by 罗文琦 on 2017/8/26.
//  Copyright © 2017年 中北明夷. All rights reserved.
//

#import "PRPageControl.h"

@implementation PRPageControl
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setValue:[UIImage imageNamed:@"pageContollerWhite"] forKeyPath:@"_pageImage"];
        [self setValue:[UIImage imageNamed:@"pageContollerRed"] forKeyPath:@"_currentPageImage"];
    }
    return self;
}
@end
