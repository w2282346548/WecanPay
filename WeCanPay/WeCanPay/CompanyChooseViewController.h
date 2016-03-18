//
//  CompanyChooseViewController.h
//  WeCanPay
//
//  Created by wecan－mac on 16/3/15.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "BaseViewController.h"
#import "CompanyChooseModel.h"
#import "ChooseViewController.h"


@protocol CompanySelectDelegate <NSObject>

-(void)CompanySelect:(CompanyChooseModel *)model;

@end

@interface CompanyChooseViewController : BaseViewController
@property(nonatomic)ChooseType currenctType;//判断当前的类型
@property(nonatomic)NSMutableArray *companysData;
@property(nonatomic,assign)id<CompanySelectDelegate>companySelectDelegate;
@end
