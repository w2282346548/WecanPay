
//
//  MyInputView.m
//  Adao
//
//  Created by wangjie on 15/8/23.
//  Copyright (c) 2015年 wangjie. All rights reserved.
//

#import "MyInputView.h"

@implementation MyInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) setModel:(MyInputViewModel *)model{
    _model=model;
    

    [self.lbTitle setText:model.title];
    [self.tfMsg setPlaceholder:model.hint];
    [self.btnFun setImage:[UIImage imageNamed:@"arrowdown"] forState:UIControlStateNormal];
    //[self.btnFun setBackgroundImage:[UIImage imageNamed:@"arrowdown"] forState:UIControlStateNormal];
      self.tfMsg.delegate=self;
    [self.impic setImage:[UIImage imageNamed:model.icpic]];
    if (model.ispassword) {
        [self.tfMsg setSecureTextEntry:YES];
        [self.btnFun setHidden:YES];
       //  [self.btnFun setImage:[UIImage imageNamed:@"eyenormal"] forState:UIControlStateNormal];
//        [self.btnFun setBackgroundImage:[UIImage imageNamed:@"eyenormal"] forState:UIControlStateNormal];
       // [self.btnFun addTarget:self action:@selector(passwordFun) forControlEvents:UIControlEventTouchDown];
    }else{
       // [self.btnFun addTarget:self action:@selector(downFun) forControlEvents:UIControlEventTouchDown];
        
    }
    
}
-(void)downFun{
    NSLog(@"dwonFUN~~~~~~~");
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(onDownFun)]==true){
          NSLog(@"dUN~~~~~~~");
        [self.delegate onDownFun];
    }
}

-(void)passwordFun{

   
    if(!self.isShow){
        self.isShow=YES;
        [self.tfMsg setSecureTextEntry:NO];
 [self.btnFun setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
//        [self.btnFun setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
    }else{
        self.isShow=NO;
         [self.tfMsg setSecureTextEntry:YES
          ];
         [self.btnFun setImage:[UIImage imageNamed:@"eyenormal"] forState:UIControlStateNormal];
//        [self.btnFun setBackgroundImage:[UIImage imageNamed:@"eyenormal"] forState:UIControlStateNormal];
    }
    
}


+(MyInputView *) instanceObject{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"MyInputView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}


+(instancetype) instanceObjecWithModel:(MyInputViewModel *)model{
    MyInputView *appView=[self instanceObject];
    
    appView.model=model;
    appView.isShow=NO;
    return appView;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        //my code
        
    }
    return self;
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField      // return NO to disallow editing.
{
        [self.ivLine setBackgroundColor:[UIColor blueColor]];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
     [self.ivLine setBackgroundColor:[UIColor grayColor]];
    return YES;
}


@end
