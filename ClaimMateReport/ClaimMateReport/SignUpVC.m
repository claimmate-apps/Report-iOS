//
//  SignUpVC.m
//

#import "SignUpVC.h"

@implementation SignUpVC

#pragma mark - Synthesize

#pragma mark - ViewController Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [APPDELEGATE setupBorderColorWidth:viewName];
    [APPDELEGATE setupBorderColorWidth:viewMobile];
    [APPDELEGATE setupBorderColorWidth:viewEmail];
    [APPDELEGATE setupBorderColorWidth:viewPassword];
    [APPDELEGATE setupBorderColorWidth:viewConfirmPassword];
    
    [APPDELEGATE setupShadow:viewName WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewMobile WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewEmail WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewPassword WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewConfirmPassword WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:btnSignUp WithCornerRadius:4.f];
    
    [self setPlaceholder:txtName];
    [self setPlaceholder:txtMobile];
    [self setPlaceholder:txtEmail];
    [self setPlaceholder:txtPassword];
    [self setPlaceholder:txtConfirmPassword];
    
    MMNumberKeyboard *keyboard = [[MMNumberKeyboard alloc] initWithFrame:CGRectZero];
    keyboard.allowsDecimalPoint = NO;
    keyboard.delegate = self;
    keyboard.returnKeyTitle = @"return";
    keyboard.returnKeyButtonStyle = MMNumberKeyboardButtonStyleGray;
    txtMobile.inputView = keyboard;
}

#pragma mark - UI Methods
- (void)setPlaceholder:(UITextField *)textField {
    if (@available(iOS 10, *)) {
        textField.textContentType = @"";
    }
    
    textField.tintColor = [UIColor blackColor];
    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:textField.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}]];
}

- (void)newUser {
    if ([APPDELEGATE checkInternetConnectivity]) {
        [APPDELEGATE showLoading:self.view];
        
        NSDictionary *parameters = @{
                                     @"name": txtName.text,
                                     @"email": txtEmail.text,
                                     @"mobile": txtMobile.text,
                                     @"password": txtPassword.text
                                    };
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentTypes];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        [manager POST:[NSString stringWithFormat:@"%@%@",BaseURL,NewUser] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            [APPDELEGATE hideLoading:self.view];
            
            NSDictionary *dictData = (NSDictionary *)responseObject;
            NSLog(@"dictData: %@",dictData);
            
            if ([[dictData valueForKey:@"success"] isEqualToString:@"error"]) {
                [APPDELEGATE showMessageWithTitle:Error Message:[dictData valueForKey:@"message"]];
            }else {
                [self.navigationController popToRootViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SignUp" object:dictData];
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
    
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}

- (IBAction)onClickSignUp:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    if ([txtName.text isEqualToString:@""] || [txtMobile.text isEqualToString:@""] || [txtEmail.text isEqualToString:@""] || [txtPassword.text isEqualToString:@""] || [txtConfirmPassword.text isEqualToString:@""]) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
        return;
    }
    
    if ([txtMobile.text length] < 10) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"The Password must be at least 10 characters long."];
        return;
    }
    
    if ([APPDELEGATE isValidEmail:txtEmail.text] == FALSE) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"Please enter valid Email Address."];
        return;
    }
    
    if ([txtPassword.text length] < 6) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"The Password must be at least 6 characters long."];
        return;
    }
    
    if ([APPDELEGATE isValidPassword:txtPassword.text] == FALSE) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"Passwords must have at least one digit."];
        return;
    }
    
    if (![txtPassword.text isEqualToString:txtConfirmPassword.text]) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"Password and Confirm Password doesn't matched."];
        return;
    }
    
    [self newUser];
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
