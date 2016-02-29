//
//  LoginViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/2/26.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "LoginViewController.h"
#import "LORAlphaNavController.h"
#import "MyInputViewModel.h"
#import "MyInputView.h"

@interface LoginViewController ()<MyInputViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *vAccount;
@property (weak, nonatomic) IBOutlet UIView *vPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    [self initInputView];
    [self initBtnLogin];
    

}
-(void)initNavBar{
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
    
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(NavRightClick)];
    [self.navigationItem setRightBarButtonItem:right];

}
-(void)initBtnLogin{
    [self.btnLogin.layer setMasksToBounds:YES];
    [self.btnLogin.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [self.btnLogin.layer setBorderWidth:1.0]; //边框宽度
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 1, 1, 1 });
    
    [self.btnLogin.layer setBorderColor:colorref];//边框颜色
    
    [self.btnLogin addTarget:self action:@selector(btnLoginClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnLoginClick{
    [GVUserDefaults standardUserDefaults].isLogin=YES;
    if ([GVUserDefaults standardUserDefaults].isLogin) {
            [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)initInputView{
    MyInputViewModel *model=[[MyInputViewModel alloc]init];
    
    model.ispassword=NO;
    model.hint=@"请输入你的用户名";
    model.title=@"账号";
    model.icpic=@"admin";
    MyInputView *account=[MyInputView instanceObjecWithModel:model];
    account.frame=CGRectMake(0, 0, self.vAccount.bounds.size.width, self.vAccount.bounds.size.height);
    account.delegate=self;
    [self.vAccount addSubview:account];
    
    model.ispassword=YES;
    model.hint=@"请输入你的密码";
    model.title=@"密码";
    model.icpic=@"password";
    MyInputView *password=[MyInputView instanceObjecWithModel:model];
    password.frame=CGRectMake(0, 0, self.vPassword.bounds.size.width, self.vPassword.bounds.size.height);
    [self.vPassword addSubview:password];
    
    

}



-(void)NavLeftClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)NavRightClick{

}

#pragma MyInputView 的协议委托
-(void)onDownFun{
//    if (self.allUser.count>0) {
//        BOOL isHidden=[self.userhistory isHidden];
//        [self.userhistory setHidden:!isHidden];
//    }
//    else{
//        NSLog(@"nodata");
//    }
    
}


@end
