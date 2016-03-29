//
//  ProductConfig.h
//  WeCanPay
//
//  Created by wecan－mac on 16/2/25.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define API_LOGIN_URL @"http://192.168.1.117:8081/logintest.html"
//#define API_LOGIN_URL @"https://github.com"

@interface ProductConfig : NSObject
@property(nonatomic,strong)NSDictionary * CRToastOptions;

@end
