//
//  MyInputView.h
//  Adao
//
//  Created by wangjie on 15/8/23.
//  Copyright (c) 2015年 wangjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyInputViewModel.h"

@protocol MyInputViewDelegate <NSObject>
@optional
-(void)onDownFun;

@end

@interface MyInputView : UIControl<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITextField *tfMsg;
@property (weak, nonatomic) IBOutlet UIButton *btnFun;
@property (strong, nonatomic) IBOutlet UIImageView *ivLine;
@property (strong, nonatomic) IBOutlet UIImageView *impic;


@property(nonatomic,retain) MyInputViewModel *model;

@property(nonatomic)BOOL isShow;
@property(nonatomic,retain) id<MyInputViewDelegate>delegate;

+(instancetype) instanceObjecWithModel:(MyInputViewModel *)model;

@end
