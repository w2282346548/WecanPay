//
//  LORCustomMsgView.h
//  WeCanPay
//
//  Created by wecan－mac on 16/3/9.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LORCustomMsgView : UIView

@property(nonatomic,copy)NSString *detailStr;

@property(nonatomic,copy)NSString *leftImageStr;

@property(nonatomic,copy)NSString *rightImageStr;


@property(nonatomic)BOOL isAutoDismiss;

+(instancetype)shareLorView;
-(void)show;
-(void)hide;
@end



@interface LORCustomMsgViewManager:NSObject
@property(nonatomic)LORCustomMsgView *lorMsgview;

+(instancetype)sharedManager;
-(void)ShowWithMsg:(NSString *)msg;
-(void)initLorCustomerView;
@end