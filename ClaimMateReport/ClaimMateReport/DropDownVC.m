//
//  DropDownVC.m
//

#import "DropDownVC.h"

@implementation DropDownVC

#pragma mark - Synthesize
@synthesize delegate = _delegate;
@synthesize strTitle = _strTitle;
@synthesize diceSel = _diceSel;
@synthesize isFromSettings = _isFromSettings;

#pragma mark - ViewController Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    lblTitle.text = _strTitle;
    
    [APPDELEGATE setupShadow:viewAdd WithCornerRadius:viewAdd.frame.size.height / 2.f];
        
    if ([_strTitle isEqualToString:@"Company"]) {
        _strTitle = @"Company";
    }else if ([_strTitle isEqualToString:@"Edge Metal"]) {
        _strTitle = @"roof_edge_metal";
    }else if ([_strTitle isEqualToString:@"Type"]) {
        _strTitle = @"roof_type";
    }else if ([_strTitle isEqualToString:@"Dweling 1"]) {
        _strTitle = @"dwl_first";
    }else if ([_strTitle isEqualToString:@"Dweling 2"]) {
        _strTitle = @"dwl_second";
    }else if ([_strTitle isEqualToString:@"Dweling 3"]) {
        _strTitle = @"dwl_third";
    }else if ([_strTitle isEqualToString:@"Dweling 4"]) {
        _strTitle = @"dwl_fourth";
    }else if ([_strTitle isEqualToString:@"Dweling 5"]) {
        _strTitle = @"dwl_fifth";
    }else if ([_strTitle isEqualToString:@"Interior Damage"]) {
        _strTitle = @"dmg_interior_damage";
    }else if ([_strTitle isEqualToString:@"Roof"]) {
        _strTitle = @"dmg_roof";
    }else if ([_strTitle isEqualToString:@"Front Elevation"]) {
        _strTitle = @"dmg_elevation";
    }else if ([_strTitle isEqualToString:@"Left Elevation"]) {
        _strTitle = @"dmg_elevation";
    }else if ([_strTitle isEqualToString:@"Back Elevation"]) {
        _strTitle = @"dmg_elevation";
    }else if ([_strTitle isEqualToString:@"Right Elevation"]) {
        _strTitle = @"dmg_elevation";
    }else if ([_strTitle isEqualToString:@"Notes"]) {
        _strTitle = @"dmg_notes";
    }else if ([_strTitle isEqualToString:@"Title"]) {
        _strTitle = @"misc_title";
    }else {
        
    }
    
    arrData = [[NSArray alloc] initWithArray:[self getData]];
//    NSLog(@"arrData: %@",arrData);
    
    [tblView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
}

#pragma mark - UI Methods
- (NSMutableArray *)getData {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    sqlite3 *database;
    sqlite3_stmt *statement;
    
    const char *dbpath = [APPDELEGATE.strDatabasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM \"%@\"", _strTitle];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *Id = [APPDELEGATE checkValueWithStatement:statement Column:0];
                NSString *Name = [APPDELEGATE checkValueWithStatement:statement Column:1];
                NSString *SelectName = [APPDELEGATE checkValueWithStatement:statement Column:2];
                
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                [dict setValue:Id forKey:@"id"];
                [dict setValue:Name forKey:@"name"];
                [dict setValue:SelectName forKey:@"selectname"];
                
                [array addObject:dict];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    
    return array;
}

- (void)updateSelectName:(NSString *)strSelectName WithID:(NSString *)strID {
    sqlite3 *database;
    
    if (sqlite3_open([APPDELEGATE.strDatabasePath UTF8String], &database) == SQLITE_OK) {
        NSString *updateCommand = [NSString stringWithFormat:@"UPDATE \"%@\" SET selectname = \"%@\" WHERE id = \"%@\"", _strTitle, strSelectName, strID];
        
        const char *sqlStatement = [updateCommand UTF8String];
        sqlite3_stmt *compiledStmt;
        
        if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStmt, NULL) == SQLITE_OK) {
            if (SQLITE_DONE != sqlite3_step(compiledStmt)) {
                sqlite3_finalize(compiledStmt);
                sqlite3_close(database);
            }
        }
    }
    
    arrData = [[NSArray alloc] initWithArray:[self getData]];
//    NSLog(@"arrData: %@",arrData);
    
    [tblView reloadData];
}

- (void)insert:(NSString *)string {
    sqlite3 *database;
    sqlite3_stmt *statement;
    
    const char *dbpath = [APPDELEGATE.strDatabasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO '%@' (name,selectname) VALUES ('%@','%@')",_strTitle,string,@"0"];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Inserted");
            
            arrData = [[NSArray alloc] initWithArray:[self getData]];
//            NSLog(@"arrData: %@",arrData);
            
            [tblView reloadData];
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
}


#pragma mark - IBAction Methods
- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
    if([self.delegate respondsToSelector:@selector(didPressBack:title:)])
    {
        [_delegate didPressBack:_diceSel title:_strTitle];
    }
    if([self.delegate respondsToSelector:@selector(didPressBack:)])
    {
        [_delegate didPressBack:_diceSel];
    }
    
}

- (IBAction)onClickAdd:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:_strTitle message:@"Please fill the required field." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.tintColor = [UIColor colorWithRed:49.f/255.f green:49.f/255.f blue:49.f/255.f alpha:1.f];
        textField.placeholder = @"Enter value";
        textField.borderStyle = UITextBorderStyleNone;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField = alertController.textFields[0];
        textField.text = [textField.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
//        NSLog(@"%@",textField.text);
        
        if ([textField.text isEqualToString:@""]) {
            [textField becomeFirstResponder];
            [APPDELEGATE showMessageWithTitle:Error Message:@"Value should not be empty."];
            return;
        }
        
        [self insert:textField.text];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Delegate Methods
#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DropDownVCCell";
    
    DropDownVCCell *cell = (DropDownVCCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.delegate = self;
    cell.idx = indexPath.row;
    cell.tintColor = [UIColor blackColor];
    
    NSDictionary *dict = [arrData objectAtIndex:indexPath.row];
    if (_isFromSettings == true) {
        if ([[dict valueForKey:@"selectname"] isEqualToString:@"1"]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else {
        if (_diceSel != nil) {
            if ([[dict valueForKey:@"id"] isEqualToString:[_diceSel valueForKey:@"id"]]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    cell.lblTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark DropDownVCCell
- (void)didPressDetails:(NSInteger)index {
    if (tblView.isEditing == true) {
        return;
    }
    
    NSDictionary *dict = [arrData objectAtIndex:index];
//    NSLog(@"dict: %@",dict);
    _diceSel = dict;
    
    if (_isFromSettings == true) {
        for (NSDictionary *dict in arrData) {
            [self updateSelectName:@"0" WithID:[dict valueForKey:@"id"]];
        }
        
        [self updateSelectName:@"1" WithID:[dict valueForKey:@"id"]];
    }else {
        [tblView reloadData];
    }
}

@end
