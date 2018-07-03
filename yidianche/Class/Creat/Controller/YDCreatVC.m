//
//  YDCreatVC.m
//  yidianche
//
//  Created by 罗文琦 on 2018/5/19.
//  Copyright © 2018年 罗文琦. All rights reserved.
//

#import "YDCreatVC.h"
#import "UINavigationTool.h"
@interface YDCreatVC ()
@property(nonatomic , strong) BaseTableView * tableView;
@end

@implementation YDCreatVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    kSetBlackNav;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kStringFromClass(UITableViewCell)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.right.offset(0);
        make.bottom.offset(-KBottomLayoutGuide);
    }];
    self.tableView.backgroundColor = UIColor.redColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
