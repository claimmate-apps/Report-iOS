//
//  SettingsVC.m
//

#import "SettingsVC.h"

@implementation SettingsVC

#pragma mark - Synthesize

#pragma mark - ViewController Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    txtEmail.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"Email"];
    txtDate.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"Date"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    datePicker = [[UIDatePicker alloc] init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setDate:[dateFormat dateFromString:txtDate.text]];
    [datePicker addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    txtDate.inputView = datePicker;
    
    dictCompany = [[NSDictionary alloc] initWithDictionary:[self getCompany]];
//    NSLog(@"dictCompany: %@",dictCompany);
    
    if (dictCompany != nil) {
        [btnCompany setTitle:[dictCompany valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnCompany setTitle:@"" forState:UIControlStateNormal];
    }
    
    [APPDELEGATE setupBorderColorWidth:viewEmail];
    [APPDELEGATE setupBorderColorWidth:viewAddValue];
    [APPDELEGATE setupBorderColorWidth:viewDate];
    [APPDELEGATE setupBorderColorWidth:viewCompany];
    
    [APPDELEGATE setupShadow:viewEmail WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewAddValue WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewDate WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewCompany WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:btnSave WithCornerRadius:4.f];
    
    [self setPlaceholder:txtEmail];
    [self setPlaceholder:txtDate];
    [self setupCustomeToolbar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
}

#pragma mark - UI Methods
- (void)datePickerValueChanged {
    UIDatePicker *picker = (UIDatePicker *)txtTemp.inputView;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    txtTemp.text = [NSString stringWithFormat:@"%@",dateString];
}

- (void)setPlaceholder:(UITextField *)textField {
    if (@available(iOS 10, *)) {
        textField.textContentType = @"";
    }
    
    textField.tintColor = [UIColor blackColor];
    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}]];
}

- (void)setupCustomeToolbar {
    toolbar = [[UIToolbar alloc] init];
    [toolbar sizeToFit];
    
    UIBarButtonItem *btnExtraSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onClickDone)];
    
    [toolbar setItems:[[NSArray alloc] initWithObjects:btnExtraSpace,btnDone,nil]];
    
    txtEmail.inputAccessoryView = toolbar;
    txtDate.inputAccessoryView = toolbar;
}

- (void)onClickDone {
    if (txtTemp == txtDate) {
        [self datePickerValueChanged];
    }
    
    [txtTemp resignFirstResponder];
    txtTemp = nil;
}

- (NSMutableDictionary *)getCompany {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    sqlite3 *database;
    sqlite3_stmt *statement;
    
    const char *dbpath = [APPDELEGATE.strDatabasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM \"%@\" WHERE selectname = '1'", @"Company"];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *Id = [APPDELEGATE checkValueWithStatement:statement Column:0];
                NSString *Name = [APPDELEGATE checkValueWithStatement:statement Column:1];
                NSString *SelectName = [APPDELEGATE checkValueWithStatement:statement Column:2];
                
                [dict setValue:Id forKey:@"id"];
                [dict setValue:Name forKey:@"name"];
                [dict setValue:SelectName forKey:@"selectname"];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    
    return dict;
}

#pragma mark - IBAction Methods
#pragma mark Other
- (IBAction)onClickBack:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)onClickSave:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    if ([txtEmail.text isEqualToString:@""] || [txtDate.text isEqualToString:@""]) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
        return;
    }
    
    if ([APPDELEGATE isValidEmail:txtEmail.text] == FALSE) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"Please enter valid Email Address."];
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:txtEmail.text forKey:@"Email"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setValue:txtDate.text forKey:@"Date"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)onClickAddValue:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    AddValueVC *objVC = (AddValueVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"AddValueVC"];
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)onClickCompany:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = true;
    objVC.diceSel = dictCompany;
    objVC.strTitle = @"Company";
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

#pragma mark DropDownVC
- (void)didPressBack:(NSDictionary *)dictData {
    dictCompany = dictData;
    
    if (dictData != nil) {
        [btnCompany setTitle:[dictData valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnCompany setTitle:@"" forState:UIControlStateNormal];
    }
}

@end
