//
//  MainViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/2/25.
//  Copyright © 2016年 wecan. All rights reserved.
//


//[self ShowMsg:@"错误"];
//[self.hub show:YES];

#import "MainViewController.h"
#import "LORAlphaNavController.h"
#import "Masonry.h"
#import "ZYBannerView.h"
#import "TLCityPickerController.h"
#import "LoginViewController.h"
#import "PayViewController.h"
#import "ChooseViewController.h"
#import "LORCustomMsgView.h"

@interface MainViewController ()<ZYBannerViewDataSource, ZYBannerViewDelegate,TLCityPickerDelegate>
@property (weak, nonatomic) IBOutlet UIView *LoginedView;

@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollerView;
@property (weak, nonatomic) IBOutlet UIButton *BtnLoginOrReg;
@property (strong, nonatomic)  UIButton *NavLeftButton;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *functionView;
@property (weak, nonatomic) IBOutlet UICollectionView *nineGridView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 防止block中的循环引用
    //__weak typeof(self) weakSelf = self;

    

       [self initNavBar];
    //self.bgScrollerView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    [self initheaderView];//初始化头部
    [self initfunctionView];//初始化九宫格
    [self initbannerView];//初始化广告
    
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;

}


-(void)viewWillAppear:(BOOL)animated{
    if (self.rdv_tabBarController.isTabBarHidden) {
        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    }
    
    if (![GVUserDefaults standardUserDefaults].isLogin) {
        [self.LoginedView setHidden:YES];
        [self.BtnLoginOrReg setHidden:NO];
    }else{
        [self.LoginedView setHidden:NO];
        [self.BtnLoginOrReg setHidden:YES];
    }
}

-(void)initNavBar{
    LORAlphaNavController *d= (LORAlphaNavController *)[self navigationController];
    d.barAlpha = 0.f;
    d.barColor=HexRGBAlpha(0x02C874, 1);
    
    self.NavLeftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.NavLeftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.NavLeftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.NavLeftButton setTitle:@"北京市" forState:UIControlStateNormal];
    [self.NavLeftButton addTarget:self action:@selector(NavLeftClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:self.NavLeftButton];
    
    [self.navigationItem setLeftBarButtonItem:left];
}




-(void)NavLeftClick{
    NSLog(@"click left");
    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
    [cityPickerVC setDelegate:self];
    
    cityPickerVC.locationCityID = @"1400010000";
    //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
}
-(void)initheaderView{
    self.headerView.backgroundColor=HexRGBAlpha(0x48d7b1, 1);
    [self.BtnLoginOrReg.layer setMasksToBounds:YES];
    [self.BtnLoginOrReg.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [self.BtnLoginOrReg.layer setBorderWidth:1.0]; //边框宽度
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 1, 1, 1 });
    
    [self.BtnLoginOrReg.layer setBorderColor:colorref];//边框颜色
    

}

-(void)initbannerView{
    ZYBannerView *banner=[[ZYBannerView alloc] init];
    banner.dataSource = self;
    banner.delegate = self;
    banner.shouldLoop=NO;
    banner.autoScroll=YES;
    banner.scrollInterval=3.5;
    [self.bannerView addSubview:banner];
 
    [banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
    
}

-(void)initfunctionView{
    
}

// 返回Banner需要显示Item(View)的个数
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner
{
    return self.dataArray.count;
}

// 返回Banner在不同的index所要显示的View (可以是完全自定义的view, 且无需设置frame)
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index
{
    // 取出数据
    NSString *imageName = self.dataArray[index];
    
    // 创建将要显示控件
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}

// 返回Footer在不同状态时要显示的文字
- (NSString *)banner:(ZYBannerView *)banner titleForFooterWithState:(ZYBannerFooterState)footerState
{
    if (footerState == ZYBannerFooterStateIdle) {
        return @"拖动进入下一页";
    } else if (footerState == ZYBannerFooterStateTrigger) {
        return @"释放进入下一页";
    }
    return nil;
}

#pragma mark - ZYBannerViewDelegate

// 在这里实现点击事件的处理
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld个项目", index);
}

// 在这里实现拖动footer后的事件处理
- (void)bannerFooterDidTrigger:(ZYBannerView *)banner
{
    NSLog(@"触发了footer");

}

#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
    [self.NavLeftButton setTitle:city.cityName forState:UIControlStateNormal];
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark Getter

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"ad_0.jpg", @"ad_1.jpg", @"ad_2.jpg"];
    }
    return _dataArray;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    return nil;
}
- (IBAction)btnFunClicked:(id)sender {
    BOOL islogin=[GVUserDefaults standardUserDefaults].isLogin;
    if (islogin) {
        ChooseViewController *chooseController=[[ChooseViewController alloc]initWithNibName:@"ChooseViewController" bundle:nil];
        switch (((UIButton *)sender).tag) {
            case 10:
                  chooseController.currenctType=ChooseTypeWater;
                break;
            case 11:
                chooseController.currenctType=ChooseTypeHeat;
                break;
            case 12:
                chooseController.currenctType=ChooseTypeGas;
                break;
            case 13:
                chooseController.currenctType=ChooseTypeElectric;
                break;
            case 14:
                chooseController.currenctType=ChooseTypeProperty;
                break;
            default:
                break;
        }
        [self.navigationController pushViewController:chooseController animated:YES];
        
    }else{
        [self GotoLogin];
    }

}

- (IBAction)BtnLoginOrRegClicked:(id)sender {
    
    [self GotoLogin];
}

-(void)GotoLogin{
    LoginViewController *login=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    LORAlphaNavController *loginNavigationController = [[LORAlphaNavController alloc] initWithRootViewController:login];
    loginNavigationController.modalPresentationStyle=UIModalPresentationFormSheet;
    loginNavigationController.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [self presentViewController:loginNavigationController animated:YES completion:nil];
}




-(void)NetWorkIsNo{
//[self ShowMsg:@"没有网络，请连接网络"];
    [self ShowLORMsg:@"没有网络，请连接网络"];
}
-(void)NetWorkIsWWAN{}
-(void)NetWorkIsWIFI{}

@end
