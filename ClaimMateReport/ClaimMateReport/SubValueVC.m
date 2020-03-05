//
//  SubValueVC.m
//

#import "SubValueVC.h"

@implementation SubValueVC

#pragma mark - Synthesize
@synthesize strTitle = _strTitle;

#pragma mark - ViewController Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    lblTitle.text = _strTitle;
    
    btnEdit.tag = 0;
    [tblView setEditing:false animated:false];
    [btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
    
    arrData = [[NSArray alloc] initWithArray:[self getData]];
//    NSLog(@"arrData: %@",arrData);
    
    if (arrData.count > 0) {
        lblNoData.hidden = true;
    }else {
        lblNoData.hidden = false;
        
        btnEdit.tag = 0;
        [tblView setEditing:false animated:false];
        [btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
    }
    
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

- (void)deleteData:(NSString *)strID {
    sqlite3 *database;
    sqlite3_stmt *statement;
    
    const char *dbpath = [APPDELEGATE.strDatabasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM \"%@\" WHERE id = \"%@\"", _strTitle, strID];
        const char *sqlStatement = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK) {
            while ( sqlite3_step(statement) == SQLITE_DONE ) {
//                NSLog(@"Deleted");
                
                arrData = [[NSArray alloc] initWithArray:[self getData]];
//                NSLog(@"arrData: %@",arrData);
                
                if (arrData.count > 0) {
                    lblNoData.hidden = true;
                }else {
                    lblNoData.hidden = false;
                    
                    btnEdit.tag = 0;
                    [tblView setEditing:false animated:false];
                    [btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
                }
                
                [tblView reloadData];
            }
        }else {
            NSLog(@"Error: %s", sqlite3_errmsg(database));
        }
        
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
}

- (void)updateName:(NSString *)strText WithID:(NSString *)strID {
    sqlite3 *database;
    
    if (sqlite3_open([APPDELEGATE.strDatabasePath UTF8String], &database) == SQLITE_OK) {
        NSString *updateCommand = [NSString stringWithFormat:@"UPDATE \"%@\" SET name = \"%@\" WHERE id = \"%@\"", _strTitle, strText, strID];
        
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

#pragma mark - IBAction Methods
- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)onClickEdit:(UIButton *)sender {
    if (sender.tag == 0) {
        sender.tag = 5;
        [tblView setEditing:true animated:true];
        [btnEdit setTitle:@"Done" forState:UIControlStateNormal];
    }else {
        sender.tag = 0;
        [tblView setEditing:false animated:true];
        [btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
    }
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
    static NSString *CellIdentifier = @"SubValueVCCell";
    
    SubValueVCCell *cell = (SubValueVCCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.delegate = self;
    cell.idx = indexPath.row;
    cell.tintColor = [UIColor blackColor];
    
    NSDictionary *dict = [arrData objectAtIndex:indexPath.row];
    if ([[dict valueForKey:@"selectname"] isEqualToString:@"1"]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.lblTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tblView.isEditing == true) {
        return YES;
    }else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tblView.isEditing == true) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *Delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

                NSDictionary *dict = [self->arrData objectAtIndex:indexPath.row];
//                NSLog(@"dict: %@",dict);
                
                [self deleteData:[dict valueForKey:@"id"]];
                
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

#pragma mark SubValueVCCell
- (void)didPressDetails:(NSInteger)index {
    if (tblView.isEditing == true) {
        return;
    }
    
    NSDictionary *dict = [arrData objectAtIndex:index];
//    NSLog(@"dict: %@",dict);
    
    btnEdit.tag = 0;
    [btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *btnDefault = [UIAlertAction actionWithTitle:@"Set as Default" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        for (NSDictionary *dict in self->arrData) {
            [self updateSelectName:@"0" WithID:[dict valueForKey:@"id"]];
        }
        
        [self updateSelectName:@"1" WithID:[dict valueForKey:@"id"]];
        
    }];
    
    UIAlertAction *btnUpdate = [UIAlertAction actionWithTitle:@"Update" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:self->_strTitle message:@"Please fill the required field." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.tintColor = [UIColor colorWithRed:49.f/255.f green:49.f/255.f blue:49.f/255.f alpha:1.f];
            textField.placeholder = @"Enter value";
            textField.text = [dict valueForKey:@"name"];
            textField.borderStyle = UITextBorderStyleNone;
        }];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Update" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UITextField *textField = alertController.textFields[0];
            textField.text = [textField.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
//            NSLog(@"%@",textField.text);
            
            if ([textField.text isEqualToString:@""]) {
                [textField becomeFirstResponder];
                [APPDELEGATE showMessageWithTitle:Error Message:@"Value should not be empty."];
                return;
            }
            
            [self updateName:textField.text WithID:[dict valueForKey:@"id"]];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        
    }];
    
    [alert addAction:Cancel];
    [alert addAction:btnDefault];
    [alert addAction:btnUpdate];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
