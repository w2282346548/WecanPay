//
//  ProductConfig.m
//  WeCanPay
//
//  Created by wecan－mac on 16/2/25.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "ProductConfig.h"
#import <UIKit/UIKit.h>
#import "CRToast.h"

@implementation ProductConfig


-(NSDictionary *)CRToastOptions{
    if (!_CRToastOptions) {
        NSMutableDictionary *options=[@{kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
                                       kCRToastFontKey             : [UIFont fontWithName:@"HelveticaNeue-Light" size:16],
                                       kCRToastTextColorKey        : [UIColor whiteColor],
                                       kCRToastBackgroundColorKey  : HexRGBAlpha(0x000000, 0.7),
                                       kCRToastAnimationInDirectionKey:@(CRToastAnimationDirectionTop),
                                       kCRToastAnimationOutDirectionKey:@(CRToastAnimationDirectionBottom),
                                       kCRToastAutorotateKey       : @(YES)} mutableCopy
                                      ];
        return [NSDictionary dictionaryWithDictionary:options];
    }
    return _CRToastOptions;
    
}


@end
