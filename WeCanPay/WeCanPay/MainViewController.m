//
//  MainViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/2/25.
//  Copyright © 2016年 wecan. All rights reserved.
//


//[self ShowMsg:@"错误"];
//[self.hub show:YES];

#import "MainViewController.h"
#import "LORAlphaNavController.h"
#import "Masonry.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollerView;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *functionView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 防止block中的循环引用
    __weak typeof(self) weakSelf = self;
    LORAlphaNavController *d= (LORAlphaNavController *)[self navigationController];
    d.barAlpha = 0.f;

    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [btn setTitle:@"北京" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(NavLeftClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:left];

    
    self.bgScrollerView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)NavLeftClick{
    NSLog(@"click left");
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

@end
