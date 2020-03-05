//
//  ReportVC.m
//

#import "ReportVC.h"

@implementation ReportVC

#pragma mark - Synthesize
@synthesize dictPrev1 = _dictPrev1;
@synthesize dictPrev2 = _dictPrev2;
@synthesize isUpdate = _isUpdate;
@synthesize strPrev = _strPrev;
@synthesize strEmailSubject = _strEmailSubject;

#pragma mark - ViewController Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    txtViewReport.text = _strPrev;
    
    if (_isUpdate == true) {
        [btnSave setTitle:@"Update" forState:UIControlStateNormal];
    }else {
        [btnSave setTitle:@"Submit" forState:UIControlStateNormal];
    }
    
    [APPDELEGATE setupShadow:btnSave WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:btnSendEmail WithCornerRadius:4.f];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
}

#pragma mark - UI Methods
- (void)createReport1:(NSMutableDictionary *)parameter {
    if ([APPDELEGATE checkInternetConnectivity]) {
        [APPDELEGATE showLoading:self.view];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentTypes];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        [manager POST:[NSString stringWithFormat:@"%@%@",BaseURL,CreateReport1] parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
            [APPDELEGATE hideLoading:self.view];
            
            NSDictionary *dictData = (NSDictionary *)responseObject;
            NSLog(@"dictData: %@",dictData);
            
            if ([[dictData valueForKey:@"success"] isEqualToString:@"error"]) {
                [APPDELEGATE showMessageWithTitle:Error Message:[dictData valueForKey:@"message"]];
            }else {
                [self createReport2WithID:[dictData valueForKey:@"data"]];
            }
            
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            [APPDELEGATE hideLoading:self.view];
            [APPDELEGATE showMessageWithTitle:Error Message:[error localizedDescription]];
        }];
    }
}

- (void)createReport2WithID:(NSString *)strID {
    if ([APPDELEGATE checkInternetConnectivity]) {
        [APPDELEGATE showLoading:self.view];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentTypes];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] initWithDictionary:_dictPrev2];
        [parameter setValue:strID forKey:@"report_id"];
        
        [manager POST:[NSString stringWithFormat:@"%@%@",BaseURL,CreateReport2] parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
            [APPDELEGATE hideLoading:self.view];
            
            NSDictionary *dictData = (NSDictionary *)responseObject;
            NSLog(@"dictData: %@",dictData);
            
            if ([[dictData valueForKey:@"success"] isEqualToString:@"error"]) {
                [APPDELEGATE showMessageWithTitle:Error Message:[dictData valueForKey:@"message"]];
            }else {
                NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
                for (UIViewController *viewController in allViewControllers) {
                    if ([viewController isKindOfClass:[ReportsVC class]]) {
                        [self.navigationController popToViewController:viewController animated:YES];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadReport" object:dictData];
                        break;
                    }
                }
            }
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            [APPDELEGATE hideLoading:self.view];
            [APPDELEGATE showMessageWithTitle:Error Message:[error localizedDescription]];
        }];
    }
}

- (void)updateReport1:(NSMutableDictionary *)parameter {
    if ([APPDELEGATE checkInternetConnectivity]) {
        [APPDELEGATE showLoading:self.view];
    
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentTypes];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        [manager POST:[NSString stringWithFormat:@"%@%@",BaseURL,UpdateReport1] parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
            [APPDELEGATE hideLoading:self.view];
            
            NSDictionary *dictData = (NSDictionary *)responseObject;
            NSLog(@"dictData: %@",dictData);
            
            if ([[dictData valueForKey:@"success"] isEqualToString:@"error"]) {
                [APPDELEGATE showMessageWithTitle:Error Message:[dictData valueForKey:@"message"]];
            }else {
                [self updateReport2];
            }
            
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            [APPDELEGATE hideLoading:self.view];
            [APPDELEGATE showMessageWithTitle:Error Message:[error localizedDescription]];
        }];
    }
}

- (void)updateReport2 {
    if ([APPDELEGATE checkInternetConnectivity]) {
        [APPDELEGATE showLoading:self.view];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentTypes];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] initWithDictionary:_dictPrev2];
        
        [manager POST:[NSString stringWithFormat:@"%@%@",BaseURL,UpdateReport2] parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
            [APPDELEGATE hideLoading:self.view];
            
            NSDictionary *dictData = (NSDictionary *)responseObject;
            NSLog(@"dictData: %@",dictData);
            
            if ([[dictData valueForKey:@"success"] isEqualToString:@"error"]) {
                [APPDELEGATE showMessageWithTitle:Error Message:[dictData valueForKey:@"message"]];
            }else {
                NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
                for (UIViewController *viewController in allViewControllers) {
                    if ([viewController isKindOfClass:[ReportsVC class]]) {
                        [self.navigationController popToViewController:viewController animated:YES];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadReport" object:dictData];
                        break;
                    }
                }
            }
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            [APPDELEGATE hideLoading:self.view];
            [APPDELEGATE showMessageWithTitle:Error Message:[error localizedDescription]];
        }];
    }
}

#pragma mark - IBAction Methods
- (IBAction)onClickBack:(id)sender {
    if (txtViewReport != nil) {
        [txtViewReport resignFirstResponder];
    }
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)onClickSave:(id)sender {
    if (txtViewReport != nil) {
        [txtViewReport resignFirstResponder];
    }
    
    NSString *strReport = txtViewReport.text;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] initWithDictionary:_dictPrev1];
    [parameter setValue:strReport forKey:@"report"];
    
    if (_isUpdate == true) {
        [self updateReport1:parameter];
    }else {
        [self createReport1:parameter];
    }
}

- (IBAction)onClickSendEmail:(id)sender {
    if (txtViewReport != nil) {
        [txtViewReport resignFirstResponder];
    }
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
        mailVC.mailComposeDelegate = self;
        [mailVC setSubject:_strEmailSubject];
        [mailVC setMessageBody:txtViewReport.text isHTML:NO];
        [mailVC setToRecipients:@[[[NSUserDefaults standardUserDefaults] valueForKey:@"Email"]]];
        [self presentViewController:mailVC animated:YES completion:nil];
    }else {
        [APPDELEGATE showMessageWithTitle:Error Message:@"This device cannot send email"];
    }
}

#pragma mark - Delegate Methods
#pragma mark UITextView
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
         
#pragma mark MFMailComposeViewController
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultSent:
            // Email sent
            break;
        case MFMailComposeResultSaved:
            // Email saved
            break;
        case MFMailComposeResultCancelled:
            // Handle cancelling of the email
            break;
        case MFMailComposeResultFailed:
            // Handle failure to send.
            break;
        default:
            // A failure occurred while completing the email
            break;
    }

    [self dismissViewControllerAnimated:YES completion:NULL];
}
         
@end
