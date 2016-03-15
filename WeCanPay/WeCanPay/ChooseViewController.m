//
//  ChooseViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/3/1.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "ChooseViewController.h"
#import "PayViewController.h"
#import "UIScrollView+UITouchEvent.h"
#import "CompanyChooseViewController.h"

@interface ChooseViewController ()
@property (weak, nonatomic) IBOutlet UIButton *BtnGoNext;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imagePic;
@property (weak, nonatomic) IBOutlet UILabel *lbCompany;
@property (weak, nonatomic) IBOutlet DLRadioButton *btnCustomCompany;
@property (weak, nonatomic) IBOutlet DLRadioButton *btnWeiAnCompany;

@end

@implementation ChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self initNavBar];
    [self initCustomView];
}


-(void)initNavBar{

    LORAlphaNavController *d= (LORAlphaNavController *)[self navigationController];
    d.barAlpha = 1.f;
    d.barColor=HexRGBAlpha(0x48d7b1, 1);
    
    [self setTitle:self.chooseModel.title];
    
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    leftbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftbutton setTitle:@"返回" forState:UIControlStateNormal];
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [leftbutton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    UIImageView *imageview= [[UIImageView alloc]init];
    [imageview setImage:[UIImage imageNamed:@"fanhui"]];
    [leftbutton addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(leftbutton);
        make.left.mas_equalTo(leftbutton);
    }];

    [leftbutton addTarget:self action:@selector(NavLeftClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    [self.navigationItem setLeftBarButtonItem:left];
    
}


-(void)initCustomView{
    [self.imagePic setImage:[UIImage imageNamed:self.chooseModel.image]];
    [self.lbTitle setText:self.chooseModel.title];
    NSDictionary *dic= [self.chooseModel.companys objectAtIndex:1];
    self.lbCompany.text=[dic objectForKey:@"title"];
    [self.btnCustomCompany setTitle:self.lbCompany.text forState:UIControlStateNormal];
    
    
    ViewRadius(self.BtnGoNext, 3.f);

}

-(void)NavLeftClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)BtnGoNextClicked:(id)sender {
    PayViewController *payController=[[PayViewController alloc]initWithNibName:@"PayViewController" bundle:nil];
      [self.navigationController pushViewController:payController animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}




- (IBAction)BtnClicked:(UIControl *)sender {
    CompanyChooseViewController *companyChooseController=[[CompanyChooseViewController alloc]initWithNibName:@"CompanyChooseViewController" bundle:nil];
      [self.navigationController pushViewController:companyChooseController animated:YES];
}




#pragma marks --geter seter
-(ChooseViewModel *)chooseModel{
    
    if (!_chooseModel) {
      
        NSArray *array=[[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ChooseInfo" ofType:@"plist"]];
        _chooseModel=[[ChooseViewModel alloc]init];
        switch (_currenctType) {
            case ChooseTypeWater:{
                NSDictionary *dict=[array objectAtIndex:0];
                _chooseModel.title=[dict objectForKey:@"title"];
                _chooseModel.image=[dict objectForKey:@"image"];
                _chooseModel.companys =[dict objectForKey:@"companys"];
                break;
            }
            case ChooseTypeHeat:{
                NSDictionary *dict=[array objectAtIndex:1];
                _chooseModel.title=[dict objectForKey:@"title"];
                _chooseModel.image=[dict objectForKey:@"image"];
                _chooseModel.companys=[dict objectForKey:@"companys"];
                break;
            }
            case ChooseTypeGas:{
                NSDictionary *dict=[array objectAtIndex:2];
            
                _chooseModel.title=[dict objectForKey:@"title"];
                _chooseModel.image=[dict objectForKey:@"image"];
                _chooseModel.companys=[dict objectForKey:@"companys"];
                break;
            }
            case ChooseTypeElectric:{
                NSDictionary *dict=[array objectAtIndex:3];
                _chooseModel.title=[dict objectForKey:@"title"];
                _chooseModel.image=[dict objectForKey:@"image"];
                _chooseModel.companys=[dict objectForKey:@"companys"];
                break;
            }
            case ChooseTypeProperty:{
                NSDictionary *dict=[array objectAtIndex:4];
                _chooseModel.title=[dict objectForKey:@"title"];
                _chooseModel.image=[dict objectForKey:@"image"];
                _chooseModel.companys=[dict objectForKey:@"companys"];
                break;
            }
            default:
                break;
        }
    }

    return _chooseModel;
}

-(void)setCurrenctType:(ChooseType)currenctType{
    _currenctType=currenctType;
}

@end
