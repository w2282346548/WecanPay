//
//  BaseViewController.h
//  WeCanPay
//
//  Created by wecan－mac on 16/2/25.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYBannerView.h"
#import "MBProgressHUD.h"
#import "CRToast.h"
#import "Masonry.h"


@protocol NetStateDelegate <NSObject>

@optional
-(void)NetWorkIsNo;
-(void)NetWorkIsWWAN;
-(void)NetWorkIsWIFI;
@end

@interface BaseViewController : UIViewController

@property(nonatomic,strong)MBProgressHUD *hub;

@property(assign,nonatomic)id<NetStateDelegate> networkDelegate;

-(void)ShowMsg:(NSString *)msg;
+(void)ShowLoding;
@end
