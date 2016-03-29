//
//  HistoryBillViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/3/29.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "HistoryBillViewController.h"
#import "DZNSegmentedControl.h"

@interface HistoryBillViewController ()<DZNSegmentedControlDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)DZNSegmentedControl *control;
@property(nonatomic,strong)NSMutableArray *meunitems;
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@end

@implementation HistoryBillViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBar];
  
    self.tableView.tableHeaderView=self.control;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.tableFooterView=[UIView new];
}

-(void)initNavBar{
    LORAlphaNavController *d= (LORAlphaNavController *)[self navigationController];
    d.barAlpha = 1.f;
    d.barColor=HexRGBAlpha(0x48d7b1, 1);
    
    [self setTitle:@"历史账单"];
    
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    leftbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftbutton setTitle:@"返回" forState:UIControlStateNormal];
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [leftbutton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    UIImageView *imageview= [[UIImageView alloc]init];
    [imageview setImage:[UIImage imageNamed:@"fanhui"]];
    [leftbutton addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(leftbutton);
        make.left.mas_equalTo(leftbutton);
    }];
    [leftbutton addTarget:self action:@selector(NavLeftClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    [self.navigationItem setLeftBarButtonItem:left];
    
}

-(void)NavLeftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(DZNSegmentedControl *)control{
    if (!_control) {
        _control=[[DZNSegmentedControl alloc] initWithItems:self.meunitems];
        _control.delegate=self;
        _control.selectedSegmentIndex = self.meunitems.count-1;
        _control.bouncySelectionIndicator = NO;
        _control.height = 45.0f;
        _control.showsGroupingSeparators = YES;
        _control.autoAdjustSelectionIndicatorWidth=NO;
        _control.backgroundColor=HexRGBAlpha(0xffffff,1);
        _control.showsCount=NO;
        _control.showsGroupingSeparators=YES;
        
        [_control addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _control;

}

-(NSMutableArray *)meunitems{
    if (!_meunitems) {
        
        _meunitems=[[NSMutableArray alloc]init];
        [self generateItems];
//        
//        _meunitems=@[[@"11月" uppercaseString], [@"12月" uppercaseString], [@"01月" uppercaseString],[@"02月" uppercaseString],[@"03月" uppercaseString]];
    }
    return _meunitems;
}

-(NSMutableArray *)datas{
    if (!_datas) {
        NSArray *array=@[@"120元",@"110元",@"140元",@"110元",@"140元",@"110元",@"140元"];
        _datas=[NSMutableArray arrayWithArray:array];
    }
    return _datas;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    cell.textLabel.text = self.datas[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 30.0;
//}


#pragma mark - DZNSegmentedControlDelegate Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionAny;
}

- (UIBarPosition)positionForSelectionIndicator:(id<UIBarPositioning>)bar
{
    return UIBarPositionAny;
}


- (void)didChangeSegment:(DZNSegmentedControl *)control
{
    NSLog(@"%@",_meunitems[control.selectedSegmentIndex]);
    [self queryData:_control.selectedSegmentIndex];
 
}

-(void)generateItems{
    NSDate *currentDate = [NSDate date];//获取当前时间,日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSInteger dateMonth= [dateString integerValue];
    
    for (NSInteger i=0; i<5; i++) {
        if (dateMonth<=0) {
            dateMonth=12;
        }
        [_meunitems insertObject:[NSString stringWithFormat:@"%ld月",(long)dateMonth] atIndex:0];
        dateMonth--;
    }
    
}

-(void)queryData:(NSInteger)integer{
    
      [self.hub show:YES];
    //根据传递的参数  获得数据
    NSDictionary *dic=@{@"monthIndex":[NSString stringWithFormat:@"%ld",(long)integer]};
    //  [LORNetWorkManager sharedManager].responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //调用网络
    [[LORNetWorkManager sharedManager]requestWithMethod:POST WithUrl:API_LOGIN_URL WithParams:dic WithSuccessBlock:^(NSDictionary *dic) {//返回数据必须是JSON格式的
        if ([[dic objectForKey:@"data"] isEqual:@"ok"]) {
            //保存此次登陆的信息吧
            [self.hub hide:YES];
        
            [_datas addObject:@"234"];
            [self.tableView reloadData];
            
        }
        NSLog(@"html:%@",dic);
    } WithFailureBlock:^(NSError *error) {
        NSLog(@"err:%@",error);
          [self.hub hide:YES];
    }];


}
@end
