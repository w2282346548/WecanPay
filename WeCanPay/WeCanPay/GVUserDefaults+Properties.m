

#import "GVUserDefaults+Properties.h"

@implementation GVUserDefaults (Properties)

@dynamic userName;
@dynamic userPwd;
@dynamic isLogin;

- (NSDictionary *)setupDefaults {
    return @{
        @"userName": @"default",
        @"userPwd": @"default",
        @"isLogin": @NO,
   
    };
}

- (NSString *)transformKey:(NSString *)key {
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] uppercaseString]];
    return [NSString stringWithFormat:@"NSUserDefault%@", key];
}

@end
