//
//  PRCollectionView.h
//  esee
//
//  Created by 罗文琦 on 2017/10/31.
//  Copyright © 2017年 中北明夷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "RefreshhType.h"

@interface BaseCollectionView : UICollectionView


//下拉时候触发的block
@property (nonatomic, copy) void(^pullDownBlock)(void);

//上拉时候触发的block
@property (nonatomic, copy) void(^pullUpBlock)(void);

/**
 正常模式刷新
 
 @param refreshType 上拉、下拉、上下拉
 @param firstRefresh 首次是否刷新
 @param timeLabHidden 时间标签是否隐藏
 @param stateLabHidden 状态标签是否隐藏
 @param pullDownBlock 下拉回调
 @param pullUpBlock 上拉回调
 */
- (void)normalRefreshType:(RefreshType)refreshType
             firstRefresh:(BOOL)firstRefresh
            timeLabHidden:(BOOL)timeLabHidden
           stateLabHidden:(BOOL)stateLabHidden
            pullDownBlock:(void(^)(void))pullDownBlock
              pullUpBlock:(void(^)(void))pullUpBlock;

/**
 gif模式刷新
 
 @param refreshType 上拉、下拉、上下拉
 @param firstRefresh 首次是否刷新
 @param timeLabHidden 时间标签是否隐藏
 @param stateLabHidden 状态标签是否隐藏
 @param pullDownBlock 下拉回调
 @param pullUpBlock 上拉回调
 */
- (void)gifRefreshType:(RefreshType)refreshType
          firstRefresh:(BOOL)firstRefresh
         timeLabHidden:(BOOL)timeLabHidden
        stateLabHidden:(BOOL)stateLabHidden
         pullDownBlock:(void(^)(void))pullDownBlock
           pullUpBlock:(void(^)(void))pullUpBlock;


/**
 结束头部刷新
 */
- (void)endHeaderRefresh;

/**
 结束尾部刷新
 
 @param endRefreshType 结束类型
 */
- (void)endFooterRefresh:(EndRefreshType)endRefreshType;

-(void)endRefresh;

/**
 block置空
 */
- (void)deallocBlock;

-(void)headerBeginRefresh;
@end
