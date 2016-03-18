//
//  LORMessage.h
//  WeCanPay
//
//  Created by wecan－mac on 16/3/18.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import <UIKit/UIKit.h>


#define LOR_SYSTEM_VERSION_LESS_THAN(v)            ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
@class LORMessageView;

/** Define on which position a specific LORMessage should be displayed */
@protocol LORMessageViewProtocol<NSObject>

@optional
/** Implement this method to pass a custom position for a specific message */
- (CGFloat)messageLocationOfMessageView:(LORMessageView *)messageView;

/** You can custimze the given LORMessageView, like setting its alpha or adding a subview */
- (void)customizeMessageView:(LORMessageView *)messageView;

@end


typedef NS_ENUM(NSInteger, LORMessageNotificationType) {
    LORMessageNotificationTypeMessage = 0,
    LORMessageNotificationTypeWarning,
    LORMessageNotificationTypeError,
    LORMessageNotificationTypeSuccess
};
typedef NS_ENUM(NSInteger, LORMessageNotificationPosition) {
    LORMessageNotificationPositionTop = 0,
    LORMessageNotificationPositionNavBarOverlay,
    LORMessageNotificationPositionBottom
};

typedef NS_ENUM(NSInteger,LORMessageNotificationDuration) {
    LORMessageNotificationDurationAutomatic = 0,
    LORMessageNotificationDurationEndless = -1 // The notification is displayed until the user dismissed it or it is dismissed by calling dismissActiveNotification
};


@interface LORMessage : NSObject
/** By setting this delegate it's possible to set a custom offset for the notification view */
@property (nonatomic, assign) id <LORMessageViewProtocol>delegate;

+ (instancetype)sharedMessage;

+ (UIViewController *)defaultViewController;

/** Shows a notification message
 @param message The title of the notification view
 @param type The notification type (Message, Warning, Error, Success)
 */
+ (void)showNotificationWithTitle:(NSString *)message
                             type:(LORMessageNotificationType)type;

/** Shows a notification message
 @param title The title of the notification view
 @param subtitle The text that is displayed underneath the title
 @param type The notification type (Message, Warning, Error, Success)
 */
+ (void)showNotificationWithTitle:(NSString *)title
                         subtitle:(NSString *)subtitle
                             type:(LORMessageNotificationType)type;

/** Shows a notification message in a specific view controller
 @param viewController The view controller to show the notification in.
 You can use +setDefaultViewController: to set the the default one instead
 @param title The title of the notification view
 @param subtitle The text that is displayed underneath the title
 @param type The notification type (Message, Warning, Error, Success)
 */
+ (void)showNotificationInViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                                    type:(LORMessageNotificationType)type;

/** Shows a notification message in a specific view controller with a specific duration
 @param viewController The view controller to show the notification in.
 You can use +setDefaultViewController: to set the the default one instead
 @param title The title of the notification view
 @param subtitle The text that is displayed underneath the title
 @param type The notification type (Message, Warning, Error, Success)
 @param duration The duration of the notification being displayed
 */
+ (void)showNotificationInViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                                    type:(LORMessageNotificationType)type
                                duration:(NSTimeInterval)duration;

/** Shows a notification message in a specific view controller with a specific duration
 @param viewController The view controller to show the notification in.
 You can use +setDefaultViewController: to set the the default one instead
 @param title The title of the notification view
 @param subtitle The text that is displayed underneath the title
 @param type The notification type (Message, Warning, Error, Success)
 @param duration The duration of the notification being displayed
 @param dismissingEnabled Should the message be dismissed when the user taps/swipes it
 */
+ (void)showNotificationInViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                                    type:(LORMessageNotificationType)type
                                duration:(NSTimeInterval)duration
                    canBeDismissedByUser:(BOOL)dismissingEnabled;



/** Shows a notification message in a specific view controller
 @param viewController The view controller to show the notification in.
 @param title The title of the notification view
 @param subtitle The message that is displayed underneath the title (optional)
 @param image A custom icon image (optional)
 @param type The notification type (Message, Warning, Error, Success)
 @param duration The duration of the notification being displayed
 @param callback The block that should be executed, when the user tapped on the message
 @param buttonTitle The title for button (optional)
 @param buttonCallback The block that should be executed, when the user tapped on the button
 @param messagePosition The position of the message on the screen
 @param dismissingEnabled Should the message be dismissed when the user taps/swipes it
 */
+ (void)showNotificationInViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                                   image:(UIImage *)image
                                    type:(LORMessageNotificationType)type
                                duration:(NSTimeInterval)duration
                                callback:(void (^)())callback
                             buttonTitle:(NSString *)buttonTitle
                          buttonCallback:(void (^)())buttonCallback
                              atPosition:(LORMessageNotificationPosition)messagePosition
                    canBeDismissedByUser:(BOOL)dismissingEnabled;

/** Fades out the currently displayed notification. If another notification is in the queue,
 the next one will be displayed automatically
 @return YES if the currently displayed notification was successfully dismissed. NO if no notification
 was currently displayed.
 */
+ (BOOL)dismissActiveNotification;

/** Fades out the currently displayed notification with a completion block after the animation has finished. If another notification is in the queue,
 the next one will be displayed automatically
 @return YES if the currently displayed notification was successfully dismissed. NO if no notification
 was currently displayed.
 */
+ (BOOL)dismissActiveNotificationWithCompletion:(void (^)())completion;

/** Use this method to set a default view controller to display the messages in */
+ (void)setDefaultViewController:(UIViewController *)defaultViewController;

/** Set a delegate to have full control over the position of the message view */
+ (void)setDelegate:(id<LORMessageViewProtocol>)delegate;

/** Use this method to use custom designs in your messages. */
+ (void)addCustomDesignFromFileWithName:(NSString *)fileName;

/** Indicates whether a notification is currently active. */
+ (BOOL)isNotificationActive;

/** Returns the currently queued array of LORMessageView */
+ (NSArray *)queuedMessages;

/** Prepares the notification view to be displayed in the future. It is queued and then
 displayed in fadeInCurrentNotification.
 You don't have to use this method. */
+ (void)prepareNotificationToBeShown:(LORMessageView *)messageView;

/** Indicates whether currently the iOS 7 style of LORMessages is used
 This depends on the Base SDK and the currently used device */
+ (BOOL)iOS7StyleEnabled;

/** Indicates whether the current navigationBar is hidden by isNavigationBarHidden
 on the UINavigationController or isHidden on the navigationBar of the current
 UINavigationController */
+ (BOOL)isNavigationBarInNavigationControllerHidden:(UINavigationController *)navController;

@end
