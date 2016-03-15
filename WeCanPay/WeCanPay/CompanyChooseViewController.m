//
//  CompanyChooseViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/3/15.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "CompanyChooseViewController.h"
#import <UIScrollView+EmptyDataSet.h>

@interface CompanyChooseViewController ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbvCompanys;
@property(nonatomic)NSMutableArray *otherButtons;

@end

@implementation CompanyChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tbvCompanys.emptyDataSetDelegate=self;
    self.tbvCompanys.emptyDataSetSource=self;
    self.tbvCompanys.dataSource=self;
    self.tbvCompanys.delegate=self;
    self.tbvCompanys.tableFooterView=[UIView new];
    [self.tbvCompanys registerNib:[UINib nibWithNibName:@"CompanyChooseCell" bundle:nil] forCellReuseIdentifier:@"CompanyChooseCellIdentifier"];
}



-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"eye"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CompanyChooseCellIdentifier"];
     DLRadioButton *btn=cell.contentView.subviews[0];
    if (indexPath.row==3) {
       
        [btn setSelected:YES];
    }
    if (indexPath.row!=0) {
        [self.otherButtons addObject:btn];
    }


        btn.otherButtons=self.otherButtons;
   
    return cell;
}



-(NSMutableArray *)otherButtons{
    if (!_otherButtons) {
        _otherButtons=[NSMutableArray new];
    }
    return _otherButtons;
}
@end
