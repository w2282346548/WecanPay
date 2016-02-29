//
//  BaseViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/2/25.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(instancetype)init{
    if (self=[super init]) {
        
    }
    return self;
}

-(void)viewDidLoad{
    self.hub=[[MBProgressHUD alloc]init];
    self.hub.mode=MBProgressHUDModeIndeterminate;
    self.hub.detailsLabelText=@"Login....";
    [self.view addSubview:self.hub];
}

-(void)ShowMsg:(NSString *)msg{
    [CRToastManager showNotificationWithMessage:msg completionBlock:nil];
}

+(void)ShowLoding{

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
