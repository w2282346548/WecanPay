//
//  CompanyChooseCell.h
//  WeCanPay
//
//  Created by wecan－mac on 16/3/15.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyChooseModel.h"

@interface CompanyChooseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet DLRadioButton *CompanyCell;

@property(nonatomic,strong)CompanyChooseModel *model;
@property(nonatomic)BOOL isSelcet;
@end
