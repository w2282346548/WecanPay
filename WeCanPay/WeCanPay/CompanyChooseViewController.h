//
//  CompanyChooseViewController.h
//  WeCanPay
//
//  Created by wecan－mac on 16/3/15.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "BaseViewController.h"
#import "CompanyChooseModel.h"


@protocol CompanySelectDelegate <NSObject>

-(void)CompanySelect:(CompanyChooseModel *)model;

@end

@interface CompanyChooseViewController : BaseViewController
@property(nonatomic)NSMutableArray *companysData;
@property(nonatomic,assign)id<CompanySelectDelegate>companySelectDelegate;
@end
