//
//  PayViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/2/29.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "PayViewController.h"
#import "RDVTabBarController.h"

@interface PayViewController ()
@property (weak, nonatomic) IBOutlet UIButton *BtnPay;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNavBar];
    ViewRadius(self.BtnPay, 5.0);
}

-(void)initNavBar{
    LORAlphaNavController *d= (LORAlphaNavController *)[self navigationController];
    d.barAlpha = 1.f;
    d.barColor=HexRGBAlpha(0x48d7b1, 1);
    
    [self setTitle:@"燃气缴费"];
    
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

-(void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}


@end
