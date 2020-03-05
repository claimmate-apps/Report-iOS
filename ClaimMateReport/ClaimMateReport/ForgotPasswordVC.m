//
//  ForgotPasswordVC.m
//

#import "ForgotPasswordVC.h"

@implementation ForgotPasswordVC

#pragma mark - Synthesize

#pragma mark - ViewController Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [APPDELEGATE setupBorderColorWidth:viewEmail];
    
    [APPDELEGATE setupShadow:viewEmail WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:btnSubmit WithCornerRadius:4.f];
    
    [self setPlaceholder:txtEmail];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
}

#pragma mark - UI Methods
- (void)setPlaceholder:(UITextField *)textField {
    if (@available(iOS 10, *)) {
        textField.textContentType = @"";
    }
    
    textField.tintColor = [UIColor blackColor];
    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:textField.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}]];
}

- (void)forgetPassword {
    if ([APPDELEGATE checkInternetConnectivity]) {
        [APPDELEGATE showLoading:self.view];
        
        NSDictionary *parameters = @{
                                     @"email": txtEmail.text
                                    };
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentTypes];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        [manager POST:[NSString stringWithFormat:@"%@%@",BaseURL,ForgetPassword] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            [APPDELEGATE hideLoading:self.view];
            
            NSDictionary *dictData = (NSDictionary *)responseObject;
            NSLog(@"dictData: %@",dictData);
            
            if ([[dictData valueForKey:@"success"] isEqualToString:@"error"]) {
                [APPDELEGATE showMessageWithTitle:Error Message:[dictData valueForKey:@"message"]];
            }else {
                [self.navigationController popToRootViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ForgotPassword" object:dictData];
            }
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            [APPDELEGATE hideLoading:self.view];
            [APPDELEGATE showMessageWithTitle:Error Message:[error localizedDescription]];
        }];
    }
}

#pragma mark - IBAction Methods
- (IBAction)onClickSubmit:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    if ([txtEmail.text isEqualToString:@""]) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
        return;
    }
    
    if ([APPDELEGATE isValidEmail:txtEmail.text] == FALSE) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"Please enter valid Email Address."];
        return;
    }
    
    [self forgetPassword];
}

- (IBAction)onClickBack:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
