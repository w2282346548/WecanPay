//
//  CompanyChooseViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/3/15.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "CompanyChooseViewController.h"
#import "CompanyChooseModel.h"
#import <UIScrollView+EmptyDataSet.h>
#import "CompanyChooseCell.h"
#import "ChooseViewController.h"

@interface CompanyChooseViewController ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbvCompanys;

@property(nonatomic)NSIndexPath *currectIndex;
@end

@implementation CompanyChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tbvCompanys.emptyDataSetDelegate=self;
    self.tbvCompanys.emptyDataSetSource=self;
    self.tbvCompanys.dataSource=self;
    self.tbvCompanys.delegate=self;
    self.tbvCompanys.allowsMultipleSelection=NO;
    self.tbvCompanys.allowsSelection=YES;
    self.tbvCompanys.tableFooterView=[UIView new];
    [self.tbvCompanys registerNib:[UINib nibWithNibName:@"CompanyChooseCell" bundle:nil] forCellReuseIdentifier:@"CompanyChooseCellIdentifier"];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
//    
//    
//    if ([self.tbvCompanys.delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
//        [self.tbvCompanys.delegate tableView:self.tbvCompanys willSelectRowAtIndexPath:indexPath];
//    }
//    
//    [self.tbvCompanys selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone
//     ];
//    
//    if ([self.tbvCompanys.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
//        [self.tbvCompanys.delegate tableView:self.tbvCompanys didSelectRowAtIndexPath:indexPath];
//    }


    
  
    
    
}
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"eye"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.companysData.count;
//    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CompanyChooseCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CompanyChooseCellIdentifier"];
    
    CompanyChooseModel *model=[CompanyChooseModel new];
    NSDictionary *dict=[self.companysData objectAtIndex:indexPath.row];
    model.companyName=dict[@"title"];
    model.companyID=(NSInteger)dict[@"id"];

//    model.companyName=[NSString stringWithFormat:@"title%ld",(long)indexPath.row];
//    model.companyID=indexPath.row;

    cell.model=model;
    if (indexPath==self.currectIndex) {
        
        cell.isSelcet=YES;
    }else{
    cell.isSelcet=NO;
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   CompanyChooseCell *cell= [self.tbvCompanys cellForRowAtIndexPath:indexPath];
    cell.isSelcet=YES;
    self.currectIndex=indexPath;
    
    switch (self.currenctType) {
        case ChooseTypeWater:
            [GVUserDefaults standardUserDefaults].selectedWaterCompanyIndex=self.currectIndex.row;
            break;
        case ChooseTypeHeat:
            [GVUserDefaults standardUserDefaults].selectedHeatCompanyIndex=self.currectIndex.row;
            break;
        case ChooseTypeGas:
            [GVUserDefaults standardUserDefaults].selectedGasCompanyIndex=self.currectIndex.row;
            break;
        case ChooseTypeElectric:
            [GVUserDefaults standardUserDefaults].selectedElectricCompanyIndex=self.currectIndex.row;
            break;
        case ChooseTypeProperty:
            [GVUserDefaults standardUserDefaults].selectedPropertyCompanyIndex=self.currectIndex.row;
            break;
        default:
            break;
    }

    
      CompanyChooseModel *model=[CompanyChooseModel new];
      NSDictionary *dict=[self.companysData objectAtIndex:indexPath.row];
        model.companyName=dict[@"title"];
        model.companyID=(NSInteger)dict[@"id"];
    if (self.companySelectDelegate) {
        [self.companySelectDelegate CompanySelect:model];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSIndexPath *)currectIndex{
    if (!_currectIndex) {
        NSInteger index;
        switch (self.currenctType) {
            case ChooseTypeWater:
                index=[GVUserDefaults standardUserDefaults].selectedWaterCompanyIndex;
                break;
            case ChooseTypeHeat:
                index=[GVUserDefaults standardUserDefaults].selectedHeatCompanyIndex;
                break;
            case ChooseTypeGas:
                index=[GVUserDefaults standardUserDefaults].selectedGasCompanyIndex;
                break;
            case ChooseTypeElectric:
                index=[GVUserDefaults standardUserDefaults].selectedElectricCompanyIndex;
                break;
            case ChooseTypeProperty:
                index=[GVUserDefaults standardUserDefaults].selectedPropertyCompanyIndex;
                break;
            default:
                break;
        }
         NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
        _currectIndex=indexPath;
    }
    return _currectIndex;
}

@end
