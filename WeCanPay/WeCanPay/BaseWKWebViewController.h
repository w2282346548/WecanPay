//
//  ProtocolViewController.h
//  WeCanPay
//
//  Created by wecan－mac on 16/3/18.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWKWebViewController : BaseViewController

@property(nonatomic)NSString *htmlPath;
@property(nonatomic)NSString *request;
-(void)showHtmlWithPath:(NSString *)path;
-(void)showUrlWithPath:(NSString *)path;
@end
