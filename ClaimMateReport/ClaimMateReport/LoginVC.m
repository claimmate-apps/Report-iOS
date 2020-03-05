//
//  LoginVC.m
//

#import "LoginVC.h"

@implementation LoginVC

#pragma mark - Synthesize

#pragma mark - ViewController Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // For testing
//    txtEmail.text = @"snrathod@outlook.com";
//    txtPassword.text = @"snrathod";
    
    [APPDELEGATE setupBorderColorWidth:viewEmail];
    [APPDELEGATE setupBorderColorWidth:viewPassword];
    
    [APPDELEGATE setupShadow:viewEmail WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewPassword WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:btnSignIn WithCornerRadius:4.f];
    
    [self setPlaceholder:txtEmail];
    [self setPlaceholder:txtPassword];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:@"Logout" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forgotPassword:) name:@"ForgotPassword" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signUp:) name:@"SignUp" object:nil];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUserLogin"] == true) {
        ReportsVC *objVC = (ReportsVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"ReportsVC"];
        [self.navigationController pushViewController:objVC animated:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
}

#pragma mark - UI Methods
- (void)forgotPassword:(NSNotification *)notification {
    NSDictionary *userInfo = (NSDictionary *)[notification object];
    [APPDELEGATE showMessageWithTitle:Success Message:[userInfo valueForKey:@"message"]];
}

- (void)signUp:(NSNotification *)notification {
    NSDictionary *userInfo = (NSDictionary *)[notification object];
    [APPDELEGATE showMessageWithTitle:Success Message:[userInfo valueForKey:@"message"]];
}

- (void)setPlaceholder:(UITextField *)textField {
    if (@available(iOS 10, *)) {
        textField.textContentType = @"";
    }
    
    textField.tintColor = [UIColor blackColor];
    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:textField.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}]];
}

- (void)logout {
    txtEmail.text = @"";
    txtPassword.text = @"";
}

- (void)login {
    if ([APPDELEGATE checkInternetConnectivity]) {
        [APPDELEGATE showLoading:self.view];
        
        NSDictionary *parameters = @{
                                     @"email": txtEmail.text,
                                     @"password": txtPassword.text,
                                     @"device_token": [[[UIDevice currentDevice] identifierForVendor] UUIDString],
                                     @"app_type": @"inspect"
                                    };
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentTypes];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        [manager POST:[NSString stringWithFormat:@"%@%@",BaseURL,Login] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            [APPDELEGATE hideLoading:self.view];
            
            NSDictionary *dictData = (NSDictionary *)responseObject;
            NSLog(@"dictData: %@",dictData);
            
            if ([[dictData valueForKey:@"success"] isEqualToString:@"error"]) {
                [APPDELEGATE showMessageWithTitle:Error Message:[dictData valueForKey:@"message"]];
            }else {
                [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isUserLogin"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                NSDictionary *dictUserData = [dictData valueForKey:@"user_data"];
                [[NSUserDefaults standardUserDefaults] setValue:[dictUserData valueForKey:@"id"] forKey:@"UserID"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[NSUserDefaults standardUserDefaults] setObject:dictUserData forKey:@"UserData"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                ReportsVC *objVC = (ReportsVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"ReportsVC"];
                [self.navigationController pushViewController:objVC animated:YES];
            }
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            [APPDELEGATE hideLoading:self.view];
            [APPDELEGATE showMessageWithTitle:Error Message:[error localizedDescription]];
        }];
    }
}

#pragma mark - IBAction Methods
- (IBAction)onClickSignIn:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    if ([txtEmail.text isEqualToString:@""] || [txtPassword.text isEqualToString:@""]) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
        return;
    }
    
    [self login];
}

- (IBAction)onClickRegister:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    SignUpVC *objVC = (SignUpVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"SignUpVC"];
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)onClickForgotPassword:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    ForgotPasswordVC *objVC = (ForgotPasswordVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"ForgotPasswordVC"];
    [self.navigationController pushViewController:objVC animated:YES];
}

#pragma mark - Delegate Methods
#pragma mark UITextFiled
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    txtTemp = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    txtTemp.text = [txtTemp.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    [txtTemp resignFirstResponder];
    txtTemp = nil;
}

@end
