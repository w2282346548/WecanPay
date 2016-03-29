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
     self.navigationController.navigationBar.barStyle=UIBarStyleBlack;

}
-(void)initNavBar{
    LORAlphaNavController *d= (LORAlphaNavController *)[self navigationController];
    d.barAlpha = 1.f;
    d.barColor=HexRGBAlpha(0x48d7b1, 1);
    [d.navigationBar setTitleTextAttributes:@{
                                              NSFontAttributeName:[UIFont systemFontOfSize:19.f],
                                              NSForegroundColorAttributeName:[UIColor whiteColor]
                                              }];
    [self setTitle:@"登录"];
    
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
    
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(NavRightClick)];
    [right setTitleTextAttributes:@{  NSFontAttributeName:[UIFont systemFontOfSize:16.f],
                                    NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
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
    //先获取登陆框和密码值
    UITextField *tfPassword=(UITextField *)[self.vPassword.subviews[0] viewWithTag:10];
    UITextField *tfUserName=(UITextField *)[self.vAccount.subviews[0] viewWithTag:10];
    NSString * username=tfUserName.text;
    NSString * passsword=tfPassword.text;
    self.btnLogin.enabled=NO;
    if ([self isBlankString:username]||[self isBlankString:passsword]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"消息" message:@"用户名/密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.btnLogin.enabled=YES;
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }else{
        [self.hub show:YES];
         //进行网络请求
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dic=@{@"username":username,@"passsword":passsword};
          //  [LORNetWorkManager sharedManager].responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            //调用网络
            [[LORNetWorkManager sharedManager]requestWithMethod:POST WithUrl:API_LOGIN_URL WithParams:dic WithSuccessBlock:^(NSDictionary *dic) {//返回数据必须是JSON格式的
                if ([[dic objectForKey:@"data"] isEqual:@"ok"]) {
                    //保存此次登陆的信息吧
                    [self.hub hide:YES];
                       self.btnLogin.enabled=YES;
                    
                    [GVUserDefaults standardUserDefaults].isLogin=YES;
                    if ([GVUserDefaults standardUserDefaults].isLogin) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                    
                    
                }
                NSLog(@"html:%@",dic);
            } WithFailureBlock:^(NSError *error) {
                  NSLog(@"err:%@",error);
                [self.hub hide:YES];
                   self.btnLogin.enabled=YES;
            }];
           
        });
    
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



-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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




- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
@end
