//
//  ReportsVC.m
//

#import "ReportsVC.h"
#import "NewReportVC.h"

@implementation ReportsVC

#pragma mark - Synthesize

#pragma mark - ViewController Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    arrReport = [[NSArray alloc] init];
    
    btnEdit.tag = 0;
    [tblReport setEditing:false animated:false];
    [btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
    
    [APPDELEGATE setupShadow:viewAdd WithCornerRadius:viewAdd.frame.size.height / 2.f];
    [self getClaimmateReport];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadReport:) name:@"ReloadReport" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
}

#pragma mark - UI Methods
- (void)reloadReport:(NSNotification *)notification {
    NSDictionary *userInfo = (NSDictionary *)[notification object];
    [APPDELEGATE showMessageWithTitle:Success Message:[userInfo valueForKey:@"message"]];
    
    [self getClaimmateReport];
}

- (void)moreLogout {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:APP_NAME message:@"Are you sure want to logout?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *btnYes = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self logout];
    }];
    
    UIAlertAction *btnNo = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        
    }];
    
    [btnYes setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    [alert addAction:btnNo];
    [alert addAction:btnYes];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)getClaimmateReport {
    if ([APPDELEGATE checkInternetConnectivity]) {
        [APPDELEGATE showLoading:self.view];
        
        NSDictionary *parameters = @{
                                     @"user_id": [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"]
                                    };
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentTypes];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        [manager POST:[NSString stringWithFormat:@"%@%@",BaseURL,GetClaimmateReport] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            [APPDELEGATE hideLoading:self.view];
            
            NSDictionary *dictData = (NSDictionary *)responseObject;
            NSLog(@"dictData: %@",dictData);
            
            if ([[dictData valueForKey:@"success"] isEqualToString:@"error"]) {
                self->arrReport = nil;
                self->lblNoData.hidden = false;
            }else {
                self->arrReport = [dictData objectForKey:@"data"];
                
                if (self->arrReport.count > 0) {
                    self->lblNoData.hidden = true;
                }else {
                    self->lblNoData.hidden = false;
                    
                    self->btnEdit.tag = 0;
                    [self->tblReport setEditing:false animated:false];
                    [self->btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
                }
            }
            
            [self->tblReport reloadData];
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            [APPDELEGATE hideLoading:self.view];
            [APPDELEGATE showMessageWithTitle:Error Message:[error localizedDescription]];
        }];
    }
}

- (void)deleteClaimmateReport:(NSString *)strReportId {
    if ([APPDELEGATE checkInternetConnectivity]) {
        [APPDELEGATE showLoading:self.view];
        
        NSDictionary *parameters = @{
                                     @"report_id": strReportId
                                    };
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentTypes];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        [manager POST:[NSString stringWithFormat:@"%@%@",BaseURL,DeleteClaimmateReport] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            [APPDELEGATE hideLoading:self.view];
            
            NSDictionary *dictData = (NSDictionary *)responseObject;
            NSLog(@"dictData: %@",dictData);
            
            if ([[dictData valueForKey:@"success"] isEqualToString:@"error"]) {
                [APPDELEGATE showMessageWithTitle:Error Message:[dictData valueForKey:@"message"]];
            }else {
                [self getClaimmateReport];
            }
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            [APPDELEGATE hideLoading:self.view];
            [APPDELEGATE showMessageWithTitle:Error Message:[error localizedDescription]];
        }];
    }
}

- (void)logout {
    if ([APPDELEGATE checkInternetConnectivity]) {
        [APPDELEGATE showLoading:self.view];
        
        NSDictionary *parameters = @{
                                     @"user_id": [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"],
                                     @"app_type": @"inspect"
                                    };
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentTypes];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        [manager POST:[NSString stringWithFormat:@"%@%@",BaseURL,Logout] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            [APPDELEGATE hideLoading:self.view];
            
            NSDictionary *dictData = (NSDictionary *)responseObject;
            NSLog(@"dictData: %@",dictData);
            
            if ([[dictData valueForKey:@"success"] isEqualToString:@"error"]) {
                [APPDELEGATE showMessageWithTitle:Error Message:[dictData valueForKey:@"message"]];
            }else {
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
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Logout" object:self];
                [self.navigationController popToRootViewControllerAnimated:TRUE];
            }
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            [APPDELEGATE hideLoading:self.view];
            [APPDELEGATE showMessageWithTitle:Error Message:[error localizedDescription]];
        }];
    }
}

#pragma mark - IBAction Methods
- (IBAction)onClickAdd:(id)sender {
    NewReportVC *reportVC = (NewReportVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"NewReportVC"];
    
//    CreateReportVC *reportVC = (CreateReportVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"CreateReportVC"];
    [self.navigationController pushViewController:reportVC animated:YES];
}

- (IBAction)onClickMore:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *btnSettings = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        SettingsVC *objVC = (SettingsVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"SettingsVC"];
        [self.navigationController pushViewController:objVC animated:YES];
    }];
    
    UIAlertAction *btnLogout = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self moreLogout];
    }];
    
    UIAlertAction *Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        
    }];
    
    [alert addAction:Cancel];
    [alert addAction:btnSettings];
    [alert addAction:btnLogout];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)onClickEdit:(UIButton *)sender {
    if (sender.tag == 0) {
        sender.tag = 5;
        [tblReport setEditing:true animated:true];
        [btnEdit setTitle:@"Done" forState:UIControlStateNormal];
    }else {
        sender.tag = 0;
        [tblReport setEditing:false animated:true];
        [btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
    }
}

#pragma mark - Delegate Methods
#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrReport count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ReportsVCCell";
    
    ReportsVCCell *cell = (ReportsVCCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.delegate = self;
    cell.idx = indexPath.row;
    
    NSDictionary *dictReport = [arrReport objectAtIndex:indexPath.row];
    cell.lblTitle.text = [NSString stringWithFormat:@"%@ %@",[dictReport valueForKey:@"mr"],[dictReport valueForKey:@"claimant_name"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tblReport.isEditing == true) {
        return YES;
    }else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tblReport.isEditing == true) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *Delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

                NSDictionary *dictReport = [self->arrReport objectAtIndex:indexPath.row];
                [self deleteClaimmateReport:[dictReport valueForKey:@"id"]];
                
            }];
            [Delete setValue:[UIColor redColor] forKey:@"titleTextColor"];
            
            [alert addAction:Delete];
            UIAlertAction *Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                
            }];
            
            [alert addAction:Cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

#pragma mark ReportsVCCell
- (void)didPressDetails:(NSInteger)index {
    if (tblReport.isEditing == true) {
        return;
    }
    
    NSDictionary *dictReport = [arrReport objectAtIndex:index];
//    NSLog(@"dictReport: %@",dictReport);
    NewReportVC *objVC = (NewReportVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"NewReportVC"];
//    EditReportVC *objVC = (EditReportVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"EditReportVC"];
    objVC.dictPrev = dictReport;
    objVC.isEdit = true;
    [self.navigationController pushViewController:objVC animated:YES];
}

@end
