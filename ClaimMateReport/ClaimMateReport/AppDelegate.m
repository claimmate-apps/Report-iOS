//
//  AppDelegate.m
//

#import "AppDelegate.h"

@implementation AppDelegate

#pragma mark - Synthesize
@synthesize window = _window;
@synthesize strDatabaseName = _strDatabaseName;
@synthesize strDatabasePath = _strDatabasePath;

#pragma mark - Delegate Methods
#pragma mark UIApplication
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Create database
    [self checkAndCreateDatabase];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstTime"]) {
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isFirstTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"isUserLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"UserID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"UserData"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"claimzapp@gmail.com" forKey:@"Email"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"Company"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        
        [[NSUserDefaults standardUserDefaults] setValue:[dateFormatter stringFromDate:[NSDate date]] forKey:@"Date"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [IQKeyboardManager sharedManager].enable = true;
    [IQKeyboardManager sharedManager].enableAutoToolbar = false;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - UI Methods
- (BOOL)checkInternetConnectivity {
    BOOL isConnected = NO;
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
        isConnected = NO;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }else {
        isConnected = YES;
    }
    
    return isConnected;
}

- (void)showLoading:(UIView *)view {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    });
}

- (void)hideLoading:(UIView *)view {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:view animated:YES];
        });
    });
}

- (void)showMessageWithTitle:(NSString *)title Message:(NSString*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        
    }];
    
    [alert addAction:ok];
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)setupShadow:(UIView *)view WithCornerRadius:(CGFloat)cornerRadius {
    view.layer.masksToBounds = NO;
    view.layer.cornerRadius = cornerRadius;
    view.layer.shadowOffset = CGSizeMake(.0f,2.5f);
    view.layer.shadowRadius = 1.3f;
    view.layer.shadowOpacity = .6f;
    view.layer.shadowColor = [UIColor colorWithRed:.0f/255.0f green:.0f/255.0f blue:.0f/255.0f alpha:.8f].CGColor;
}

- (void)setupBorderColorWidth:(UIView *)view {
    view.layer.borderWidth = 1.f;
    view.layer.borderColor = [UIColor colorWithRed:.0f/255.0f green:.0f/255.0f blue:.0f/255.0f alpha:.2f].CGColor;
}

- (BOOL)isValidEmail:(NSString *)string {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

- (BOOL)isValidPassword:(NSString *)string {
    NSRange rang = [string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (!rang.length)
        return FALSE;  // No number;
    return TRUE;
}

- (NSString *)applicationCacheDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    return cachePath;
}

- (void)checkAndCreateDatabase {
    _strDatabaseName = @"claimmatedb.sqlite";
    NSString *documentsDir = [self applicationCacheDirectory];
    
    _strDatabasePath = [documentsDir stringByAppendingPathComponent:_strDatabaseName];
    
    BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:_strDatabasePath];
    
    if (success) {
        return;
    }
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:_strDatabaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:_strDatabasePath error:nil];
    
    NSLog(@"_strDatabasePath: %@",_strDatabasePath);
}

- (NSString *)checkValueWithStatement:(sqlite3_stmt *)statement Column:(int)column {
    const char *tmp = (const char *)sqlite3_column_text(statement, column);
    if (tmp == NULL) {
        return @"";
    }else {
        return [[NSString alloc] initWithUTF8String:tmp];
    }
}

- (NSString *)isEmpty:(NSString *)string {
    if (string == (id)[NSNull null] || string.length == 0 || [string isKindOfClass:[NSNull class]] || [string isEqualToString:@""] || [string isEqualToString:@"(null)"] || string == nil || [string isEqualToString:@"<null>"] || string == (id)[NSNull null]) {
        return @"";
    }
    return string;
}

@end
