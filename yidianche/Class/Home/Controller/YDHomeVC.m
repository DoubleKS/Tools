//
//  YDHomeVC.m
//  yidianche
//
//  Created by 罗文琦 on 2018/5/19.
//  Copyright © 2018年 罗文琦. All rights reserved.
//

#import "YDHomeVC.h"

@interface YDHomeVC ()


@property(nonatomic , strong) NSString * dogName;




@property(nonatomic , strong) BaseTableView * tableView;


@end

@implementation YDHomeVC

-(void)aaa{
    NSLog(@"被点击");
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    kSetWhiteNav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kStringFromClass(UITableViewCell)];
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_topLayoutGuide);
//        make.left.right.offset(0);
//        make.bottom.offset(-KBottomLayoutGuide);
//    }];
//    self.tableView.backgroundColor = UIColor.redColor;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [BaseActionSheet showActionSheetWithTitle:@"1" cancelButtonTitle:@"取消" destructiveButtonTitle:@"不要了" otherButtonTitles:@[@"来吧",@"爽"] handler:^(NSInteger index) {
        NSLog(@"%zd",index);
    }];
}



@end
