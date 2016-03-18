//
//  LORMessageView.h
//  WeCanPay
//
//  Created by wecan－mac on 16/3/18.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LORMessage.h"


@interface LORMessageView : UIView

/**
 *  消息
 */
@property (nonatomic, readonly) NSString *title;


/** The displayed subtitle of this message */
@property (nonatomic, readonly) NSString *subtitle;
/**
 *  这个消息将显示在哪个控制器中
 */
@property (nonatomic, readonly) UIViewController *viewController;

/**
 *  消息显示的持续时间。如果是0，它会自动计算
 */
@property (nonatomic, assign) CGFloat duration;


/** View出现的位置 顶部或底部 */
@property (nonatomic, assign) LORMessageNotificationPosition messagePosition;

/** Is the message currenlty fully displayed? Is set as soon as the message is really fully visible */
@property (nonatomic, assign) BOOL messageIsFullyDisplayed;


@property (nonatomic,strong) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIColor *titleTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIFont *contentFont UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIColor *contentTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIImage *messageIcon UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIImage *errorIcon UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIImage *successIcon UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIImage *warningIcon UI_APPEARANCE_SELECTOR;

/**
 *  初始化View 不要从外部直接使用
 *
 *  @param title             消息
 *  @param image             自定义图片（可选）
 *  @param notificationType  view的type  color区别
 *  @param duration          view的显示时间（可选）
 *  @param viewController    哪个控制器显示
 *  @param callback          当用户点击该消息时，会将该块的回调函数回调
 *  @param buttonTitle       button 的消息
 *  @param buttonCallback    点击按钮的回调
 *  @param position          位置
 *  @param dismissingEnabled 消息是否消失
 *
 *  @return instancetype
 */
-(instancetype)initWithTitle:(NSString *)title
                    subtitle:(NSString *)subtitle
                       image:(UIImage *)image
                        type:(LORMessageNotificationType)aNotificationType
                    duration:(CGFloat)duration
            inViewController:(UIViewController *)viewController
                    callback:(void(^)())callback
                 buttonTitle:(NSString *)buttonTitle
              buttonCallback:(void(^)())buttonCallback
                  atPosition:(LORMessageNotificationPosition)position
        canBeDismissedByUser:(BOOL)dismissingEnabled;

/**
 *  消失
 */
-(void)fadeMeOut;

/**
 *  从文件中配置View的属性
 *
 *  @param file 文件路径
 */
+ (void)addNotificationDesignFromFile:(NSString *)file;


@end
