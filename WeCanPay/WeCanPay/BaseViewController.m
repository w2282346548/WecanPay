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

    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
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


  
    
}



-(void)NetWorkIsWIFI{

}

-(void)NetWorkIsWWAN{

}
-(void)NetWorkIsNo{
    
}

-(void)ShowMsg:(NSString *)msg{
    [CRToastManager showNotificationWithMessage:msg completionBlock:nil];

    }





-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
