//
//  LORCustomMsgView.m
//  WeCanPay
//
//  Created by wecan－mac on 16/3/9.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "LORCustomMsgView.h"
#import <Masonry/Masonry.h>

@interface LORCustomMsgView()
@property(nonatomic,strong) UIView *bgView;

@property(nonatomic,strong) UIImageView * leftImageView;

@property(nonatomic,strong) UIImageView * rightImageView;

@property(nonatomic,strong) UILabel *detailTitle;

@end

@implementation LORCustomMsgView
@synthesize detailStr=_detailStr;
@synthesize leftImageStr=_leftImageStr;
@synthesize rightImageStr=_rightImageStr;

-(instancetype)init{
    if (self=[super init]) {
        self.isAutoDismiss=NO;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self setBackgroundColor:[UIColor clearColor]];
    self.bgView=[[UIView alloc]init];
    self.bgView.backgroundColor=HexRGBAlpha(0x000000, 1.0);
    self.bgView.alpha=0.6f;
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    self.leftImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:self.leftImageStr]];
    
    [self addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(@10);
        make.centerY.equalTo(self);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];
    
    
    self.rightImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:self.rightImageStr]];
    
    [self addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.rightMargin.mas_equalTo(-10);
        make.centerY.equalTo(self);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];
    
    self.detailTitle=[[UILabel alloc]init];
    [self addSubview: self.detailTitle];
    [ self.detailTitle setTextColor:HexRGBAlpha(0xffffff, 1.0)];
    [ self.detailTitle setText:self.detailStr];
    [ self.detailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(15);
        make.right.equalTo(self.rightImageView.mas_left).offset(-15);
        
        make.centerY.equalTo(self);
        
    }];
    
  
}

-(void)show{
       self.leftImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:self.leftImageStr]];
     self.rightImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:self.rightImageStr]];
    [self.detailTitle setText:self.detailStr];
    [self.superview layoutIfNeeded];
    [UIView animateWithDuration:1.f delay:0.1f options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationCurveEaseOut animations:^{
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.superview.mas_centerX);
        }];
        [self.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.isAutoDismiss) {
            [self hide];
        }
    }];

}

-(void)hide{
    [self.superview layoutIfNeeded];
    [UIView animateWithDuration:1.f delay:1.5f options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationCurveEaseOut animations:^{
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.superview.mas_centerX).offset(WIDTH(self.superview));
        }];
        [self.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark -seter geter

-(NSString *)detailStr{
    if (!_detailStr) {
        _detailStr=@"没有定义数据";
    }
    return _detailStr;
}
-(void)setDetailStr:(NSString *)detailStr{
    _detailStr=detailStr;
    NSLog(@"detailStr%@",_detailStr);
}
-(NSString *)leftImageStr{
    if (!_leftImageStr) {
        _leftImageStr=@"eye";
    }
    return _leftImageStr;
}

-(NSString *)rightImageStr{
    if (!_rightImageStr) {
        _rightImageStr=@"arrowdown";
    }
    return _rightImageStr;
}


@end
