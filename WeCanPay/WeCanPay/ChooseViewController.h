//
//  ChooseViewController.h
//  WeCanPay
//
//  Created by wecan－mac on 16/3/1.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "BaseViewController.h"
#import "ChooseViewModel.h"


typedef NS_ENUM(NSInteger,ChooseType) {
    ChooseTypeWater,
    ChooseTypeHeat,
    ChooseTypeGas,
    ChooseTypeElectric,
    ChooseTypeProperty
};

@interface ChooseViewController : BaseViewController

@property(nonatomic,strong)ChooseViewModel *chooseModel;
@property(nonatomic)ChooseType currenctType;

@end
