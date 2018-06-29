//
//  SecondViewController.m
//  JJNavigationBar
//
//  Created by luming on 2018/6/28.
//  Copyright © 2018年 luming. All rights reserved.
//

#import "SecondViewController.h"
#import "UIView+JJNavigationBar.h"
#import "Masonry.h"
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,copy) NSArray *dataArray;
@end

@implementation SecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.navigationBar.navLineView.backgroundColor = [UIColor yellowColor];
    self.navigationBar.backgroundColor = [UIColor redColor];
    self.navigationBar.titleLabel.text = @"JJNavigationBar";
    [self.navigationBar.btnRight setTitle:@"111" forState:UIControlStateNormal];
    [self.navigationBar.btnRightStandBy setTitle:@"222" forState:UIControlStateNormal];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
