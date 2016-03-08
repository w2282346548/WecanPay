//
//  BaseViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/2/25.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "BaseViewController.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>


@interface BaseViewController ()<NetStateDelegate>

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

    
}

-(void)NetWorkIsWWAN{
    NSLog(@"ahafhjksahfjk");
}
-(void)NetWorkIsNo{
    NSLog(@"nonet");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"nonet" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
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
