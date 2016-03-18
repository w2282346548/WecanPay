

#import "GVUserDefaults.h"


@interface GVUserDefaults (Properties)

@property (nonatomic, weak) NSString *userName;//用户名
@property (nonatomic, weak) NSString *userPwd;//密码
@property (nonatomic) BOOL isLogin;//是否已经登陆
@property (nonatomic) NSInteger selectedWaterCompanyIndex;//选择的水力公司Index
@property (nonatomic) NSInteger selectedHeatCompanyIndex;//选择的热力公司Index
@property (nonatomic) NSInteger selectedGasCompanyIndex;//选择的燃气公司公司Index
@property (nonatomic) NSInteger selectedElectricCompanyIndex;//选择的电力公司Index
@property (nonatomic) NSInteger selectedPropertyCompanyIndex;//选择的物业公司Index


@end
