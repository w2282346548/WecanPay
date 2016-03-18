//
//  CompanyChooseCell.m
//  WeCanPay
//
//  Created by wecan－mac on 16/3/15.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "CompanyChooseCell.h"


@implementation CompanyChooseCell

-(instancetype)init{

    if (self=[super init]) {
   
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    //self.isSelcet=selected;
 
}


-(void)setModel:(CompanyChooseModel *)model{
    _model=model;
    
    [self.CompanyCell setTitle:_model.companyName forState:UIControlStateNormal];
}

-(void)setIsSelcet:(BOOL)isSelcet{
    _isSelcet=isSelcet;
    [self.CompanyCell setEnabled:isSelcet];
    [self.CompanyCell setSelected:isSelcet];

}

@end
