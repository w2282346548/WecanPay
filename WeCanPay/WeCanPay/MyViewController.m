//
//  MyViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/2/25.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "MyViewController.h"
#import "LORAlphaNavController.h"
#import "LoginViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbvMine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tbvMineTopConstraint;

@property(strong,nonatomic)UIButton *quit;

@property(strong,nonatomic)NSArray *mineDataSource;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    

    
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 130)];
//    view.backgroundColor=[UIColor clearColor];
//    UIView * headerView=[[UIView alloc]init];
//    [view addSubview:headerView];
//    
//    [headerView setBackgroundColor:HexRGBAlpha(0xfff7b1, 1)];
//    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@0);
//        make.right.equalTo(@0);
//        make.topMargin.equalTo(@10);
//        make.height.equalTo(@120);
//    }];
//    [self.tbvMine setTableHeaderView:view];
    
    [self initTableView];
    
}

-(void)initTableView{
    self.tbvMine.dataSource=self;
    self.tbvMine.delegate=self;
    
    //[self initTableFootView];
    
}


-(void)viewWillAppear:(BOOL)animated{
    LORAlphaNavController *d= (LORAlphaNavController *)[self navigationController];
    d.barAlpha = 1.f;
    d.barColor=HexRGBAlpha(0x48d7b1, 1);
    [d.navigationBar setTitleTextAttributes:@{
                                              NSFontAttributeName:[UIFont systemFontOfSize:19.f],
                                              NSForegroundColorAttributeName:[UIColor whiteColor]
                                              }];
    
    [self setTitle:@"我的信息"];
    [self.tbvMine reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        if (![GVUserDefaults standardUserDefaults].isLogin) {
            return 190.f;
        }
        return 14.f;
    }
    return 7.f;
  
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]init];

    if (section==0) {
        if (![GVUserDefaults standardUserDefaults].isLogin) {
            [self setTitle:@""];
            UIView *bgview=[[UIView alloc]init];
            bgview.backgroundColor=HexRGBAlpha(0x48d7b1, 1);
            [headerView addSubview:bgview];
            [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.top.bottom.equalTo(headerView);
           
            }];
       
       
            UIButton *login=[[UIButton alloc]init];
            [bgview addSubview:login];
            [login setBackgroundColor:HexRGBAlpha(0x48d7b1, 1)];
            ViewBorderRadius(login, 3.f, 1.f, HexRGBAlpha(0xffffff, 1));
            [login setTitle:@"登录/注册" forState:UIControlStateNormal];
            [login mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@140);
                make.bottom.equalTo(headerView).offset(-20);
                make.centerX.equalTo(headerView);
                make.height.equalTo(@40);
            }];
            [login addTarget:self action:@selector(loginIn) forControlEvents:UIControlEventTouchUpInside];
       
            UIImageView *photo=[[UIImageView alloc]init];
            [bgview addSubview:photo];
            [photo setImage:[UIImage imageNamed:@"tubiao"]];
            [photo setBackgroundColor:HexRGBAlpha(0x289a7c, 1)];
            [photo setContentMode:UIViewContentModeCenter];
            ViewRadius(photo, 39.f);
            [photo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(bgview);
                make.width.height.equalTo(@78);
                make.bottom.mas_equalTo(login.mas_top).offset(-16);
           
            }];
       
            self.tbvMineTopConstraint.constant=0.f;
            LORAlphaNavController *d= (LORAlphaNavController *)[self navigationController];
            d.barAlpha = 0.f;
      
        }
        else{
            self.tbvMineTopConstraint.constant=64.f;
        
        }
    }
    return headerView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==self.mineDataSource.count-1) {
        return 100.f;
    }
       return 7.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView=[[UIView alloc]init];
    
    if (section==self.mineDataSource.count-1) {
        self.quit=[[UIButton alloc]init];
        [footView addSubview:self.quit];
        [self.quit setBackgroundColor:HexRGBAlpha(0x48d7b1, 1)];
        ViewRadius(self.quit, 3.f);
        [self.quit setTitle:@"退出" forState:UIControlStateNormal];
        [self.quit addTarget:self action:@selector(loginout) forControlEvents:UIControlEventTouchUpInside];
        [self.quit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footView).offset(10);
            make.right.equalTo(footView).offset(-10);
            make.top.equalTo(footView).offset(20);
            make.height.equalTo(@40);
        }];
    }
    if (![GVUserDefaults standardUserDefaults].isLogin) {
        [self.quit setHidden:YES];
    }else{
       [self.quit setHidden:NO];
    }
    return footView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return self.mineDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.mineDataSource objectAtIndex:section] count];
 
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NSArray *array=[self.mineDataSource objectAtIndex:indexPath.section];
    NSDictionary *dict=[array objectAtIndex:indexPath.row];
    cell.textLabel.text=dict[@"title"];
    [cell.imageView setImage:[UIImage imageNamed:dict[@"imgsrc"]]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{



    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)loginout{
    [GVUserDefaults standardUserDefaults].isLogin=NO;
    [self.tbvMine reloadData];
}

-(void)loginIn{
    LoginViewController *login=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    LORAlphaNavController *loginNavigationController = [[LORAlphaNavController alloc] initWithRootViewController:login];
    loginNavigationController.modalPresentationStyle=UIModalPresentationFormSheet;
    loginNavigationController.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [self presentViewController:loginNavigationController animated:YES completion:nil];
}


-(NSArray *)mineDataSource{
    if(!_mineDataSource){
        _mineDataSource=[[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"MineInfo" ofType:@"plist"]];
    }
    return _mineDataSource;
}
@end
