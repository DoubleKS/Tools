//
//  RPersonaIinformationIconSetCell.m
//  esee
//
//  Created by 罗文琦 on 2017/7/3.
//  Copyright © 2017年 中北明夷. All rights reserved.
//
#import "BaseActionSheet.h"

static const CGFloat mRowHeight = 48.0f;//sheet高度
static const CGFloat mRowLineHeight = 0.5f;//分割线高度
static const CGFloat mSeparatorHeight = 6.0f;//间隔高度
static const CGFloat mTitleFontSize = 13.0f;//字体大小
static const CGFloat mButtonTitleFontSize = 18.0f;//按钮字体大小
static const NSTimeInterval mAnimateDuration = 0.3f;//动画间隔时间

@interface BaseActionSheet ()

/** block回调 */
@property (copy, nonatomic) resultBlock resultBlock;
/** 背景图片 */
@property (strong, nonatomic) UIView *backgroundView;
/** 弹出视图 */
@property (strong, nonatomic) UIView *actionSheetView;

/**
 * 收起视图
 */
- (void)dismiss;



@end

@implementation BaseActionSheet


+ (void)showActionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(resultBlock)resultBlock
{
    BaseActionSheet *lpActionSheet = [[self alloc] initWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles handler:resultBlock];
    [lpActionSheet show];
}

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(resultBlock)resultBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _resultBlock = resultBlock;
        CGFloat actionSheetHeight = 0;
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        [self addSubview:_backgroundView];
        
        _actionSheetView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, 0)];
        _actionSheetView.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
        [self addSubview:_actionSheetView];

        UIImage *normalImage = [UIImage imageWithColor:UIColor.whiteColor];
        UIImage *highlightedImage = [UIImage imageWithColor:[UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]];
        
        if (title && title.length > 0)
        {
            actionSheetHeight += mRowLineHeight;
            CGFloat titleHeight = ceil([title boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:mTitleFontSize]} context:nil].size.height) + 15*2;
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, actionSheetHeight, self.frame.size.width, titleHeight)];
            titleLabel.text = title;
            titleLabel.backgroundColor = UIColor.whiteColor;
            titleLabel.textColor = [UIColor colorWithRed:135.0f/255.0f green:135.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:mTitleFontSize];
            titleLabel.numberOfLines = 0;
            [_actionSheetView addSubview:titleLabel];
            actionSheetHeight += titleHeight;
        }
        if (destructiveButtonTitle && destructiveButtonTitle.length > 0)
        {
            actionSheetHeight += mRowLineHeight;
            UIButton *destructiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
            destructiveButton.frame = CGRectMake(0, actionSheetHeight, self.frame.size.width, mRowHeight);
            destructiveButton.tag = -1;
            destructiveButton.titleLabel.font = [UIFont systemFontOfSize:mButtonTitleFontSize];
            [destructiveButton setTitle:destructiveButtonTitle forState:UIControlStateNormal];
            [destructiveButton setTitleColor:[UIColor colorWithRed:230.0f/255.0f green:66.0f/255.0f blue:66.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [destructiveButton setBackgroundImage:normalImage forState:UIControlStateNormal];
            [destructiveButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
            [destructiveButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_actionSheetView addSubview:destructiveButton];
            actionSheetHeight += mRowHeight;
        }
        
        if (otherButtonTitles && [otherButtonTitles count] > 0)
        {
            for (int i = 0; i < otherButtonTitles.count; i++)
            {
                actionSheetHeight += mRowLineHeight;
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(0, actionSheetHeight, self.frame.size.width, mRowHeight);
                button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                button.tag = i+1;
                button.titleLabel.font = [UIFont systemFontOfSize:mButtonTitleFontSize];
                [button setTitle:otherButtonTitles[i] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
                [button setBackgroundImage:normalImage forState:UIControlStateNormal];
                [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
                [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_actionSheetView addSubview:button];
                actionSheetHeight += mRowHeight;
            }
        }
        
        if (cancelButtonTitle && cancelButtonTitle.length > 0)
        {
            actionSheetHeight += mSeparatorHeight;
            
            UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            cancelButton.frame = CGRectMake(0, actionSheetHeight, self.frame.size.width, mRowHeight);
            cancelButton.tag = 0;
            cancelButton.titleLabel.font = [UIFont systemFontOfSize:mButtonTitleFontSize];
            [cancelButton setTitle:cancelButtonTitle ?: @"取消" forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [cancelButton setBackgroundImage:normalImage forState:UIControlStateNormal];
            [cancelButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
            [cancelButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_actionSheetView addSubview:cancelButton];
            actionSheetHeight += mRowHeight;
        }
        _actionSheetView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, actionSheetHeight);
    }
    
    return self;
}





- (void)show
{
    // 在主线程中处理,否则在viewDidLoad方法中直接调用,会先加本视图,后加控制器的视图到UIWindow上,导致本视图无法显示出来,这样处理后便会优先加控制器的视图到UIWindow上
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows)
        {
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            if(windowOnMainScreen && windowIsVisible && windowLevelNormal)
            {
                [window addSubview:self];
                break;
            }
        }
        [UIView animateWithDuration:mAnimateDuration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.backgroundView.alpha = 1.0f;
            self.actionSheetView.frame = CGRectMake(0, self.frame.size.height - self.actionSheetView.frame.size.height - kSafeBottom, self.frame.size.width, self.actionSheetView.frame.size.height);
        } completion:nil];
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:mAnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundView.alpha = 0.0f;
        self.actionSheetView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.actionSheetView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.backgroundView];
    if (!CGRectContainsPoint(self.actionSheetView.frame, point))
    {
        if (self.resultBlock)
        {
            self.resultBlock(0);
        }
        [self dismiss];
    }
}

- (void)buttonClicked:(UIButton *)button
{
    if (self.resultBlock) self.resultBlock(button.tag);
    [self dismiss];
}



- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"YDActionSheet dealloc");
#endif
}

@end
