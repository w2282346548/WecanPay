

#import "GVUserDefaults+Properties.h"

@implementation GVUserDefaults (Properties)

@dynamic userName;
@dynamic userPwd;
@dynamic isLogin;
@dynamic selectedWaterCompanyIndex;
@dynamic selectedHeatCompanyIndex;
@dynamic selectedGasCompanyIndex;
@dynamic selectedElectricCompanyIndex;
@dynamic selectedPropertyCompanyIndex;

- (NSDictionary *)setupDefaults {
    return @{
        @"userName": @"default",
        @"userPwd": @"default",
        @"isLogin": @NO,
        @"selectedWaterCompanyIndex":@0,
        @"selectedHeatCompanyIndex":@0,
        @"selectedGasCompanyIndex":@0,
        @"selectedElectricCompanyIndex":@0,
        @"selectedPropertyCompanyIndex":@0,
    };
}

- (NSString *)transformKey:(NSString *)key {
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] uppercaseString]];
    return [NSString stringWithFormat:@"NSUserDefault%@", key];
}

@end
