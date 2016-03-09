//
//  LORNetStateDelegate.h
//  WeCanPay
//
//  Created by wecan－mac on 16/3/9.
//  Copyright © 2016年 wecan. All rights reserved.
//

#ifndef LORNetStateDelegate_h
#define LORNetStateDelegate_h


#endif /* LORNetStateDelegate_h */

@protocol LORNetStateDelegate <NSObject>

@optional
-(void)NetWorkIsNo;
-(void)NetWorkIsWWAN;
-(void)NetWorkIsWIFI;
@end