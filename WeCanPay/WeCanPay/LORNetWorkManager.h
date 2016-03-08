//
//  LORNetWorkManager.h
//  WeCanPay
//
//  Created by wecan－mac on 16/3/8.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

/**
 *  请求成功回调block
 *
 *  @param dic
 */
typedef void(^requestSuccessBlock)(NSDictionary *dic);

/**
 *  请求失败回调block
 *
 *  @param error
 */
typedef void(^requestFailureBlock)(NSError *error);


typedef NS_ENUM(NSInteger,HTTPMethod) {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
};


@interface LORNetWorkManager : AFHTTPSessionManager

+(instancetype)sharedManager;
-(void)requestWithMethod:(HTTPMethod)method
                 WithUrl:(NSString*)url
              WithParams:(NSDictionary *)params
        WithSuccessBlock:(requestSuccessBlock)success
        WithFailureBlock:(requestFailureBlock)failure;

@end
