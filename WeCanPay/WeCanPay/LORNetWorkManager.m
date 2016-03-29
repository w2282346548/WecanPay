//
//  LORNetWorkManager.m
//  WeCanPay
//
//  Created by wecan－mac on 16/3/8.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "LORNetWorkManager.h"

@implementation LORNetWorkManager

+(instancetype)sharedManager{
    static  LORNetWorkManager *manager=nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        
        manager=[[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://baidu.com"]];
    });
    
    return manager;
}

-(instancetype)initWithBaseURL:(NSURL *)url{
    
    self=[super initWithBaseURL:url];
    if (self) {
        self.requestSerializer.timeoutInterval = 5;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
       // self.responseSerializer=[AFHTTPResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    
    return self;
}

-(void)requestWithMethod:(HTTPMethod)method WithUrl:(NSString *)url WithParams:(NSDictionary *)params WithSuccessBlock:(requestSuccessBlock)success WithFailureBlock:(requestFailureBlock)failure{
    
    switch (method) {
        case GET:{
        [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject: %@", responseObject);
            success(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error: %@", error);
            failure(error);
        }];
        
        }
        case POST:{
            
            [self POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"responseObject: %@", responseObject);
                success(responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"Error: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                failure(error);
            }];
            
            break;
        
        }
            default:
            break;
            
    }

}

@end
