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
#import "LORNetStateDelegate.h"



@interface BaseViewController : UIViewController

@property(nonatomic,strong)MBProgressHUD *hub;

@property(assign,nonatomic)id<LORNetStateDelegate> networkDelegate;

-(void)ShowMsg:(NSString *)msg;

@end
