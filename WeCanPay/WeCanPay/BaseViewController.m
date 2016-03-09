//
//  BaseViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/2/25.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "BaseViewController.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import "LORToast.h"
#import "LORCustomMsgView.h"


@interface BaseViewController ()<LORNetStateDelegate>
@property(nonatomic,strong) LORCustomMsgView *lorMsgview;
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
    
    self.networkDelegate=self;
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                if (self.networkDelegate) {
                    [self.networkDelegate NetWorkIsNo];
                }
                break;}
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                if (self.networkDelegate) {
                    [self.networkDelegate NetWorkIsWIFI];
                }
                break;}
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                if (self.networkDelegate) {
                    [self.networkDelegate NetWorkIsWWAN];
                }
                break;}
            case AFNetworkReachabilityStatusUnknown:{
                break;}
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    [self makeMSgDetail];
  
    
}

-(void)NetWorkIsWIFI{
    if (!self.lorMsgview.isAutoDismiss) {
        [self.lorMsgview hide];
    }
}

-(void)NetWorkIsWWAN{
    if (!self.lorMsgview.isAutoDismiss) {
        [self.lorMsgview hide];
    }
}
-(void)NetWorkIsNo{
    NSLog(@"nonet");
    self.lorMsgview.detailStr=@"没有网络连接,请打开网络";
    [self.lorMsgview setIsAutoDismiss:NO];
    [self.lorMsgview show];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"nonet" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
    
}

-(void)ShowMsg:(NSString *)msg{
    [CRToastManager showNotificationWithMessage:msg completionBlock:nil];
}

-(void)makeMSgDetail{
    
    self.lorMsgview=[[LORCustomMsgView alloc]init];
    [self.view addSubview:self.lorMsgview];
    [self.lorMsgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@44);
        make.top.equalTo(@64);
        make.centerX.equalTo(self.view.mas_centerX).offset(-WIDTH(self.view));
        
    }];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
