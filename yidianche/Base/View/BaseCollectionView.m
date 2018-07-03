//
//  PRCollectionView.m
//  esee
//
//  Created by 罗文琦 on 2017/10/31.
//  Copyright © 2017年 中北明夷. All rights reserved.
//

#import "BaseCollectionView.h"

static void * RefreshpullDownBlock;
static void * RefreshpullUpBlock;

@implementation BaseCollectionView

#pragma mark - 正常模式刷新
- (void)normalRefreshType:(RefreshType)refreshType firstRefresh:(BOOL)firstRefresh timeLabHidden:(BOOL)timeLabHidden stateLabHidden:(BOOL)stateLabHidden pullDownBlock:(void(^)(void))pullDownBlock pullUpBlock:(void(^)(void))pullUpBlock
{
    if (refreshType == RefreshTypePullDown) {
        //下拉
        self.pullDownBlock = pullDownBlock;
        
        MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownBlockAction)];
        //是否隐藏上次更新的时间
        header.lastUpdatedTimeLabel.hidden = timeLabHidden;
        //是否隐藏刷新状态label
        header.stateLabel.hidden = stateLabHidden;
        
        self.mj_header = header;
        //首次进来是否需要刷新
        if (firstRefresh) {
            [self.mj_header beginRefreshing];
        }
        //透明度渐变
        self.mj_header.automaticallyChangeAlpha = YES;
        
    }else if (refreshType == RefreshTypePullUp) {
        //上拉
        self.pullUpBlock = pullUpBlock;
        
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpBlockAction)];
        
    }else if (refreshType == RefreshTypeAll) {
        
        //下拉
        self.pullDownBlock = pullDownBlock;
        MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownBlockAction)];
        //是否隐藏上次更新的时间
        header.lastUpdatedTimeLabel.hidden = timeLabHidden;
        //是否隐藏刷新状态label
        header.stateLabel.hidden = stateLabHidden;
        
        self.mj_header = header;
        //首次进来是否需要刷新
        if (firstRefresh) {
            [self.mj_header beginRefreshing];
        }
        //透明度渐变
        self.mj_header.automaticallyChangeAlpha = YES;
        
        //上拉
        self.pullUpBlock = pullUpBlock;
        
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpBlockAction)];
    }
}

#pragma mark - gif动画刷新
- (void)gifRefreshType:(RefreshType)refreshType firstRefresh:(BOOL)firstRefresh timeLabHidden:(BOOL)timeLabHidden stateLabHidden:(BOOL)stateLabHidden pullDownBlock:(void(^)(void))pullDownBlock pullUpBlock:(void(^)(void))pullUpBlock
{
    NSArray * idleImages = @[[UIImage imageNamed:@"loading01"], [UIImage imageNamed:@"loading02"], [UIImage imageNamed:@"loading03"], [UIImage imageNamed:@"loading04"]];//闲置状态下的gif(拖动的时候变化的gif)
    
    NSArray * pullingImages = @[[UIImage imageNamed:@"loading01"], [UIImage imageNamed:@"loading02"], [UIImage imageNamed:@"loading03"], [UIImage imageNamed:@"loading04"]];//已经到达偏移量的gif
    
    NSArray * refreshingImages = @[[UIImage imageNamed:@"loading01"], [UIImage imageNamed:@"loading02"], [UIImage imageNamed:@"loading03"], [UIImage imageNamed:@"loading04"]];//正在刷新的时候的gif

    if (refreshType == RefreshTypePullDown) {
        //下拉
        self.pullDownBlock = pullDownBlock;
        
        MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownBlockAction)];
        //gif动画数组
        [header setImages:idleImages forState:MJRefreshStateIdle];
        [header setImages:pullingImages forState:MJRefreshStatePulling];
        [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
        //是否隐藏上次更新的时间
        header.lastUpdatedTimeLabel.hidden = timeLabHidden;
        //是否隐藏刷新状态label
        header.stateLabel.hidden = stateLabHidden;
        
        self.mj_header = header;
        //首次进来是否需要刷新
        if (firstRefresh) {
            [self.mj_header beginRefreshing];
        }
        
    }else if (refreshType == RefreshTypePullUp) {
        //上拉
        self.pullUpBlock = pullUpBlock;
        
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpBlockAction)];
        
    }else if (refreshType == RefreshTypeAll) {
        //下拉
        self.pullDownBlock = pullDownBlock;
        
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownBlockAction)];
        //gif动画数组
        [header setImages:idleImages forState:MJRefreshStateIdle];
        [header setImages:pullingImages forState:MJRefreshStatePulling];
        [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
        //是否隐藏上次更新的时间
        header.lastUpdatedTimeLabel.hidden = timeLabHidden;
        //是否隐藏刷新状态label
        header.stateLabel.hidden = stateLabHidden;
        
        self.mj_header = header;
        //首次进来是否需要刷新
        if (firstRefresh) {
            [self.mj_header beginRefreshing];
        }
        //上拉
        self.pullUpBlock = pullUpBlock;
        
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpBlockAction)];
    }
}


#pragma mark - 下拉时候触发的block
- (void)pullDownBlockAction {
    if (self.pullDownBlock) {
        self.pullDownBlock();
        self.userInteractionEnabled = NO;

    }
}

#pragma mark - 上拉时候触发的block
- (void)pullUpBlockAction {
    if (self.pullUpBlock) {
        self.pullUpBlock();
        self.userInteractionEnabled = NO;
    }
}

#pragma mark - 结束头部刷新
- (void)endHeaderRefresh
{
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
        [self.mj_footer resetNoMoreData];
    }
    self.userInteractionEnabled = YES;
}

#pragma mark - 结束尾部刷新
- (void)endFooterRefresh:(EndRefreshType)endRefreshType
{
    if ([self.mj_footer isRefreshing]) { 
        if (endRefreshType == EndRefreshTypeNoData) {
            [self.mj_footer endRefreshingWithNoMoreData];
            self.mj_footer.state = MJRefreshStateNoMoreData;
        }else{
            [self.mj_footer endRefreshing];
            self.mj_footer.state = MJRefreshStateIdle;
        }
    }
    self.userInteractionEnabled = YES;
}

-(void)endRefresh{
    if ([self.mj_footer isRefreshing]) {
        [self endFooterRefresh:EndRefreshTypeDefault];
    }
    if ([self.mj_header isRefreshing]) {
        [self endHeaderRefresh];
    }
    self.userInteractionEnabled = YES;
}


- (void)deallocBlock
{
    self.pullUpBlock = nil;
    self.pullDownBlock = nil;
}

#pragma mark - 属性
- (void)setpullUpBlock:(void (^)(void))pullUpBlock
{
    objc_setAssociatedObject(self, &RefreshpullUpBlock, pullUpBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(void))pullUpBlock
{
    return objc_getAssociatedObject(self, &RefreshpullUpBlock);
}

- (void)setpullDownBlock:(void (^)(void))pullDownBlock
{
    objc_setAssociatedObject(self, &RefreshpullDownBlock, pullDownBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(void))pullDownBlock
{
    return objc_getAssociatedObject(self, &RefreshpullDownBlock);
}

-(void)headerBeginRefresh{
//    self.mj_header.state = MJRefreshStateRefreshing;
    [self.mj_header beginRefreshing];
}

@end
