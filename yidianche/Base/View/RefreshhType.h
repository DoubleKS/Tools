//
//  RefreshType.h
//  yidianche
//
//  Created by 罗文琦 on 2018/5/22.
//  Copyright © 2018年 罗文琦. All rights reserved.
//

#ifndef RefreshType_h
#define RefreshType_h

typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshTypePullDown = 0, //下拉
    RefreshTypePullUp, //上拉
    RefreshTypeAll, //上拉和下拉
};

typedef NS_ENUM(NSInteger, EndRefreshType) {
    EndRefreshTypeDefault = 0, //默认
    EndRefreshTypeNoData, //无数据
};

#endif /* RefreshType_h */
