//
//  AppDelegate.h
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
}

#pragma mark - Properties
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) Reachability *internetReachability;
@property (strong, nonatomic) NSString *strDatabaseName;
@property (strong, nonatomic) NSString *strDatabasePath;

#pragma mark - UI Methods
- (BOOL)checkInternetConnectivity;
- (void)showLoading:(UIView *)view;
- (void)hideLoading:(UIView *)view;
- (void)showMessageWithTitle:(NSString *)title Message:(NSString*)message;
- (void)setupShadow:(UIView *)view WithCornerRadius:(CGFloat)cornerRadius;
- (void)setupBorderColorWidth:(UIView *)view;
- (BOOL)isValidEmail:(NSString *)string;
- (BOOL)isValidPassword:(NSString *)string;
- (NSString *)checkValueWithStatement:(sqlite3_stmt *)statement Column:(int)column;
- (NSString *)isEmpty:(NSString *)string;

@end

