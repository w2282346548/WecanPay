//
//  ChooseViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/3/1.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "ChooseViewController.h"
#import "PayViewController.h"
#import "UIScrollView+UITouchEvent.h"

@interface ChooseViewController ()
@property (weak, nonatomic) IBOutlet UIButton *BtnGoNext;

@end

@implementation ChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self initNavBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavBar{

    LORAlphaNavController *d= (LORAlphaNavController *)[self navigationController];
    d.barAlpha = 1.f;
    d.barColor=HexRGBAlpha(0x48d7b1, 1);
    
    [self setTitle:@"燃气缴费"];
    
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(NavLeftClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    [self.navigationItem setLeftBarButtonItem:left];
    
}

-(void)NavLeftClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)BtnGoNextClicked:(id)sender {
    PayViewController *payController=[[PayViewController alloc]initWithNibName:@"PayViewController" bundle:nil];
      [self.navigationController pushViewController:payController animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
@end
