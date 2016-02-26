//
//  LoginViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/2/26.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "LoginViewController.h"
#import "LORAlphaNavController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    LORAlphaNavController *d= (LORAlphaNavController *)[self navigationController];
    d.barAlpha = 1.f;
    d.barColor=HexRGBAlpha(0x02C874, 1);
    
    [self setTitle:@"登录"];
    
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"nav_left"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(NavLeftClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    [self.navigationItem setLeftBarButtonItem:left];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)NavLeftClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
