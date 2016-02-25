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

@interface BaseViewController : UIViewController

@property(nonatomic,strong)MBProgressHUD *hub;

-(void)ShowMsg:(NSString *)msg;
+(void)ShowLoding;
@end
