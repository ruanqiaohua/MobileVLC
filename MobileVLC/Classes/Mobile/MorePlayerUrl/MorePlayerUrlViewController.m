//
//  MorePlayerUrlViewController.m
//  MobileVLC
//
//  Created by ruanqiaohua on 15/12/28.
//  Copyright © 2015年 xiaohuoban. All rights reserved.
//

#import "MorePlayerUrlViewController.h"

@interface MorePlayerUrlViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *playerUrls;
@end

static NSString *CellIdentifier = @"CellIdentifier";

@implementation MorePlayerUrlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    _playerUrls = [self backPlayerUrls];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(-100, 0, 100, self.view.frame.size.height)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    // Do any additional setup after loading the view.
}

- (NSArray *)backPlayerUrls
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PlayerUrl" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    return array;
}

- (void)tableViewShow
{
    [UIView animateWithDuration:0.2 animations:^{
        _tableView.frame = CGRectMake(0, 0, 100, self.view.frame.size.height);
    }];
}

- (void)tableViewHidden
{
    [UIView animateWithDuration:0.2 animations:^{
        _tableView.frame = CGRectMake(-100, 0, 100, self.view.frame.size.height);
    }completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self tableViewShow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_playerUrls count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    NSDictionary *dic = _playerUrls[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _playerUrls[indexPath.row];
    [self.delegate morePlayerUrlViewControllerChoosePlayerUrl:dic[@"url"]];
    [self tableViewHidden];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self tableViewHidden];
}

@end
