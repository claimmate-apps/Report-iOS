//
//  EditReportVC.m
//

#import "EditReportVC.h"

@implementation EditReportVC

#pragma mark - Synthesize
@synthesize dictPrev = _dictPrev;

#pragma mark - ViewController Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSLog(@"_dictPrev: %@",_dictPrev);
    
    [APPDELEGATE setupBorderColorWidth:viewMr];
    [APPDELEGATE setupBorderColorWidth:viewClaimantName];
    [APPDELEGATE setupBorderColorWidth:viewInsuredName];
    [APPDELEGATE setupBorderColorWidth:viewCausesOfLoss];
    [APPDELEGATE setupBorderColorWidth:viewDateOfLoss];
    [APPDELEGATE setupBorderColorWidth:viewMortgagee];
    [APPDELEGATE setupBorderColorWidth:viewDateOfInspected];
    [APPDELEGATE setupBorderColorWidth:viewTimeOfInspected];
    
    [APPDELEGATE setupShadow:viewMr WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewClaimantName WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewInsuredName WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewCausesOfLoss WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewDateOfLoss WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewMortgagee WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewDateOfInspected WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewTimeOfInspected WithCornerRadius:4.f];
    
    [self setPlaceholder:txtMr];
    [self setPlaceholder:txtClaimantName];
    [self setPlaceholder:txtInsuredName];
    [self setPlaceholder:txtCausesOfLoss];
    [self setPlaceholder:txtDateOfLoss];
    [self setPlaceholder:txtMortgagee];
    [self setPlaceholder:txtDateOfInspected];
    [self setPlaceholder:txtTimeOfInspected];
    
    [APPDELEGATE setupBorderColorWidth:viewPitch];
    [APPDELEGATE setupBorderColorWidth:viewLayers];
    [APPDELEGATE setupBorderColorWidth:viewEdgeMetal];
    [APPDELEGATE setupBorderColorWidth:viewType];
    [APPDELEGATE setupBorderColorWidth:viewAge];
    
    [APPDELEGATE setupShadow:viewPitch WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewLayers WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewEdgeMetal WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewType WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewAge WithCornerRadius:4.f];
    
    [self setPlaceholder:txtPitch];
    [self setPlaceholder:txtLayers];
    [self setPlaceholder:txtAge];
    
    [APPDELEGATE setupBorderColorWidth:viewStory];
    [APPDELEGATE setupBorderColorWidth:viewDweling1];
    [APPDELEGATE setupBorderColorWidth:viewDweling2];
    [APPDELEGATE setupBorderColorWidth:viewDweling3];
    [APPDELEGATE setupBorderColorWidth:viewDweling4];
    [APPDELEGATE setupBorderColorWidth:viewDweling5];
    
    [APPDELEGATE setupShadow:viewStory WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewDweling1 WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewDweling2 WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewDweling3 WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewDweling4 WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewDweling5 WithCornerRadius:4.f];
    
    [APPDELEGATE setupBorderColorWidth:viewInteriorDamage];
    [APPDELEGATE setupBorderColorWidth:viewRoof];
    [APPDELEGATE setupBorderColorWidth:viewFrontElevation];
    [APPDELEGATE setupBorderColorWidth:viewLeftElevation];
    [APPDELEGATE setupBorderColorWidth:viewBackElevation];
    [APPDELEGATE setupBorderColorWidth:viewRightElevation];
    [APPDELEGATE setupBorderColorWidth:viewNotes];
    
    [APPDELEGATE setupShadow:viewInteriorDamage WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewRoof WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewFrontElevation WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewLeftElevation WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewBackElevation WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewRightElevation WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewNotes WithCornerRadius:4.f];
    
    [APPDELEGATE setupBorderColorWidth:viewDropDown];
    [APPDELEGATE setupBorderColorWidth:viewDepreciation];
    [APPDELEGATE setupBorderColorWidth:viewAPSDamage];
    [APPDELEGATE setupBorderColorWidth:viewSalvage];
    [APPDELEGATE setupBorderColorWidth:viewAdded];
    [APPDELEGATE setupBorderColorWidth:viewRemoved];
    [APPDELEGATE setupBorderColorWidth:viewDropDownMisc];
    
    [APPDELEGATE setupShadow:viewDropDown WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewDepreciation WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewAPSDamage WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewSalvage WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewAdded WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewRemoved WithCornerRadius:4.f];
    [APPDELEGATE setupShadow:viewDropDownMisc WithCornerRadius:4.f];    
    
    [APPDELEGATE setupShadow:btnInside WithCornerRadius:4.f];
    
    [self setPlaceholder:txtStory];
    [self setupCustomeToolbar];
    
    // Initial information
    if ([[_dictPrev valueForKey:@"insuredNameDiffernt"] isEqualToString:@"0"]) {
        btnCheckInsuredName.tag = 0;
        isInsuredName = false;
        [btnCheckInsuredName setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        viewMainInsuredName.hidden = true;
    }else {
        btnCheckInsuredName.tag = 5;
        isInsuredName = true;
        [btnCheckInsuredName setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        viewMainInsuredName.hidden = false;
    }
    
    txtInsuredName.text = [_dictPrev valueForKey:@"insuredName"];
    txtCausesOfLoss.text = [_dictPrev valueForKey:@"causesOfLoss"];
    
    if ([[_dictPrev valueForKey:@"insuredPersonPresent"] isEqualToString:@"0"]) {
        btnCheckInsuredPerson.tag = 0;
        isInsuredPerson = false;
        [btnCheckInsuredPerson setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }else {
        btnCheckInsuredPerson.tag = 5;
        isInsuredPerson = true;
        [btnCheckInsuredPerson setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }
    
    if ([[_dictPrev valueForKey:@"isMortgagee"] isEqualToString:@"0"]) {
        btnCheckMortgagee.tag = 0;
        isMortgagee = false;
        [btnCheckMortgagee setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        viewMainMortgagee.hidden = true;
    }else {
        btnCheckMortgagee.tag = 5;
        isMortgagee = true;
        [btnCheckMortgagee setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        viewMainMortgagee.hidden = false;
    }
    
    txtMortgagee.text = [_dictPrev valueForKey:@"mortgagee"];
    
    if ([[_dictPrev valueForKey:@"isNoMortgagee"] isEqualToString:@"0"]) {
        btnCheckNoMortgagee.tag = 0;
        isNoMortgagee = false;
        [btnCheckNoMortgagee setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }else {
        btnCheckNoMortgagee.tag = 5;
        isNoMortgagee = true;
        [btnCheckNoMortgagee setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }
    
    arrMr = [[NSArray alloc] initWithObjects:@"Mr.", @"Ms.", @"Mr. & Ms.", @"None", nil];
    txtMr.text = [_dictPrev valueForKey:@"mr"];
    txtClaimantName.text = [_dictPrev valueForKey:@"claimant_name"];
    
    pickerMr = [[UIPickerView alloc] init];
    pickerMr.delegate = self;
    pickerMr.dataSource = self;
    pickerMr.showsSelectionIndicator = YES;
    NSUInteger index = [arrMr indexOfObject:txtMr.text];
    if (index < arrMr.count) {
        [pickerMr selectRow:[arrMr indexOfObject:txtMr.text] inComponent:0 animated:FALSE];
    }
    
    txtMr.inputView = pickerMr;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    dateOfLoss = [[UIDatePicker alloc] init];
    [dateOfLoss setDatePickerMode:UIDatePickerModeDate];
    
    NSLog(@"claim_id => %@", [_dictPrev valueForKey:@"claim_id"]);
    
    [dateOfLoss setDate:[dateFormat dateFromString:[_dictPrev valueForKey:@"dateLoss"]]];
    [dateOfLoss addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    txtDateOfLoss.inputView = dateOfLoss;
    txtDateOfLoss.text = [dateFormat stringFromDate:dateOfLoss.date];

    dateOfInspected = [[UIDatePicker alloc] init];
    [dateOfInspected setDatePickerMode:UIDatePickerModeDate];
    [dateOfInspected setDate:[dateFormat dateFromString:[_dictPrev valueForKey:@"dateInspected"]]];
    [dateOfInspected addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    txtDateOfInspected.inputView = dateOfInspected;
    txtDateOfInspected.text = [dateFormat stringFromDate:dateOfInspected.date];
    
    [dateFormat setDateFormat:@"hh:mm a"];
    
    timeOfInspected = [[UIDatePicker alloc] init];
    [timeOfInspected setDatePickerMode:UIDatePickerModeTime];
    [timeOfInspected setDate:[dateFormat dateFromString:[_dictPrev valueForKey:@"timeInspected"]]];
    [timeOfInspected addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    txtTimeOfInspected.inputView = timeOfInspected;
    txtTimeOfInspected.text = [dateFormat stringFromDate:timeOfInspected.date];
    
    // Roof
    if ([[_dictPrev valueForKey:@"isRoof"] isEqualToString:@"0"]) {
        btnCheckRoof.tag = 0;
        isRoof = false;
        [btnCheckRoof setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }else {
        btnCheckRoof.tag = 5;
        isRoof = true;
        [btnCheckRoof setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }
    
    txtPitch.text = [_dictPrev valueForKey:@"pitch"];
    txtLayers.text = [_dictPrev valueForKey:@"layers"];
    txtAge.text = [_dictPrev valueForKey:@"age"];
    
    dictEdgeMetal = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"roof_edge_metal" WithName:[_dictPrev valueForKey:@"edgeMetal"]]];
    if (dictEdgeMetal != nil) {
        [btnEdgeMetal setTitle:[dictEdgeMetal valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnEdgeMetal setTitle:@"" forState:UIControlStateNormal];
    }
    
    dictType = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"roof_type" WithName:[_dictPrev valueForKey:@"type"]]];
    if (dictType != nil) {
        [btnType setTitle:[dictType valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnType setTitle:@"" forState:UIControlStateNormal];
    }
    
    // Dweling
    txtStory.text = [_dictPrev valueForKey:@"story"];
    
    dictDweling1 = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dwl_first" WithName:[_dictPrev valueForKey:@"dwl_first"]]];
    if (dictDweling1 != nil) {
        [btnMainDweling1 setTitle:[dictDweling1 valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnMainDweling1 setTitle:@"" forState:UIControlStateNormal];
    }
    
    dictDweling2 = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dwl_second" WithName:[_dictPrev valueForKey:@"dwl_second"]]];
    if (dictDweling2 != nil) {
        [btnMainDweling2 setTitle:[dictDweling2 valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnMainDweling2 setTitle:@"" forState:UIControlStateNormal];
    }
    
    dictDweling3 = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dwl_third" WithName:[_dictPrev valueForKey:@"dwl_third"]]];
    if (dictDweling3 != nil) {
        [btnMainDweling3 setTitle:[dictDweling3 valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnMainDweling3 setTitle:@"" forState:UIControlStateNormal];
    }
    
    dictDweling4 = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dwl_fourth" WithName:[_dictPrev valueForKey:@"dwl_fourth"]]];
    if (dictDweling4 != nil) {
        [btnMainDweling4 setTitle:[dictDweling4 valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnMainDweling4 setTitle:@"" forState:UIControlStateNormal];
    }
    
    dictDweling5 = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dwl_fifth" WithName:[_dictPrev valueForKey:@"dwl_fifth"]]];
    if (dictDweling5 != nil) {
        [btnMainDweling5 setTitle:[dictDweling5 valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnMainDweling5 setTitle:@"" forState:UIControlStateNormal];
    }
    
    // Damage
    dictInteriorDamage = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_interior_damage" WithName:[_dictPrev valueForKey:@"dmg_interior"]]];
    if (dictInteriorDamage != nil) {
        [btnInteriorDamage setTitle:[dictInteriorDamage valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnInteriorDamage setTitle:@"" forState:UIControlStateNormal];
    }
    
    dictRoof = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_roof" WithName:[_dictPrev valueForKey:@"dmg_roof"]]];
    if (dictRoof != nil) {
        [btnRoof setTitle:[dictRoof valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnRoof setTitle:@"" forState:UIControlStateNormal];
    }
    
    dictFrontElevation = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_elevation" WithName:[_dictPrev valueForKey:@"dmg_front_eleva"]]];
    if (dictFrontElevation != nil) {
        [btnFrontElevation setTitle:[dictFrontElevation valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnFrontElevation setTitle:@"" forState:UIControlStateNormal];
    }
    
    dictLeftElevation = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_elevation" WithName:[_dictPrev valueForKey:@"dmg_left_eleva"]]];
    if (dictLeftElevation != nil) {
        [btnLeftElevation setTitle:[dictLeftElevation valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnLeftElevation setTitle:@"" forState:UIControlStateNormal];
    }
    
    dictBackElevation = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_elevation" WithName:[_dictPrev valueForKey:@"dmg_back_eleva"]]];
    if (dictBackElevation != nil) {
        [btnBackElevation setTitle:[dictBackElevation valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnBackElevation setTitle:@"" forState:UIControlStateNormal];
    }
    
    dictRightElevation = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_elevation" WithName:[_dictPrev valueForKey:@"dmg_right_eleva"]]];
    if (dictRightElevation != nil) {
        [btnRightElevation setTitle:[dictRightElevation valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnRightElevation setTitle:@"" forState:UIControlStateNormal];
    }
    
    dictNotes = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_notes" WithName:[_dictPrev valueForKey:@"dmg_notes"]]];
    if (dictNotes != nil) {
        [btnNotes setTitle:[dictNotes valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnNotes setTitle:@"" forState:UIControlStateNormal];
    }
    
    // Misc
    if ([[_dictPrev valueForKey:@"misc_op"] isEqualToString:@"0"]) {
        btnCheckOP.tag = 0;
        isOP = false;
        [btnCheckOP setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }else {
        btnCheckOP.tag = 5;
        isOP = true;
        [btnCheckOP setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }
    
    if ([[_dictPrev valueForKey:@"misc_depreciation"] isEqualToString:@"0"]) {
        btnCheckDepreciation.tag = 0;
        isDepreciation = false;
        [btnCheckDepreciation setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        viewMainDepreciation.hidden = true;
    }else {
        btnCheckDepreciation.tag = 5;
        isDepreciation = true;
        [btnCheckDepreciation setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        viewMainDepreciation.hidden = false;
    }
    
    txtDepreciation.text = [_dictPrev valueForKey:@"misc_depreciation_year"];
    
    if ([[_dictPrev valueForKey:@"misc_aps_damage"] isEqualToString:@"0"]) {
        btnCheckAPSDamage.tag = 0;
        isAPSDamage = false;
        [btnCheckAPSDamage setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        viewMainAPSDamage.hidden = true;
    }else {
        btnCheckAPSDamage.tag = 5;
        isAPSDamage = true;
        [btnCheckAPSDamage setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        viewMainAPSDamage.hidden = false;
    }
    
    txtAPSDamage.text = [_dictPrev valueForKey:@"misc_aps_damage_custome"];
    
    if ([[_dictPrev valueForKey:@"misc_contents"] isEqualToString:@"0"]) {
        btnCheckContents.tag = 0;
        isContents = false;
        [btnCheckContents setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }else {
        btnCheckContents.tag = 5;
        isContents = true;
        [btnCheckContents setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }
    
    if ([[_dictPrev valueForKey:@"misc_salvage"] isEqualToString:@"0"]) {
        btnCheckSalvage.tag = 0;
        isSalvage = false;
        [btnCheckSalvage setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        viewMainSalvage.hidden = true;
    }else {
        btnCheckSalvage.tag = 5;
        isSalvage = true;
        [btnCheckSalvage setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        viewMainSalvage.hidden = false;
    }
    
    txtSalvage.text = [_dictPrev valueForKey:@"misc_salvage_custom"];
    
    if ([[_dictPrev valueForKey:@"LaborMin"] isEqualToString:@"0"]) {
        btnLaborMin.tag = 0;
        isLaborMin = false;
        [btnLaborMin setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        viewMainAdded.hidden = true;
        viewMainRemoved.hidden = true;
    }else {
        btnLaborMin.tag = 5;
        isLaborMin = true;
        [btnLaborMin setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        viewMainAdded.hidden = false;
        viewMainRemoved.hidden = false;
    }
    
    dictDropDown = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"misc_title" WithName:[_dictPrev valueForKey:@"misc_title"]]];
    if (dictDropDown != nil) {
        [btnDropDown setTitle:[dictDropDown valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnDropDown setTitle:@"" forState:UIControlStateNormal];
    }
    
    dictDropDownMisc = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"Company" WithName:[_dictPrev valueForKey:@"all"]]];
    if (dictDropDownMisc != nil) {
        [btnDropDownMisc setTitle:[dictDropDownMisc valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnDropDownMisc setTitle:@"" forState:UIControlStateNormal];
    }
    
    txtAdded.text = [_dictPrev valueForKey:@"LaborMinAdded"];
    txtRemoved.text = [_dictPrev valueForKey:@"LaborMinRemoved"];
    
    [self setupScrollView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    
    return [super canPerformAction:action withSender:sender];
}

#pragma mark - UI Methods
- (void)setPlaceholder:(UITextField *)textField {
    if (@available(iOS 10, *)) {
        textField.textContentType = @"";
    }
    
    textField.tintColor = [UIColor blackColor];
    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}]];
}

- (void)datePickerValueChanged {
    UIDatePicker *picker = (UIDatePicker *)txtTemp.inputView;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    
    if (txtTemp == txtTimeOfInspected) {
        [dateFormat setDateFormat:@"hh:mm a"];
    }else {
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
    }
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    txtTemp.text = [NSString stringWithFormat:@"%@",dateString];
}

- (void)setupCustomeToolbar {
    toolbar = [[UIToolbar alloc] init];
    [toolbar sizeToFit];
    
    UIBarButtonItem *btnExtraSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onClickDone)];
    
    [toolbar setItems:[[NSArray alloc] initWithObjects:btnExtraSpace,btnDone,nil]];
    
    txtMr.inputAccessoryView = toolbar;
    txtDateOfLoss.inputAccessoryView = toolbar;
    txtDateOfInspected.inputAccessoryView = toolbar;
    txtTimeOfInspected.inputAccessoryView = toolbar;
}

- (void)onClickDone {
    if (txtTemp == txtDateOfLoss || txtTemp == txtDateOfInspected || txtTemp == txtTimeOfInspected) {
        [self datePickerValueChanged];
    }
    
    [txtTemp resignFirstResponder];
    txtTemp = nil;
}

- (NSMutableDictionary *)getDefault:(NSString *)strTable WithName:(NSString *)strName {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    sqlite3 *database;
    sqlite3_stmt *statement;
    
    const char *dbpath = [APPDELEGATE.strDatabasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM \"%@\" WHERE name = \"%@\"", strTable,strName];
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
    
    if ([dict allKeys].count > 0) {
        
    }else {
        [dict setValue:@"0" forKey:@"id"];
        [dict setValue:strName forKey:@"name"];
        [dict setValue:@"0" forKey:@"selectname"];
    }
    
    return dict;
}

- (NSString *)getReport {
    NSString *B6, *G6, *C7, *G7, *I7, *C8, *C9, *N6;
    B6 = @"Arrived for scheduled appointment at ";
    G6 = [APPDELEGATE isEmpty:txtTimeOfInspected.text];
    C7 = @"on";
    G7 = [APPDELEGATE isEmpty:txtDateOfInspected.text];
    I7 = [[APPDELEGATE isEmpty:txtMr.text] isEqualToString:@"None"] ? @"" : [NSString stringWithFormat:@"%@ %@",[APPDELEGATE isEmpty:txtMr.text], [APPDELEGATE isEmpty:txtClaimantName.text]];
    C8 = isInsuredPerson ? @" was not present during inspection and asked for me to inspect the loss alone." : @" was present during inspection.";
    C9 = @" An onsite inspection of the loss was performed and the following was found: ";
    N6 = [NSString stringWithFormat:@"%@%@ %@ %@. %@%@%@",B6, G6, C7, G7, I7, C8,C9];
    
    NSString *B11, *C12, *D12, *F12, *G12, *C13, *C14, *H15, *H16, *B46, *N11;
    B11 = @"DWELLING INSPECTION: ";
    C12 = [NSString stringWithFormat:@"%@ Story ",[APPDELEGATE isEmpty:txtStory.text]];
    D12 = [NSString stringWithFormat:@"%@ ",[APPDELEGATE isEmpty:btnMainDweling1.titleLabel.text]];
    F12 = [NSString stringWithFormat:@"%@ ",[APPDELEGATE isEmpty:btnMainDweling2.titleLabel.text]];
    G12 = [NSString stringWithFormat:@"%@",[APPDELEGATE isEmpty:btnMainDweling3.titleLabel.text]];
    C13 = [NSString stringWithFormat:@"%@",[APPDELEGATE isEmpty:btnMainDweling4.titleLabel.text]];
    C14 = @"- The dwelling appears to be owner occupied on a year round basis. ";
    H15 = @"- The exterior of the dwelling is ";
    H15 = [NSString stringWithFormat:@"%@%@ ",H15,[APPDELEGATE isEmpty:btnMainDweling5.titleLabel.text]];
    H16 = @"- The dwelling roof is ";
    H16 = [NSString stringWithFormat:@"%@%@ ",H16,[APPDELEGATE isEmpty:btnType.titleLabel.text]];
    H16 = [NSString stringWithFormat:@"%@%@",H16,[APPDELEGATE isEmpty:btnEdgeMetal.titleLabel.text]];
    B46 = isDepreciation ? [NSString stringWithFormat:@"- Depreciation documentation: Based on the age and condition of the materials, depreciation was set at %@ years.",[APPDELEGATE isEmpty:txtDepreciation.text]] : @"- Depreciation was not covered at inspection because depreciation is not applied.";
    N11 = [NSString stringWithFormat:@"%@\n%@%@%@%@\n%@\n\n%@\n%@\n%@\n%@",B11, C12, D12, F12, G12, C13, C14, H15, H16, B46];
    
    NSString *B18, *C19, *C20, *D20, *E20, *F20, *I20, *C21, *H21, *I21, *C22, *N16;
    B18 = @"ROOFING:";
    C19 = [NSString stringWithFormat:@"%@ Roof with a %@/12  Roof Pitch",C12, [APPDELEGATE isEmpty:txtPitch.text]];
    C20 = @"There is ";
    D20 = [APPDELEGATE isEmpty:txtLayers.text];
    E20 = @" Layer ";
    F20 = [APPDELEGATE isEmpty:btnType.titleLabel.text];
    I20 = @" on the roof of the dwelling. ";
    C21 = @"Approximate age of the roof in years:";
    H21 = [APPDELEGATE isEmpty:txtAge.text];
    I21 = @"yrs";
    C22 = @"ROOF: ";
    C22 = [NSString stringWithFormat:@"%@%@",C22,[[APPDELEGATE isEmpty:btnRoof.titleLabel.text] isEqualToString:@""] ? @"No roof damage." : [APPDELEGATE isEmpty:btnRoof.titleLabel.text]];
    N16 = [NSString stringWithFormat:@"\n%@\n%@ \n%@%@%@%@",B18, C19, C20, D20, E20, F20];
    N16 = [NSString stringWithFormat:@"%@%@",N16, [APPDELEGATE isEmpty:btnEdgeMetal.titleLabel.text]];
    N16 = [NSString stringWithFormat:@"%@%@\n%@%@%@\n%@\n",N16, I20, C21, H21, I21, C22];
    
    NSString *M16 = [APPDELEGATE isEmpty:txtAPSDamage.text];
    M16 = [NSString stringWithFormat:@"%@\n%@",M16, C22];
    
    NSString *E24, *B25, *E25, *B26, *E26, *B27, *E27, *B28, *E28, *B30, *E30, *F30, *G30, *B32, *C32, *B33, *C33, *B36, *C36, *B38, *C38, *G38, *B40, *G40, *I40, *B42, *D42, *B44, *N25;
    E24 = @"NO STORM RELATED DAMAGE FOUND TO THIS ELEVATION. NO REPAIRS RECOMMENDED.";
    B25 = @"Front elevation: ";
    E25 = [[APPDELEGATE isEmpty:btnFrontElevation.titleLabel.text] isEqualToString:@""] ? E24 : [APPDELEGATE isEmpty:btnFrontElevation.titleLabel.text];
    B26 = @"Left elevation: ";
    E26 = [[APPDELEGATE isEmpty:btnLeftElevation.titleLabel.text] isEqualToString:@""] ? E24 : [APPDELEGATE isEmpty:btnLeftElevation.titleLabel.text];
    B27 = @"Rear elevation: ";
    E27 = [[APPDELEGATE isEmpty:btnBackElevation.titleLabel.text] isEqualToString:@""] ? E24 : [APPDELEGATE isEmpty:btnBackElevation.titleLabel.text];
    B28 = @"Right elevation: ";
    E28 = [[APPDELEGATE isEmpty:btnRightElevation.titleLabel.text] isEqualToString:@""] ? E24 : [APPDELEGATE isEmpty:btnRightElevation.titleLabel.text];
    B30 = @"Interior of Dwelling: ";
    E30 = [[APPDELEGATE isEmpty:btnInteriorDamage.titleLabel.text] isEqualToString:@""] ? @"No Interior damage reported - Inspection of interior declined. " : [APPDELEGATE isEmpty:btnInteriorDamage.titleLabel.text];
    F30 = @"";
    G30 = @"";
    B32 = @"APS: ";
    C32 = isAPSDamage ? [APPDELEGATE isEmpty:txtAPSDamage.text] : @"There was no visible damage to the APS Structures or any fencing";
    B33 = @"CONTENTS: ";
    C33 = isContents ? @" Content damage being claimed on loss for Inside Rep to review- Overview photos of some contents included for Inside rep" : [NSString stringWithFormat:@" No content damage reported by %@",I7];
    B36 = @"ADDITIONAL:";
    C36 = @" No other visible damage found.";
    B38 = @"FIELD REVIEW: ";
    C38 = @"The following was reviewed with ";
    G38 = I7;
    B40 = @"- The scope of the inspection was reviewed with ";
    G40 = G38;
    I40 = @" in person. ";
    B42 = G38;
    D42 = @" acknowledged understanding and is in agreement with the scope of repairs.";
    B44 = @"- The claim process and file being subject to carriers review were addressed. ";
    N25 = [NSString stringWithFormat:@"%@%@\n%@%@\n%@%@\n%@%@\n\n%@%@%@%@\n\n%@%@\n%@%@\n%@%@\n\n\n%@%@%@\n%@%@%@\n%@%@\n%@",B25, E25, B26, E26, B27, E27, B28, E28, B30, E30, F30, G30, B32, C32, B33, C33, B36, C36, B38, C38, G38, B40, G40, I40, B42, D42, B44];
    
    NSString *N29, *O29, *M29;
    O29 = [NSString stringWithFormat:@"%@\n\n%@\n\n%@\n%@",N6, N11, N16, N25];
    M29 = [NSString stringWithFormat:@"%@\n\n%@\n\n%@\n%@",N6, N11, M16, N25];
    N29 = isRoof ? O29 : M29;
    
    NSString *M51, *M48, *B58, *C58, *B62, *B64, *B68, *D68, *B70, *D70, *M46, *N74;
    M51 = [NSString stringWithFormat:@"Discussed with %@ that I completed my inspection of damage to their property. I reviewed the scope of damages with them as noted in the above descriptions. I advised that I cannot comment on the payment of coverage but their Inside claim representative will do so upon receipt of my report. I let them know I would be submitting my report and that they should be hearing from their Inside Rep within 6 to 10 business days. ",I7];
    M51 = [NSString stringWithFormat:@"%@%@",M51,isMortgagee ? isNoMortgagee ? @"Confirmed No mortgage for this property." : [NSString stringWithFormat:@"Confirmed that %@ as the mortgage company.",[APPDELEGATE isEmpty:txtMortgagee.text]] : @""];
    M48 = isLaborMin ? [NSString stringWithFormat:@"LABOR MINIMUMS: %@ Labor Minimums were removed and %@ labor minimums were added to this estimate.",[APPDELEGATE isEmpty:txtRemoved.text], [APPDELEGATE isEmpty:txtAdded.text]] : @"";
    B58 = @"CAUSE OF LOSS: ";
    C58 = [NSString stringWithFormat:@"%@ - %@",[APPDELEGATE isEmpty:txtCausesOfLoss.text],[APPDELEGATE isEmpty:txtDateOfLoss.text]];
    B62 = @"SALVAGE: ";
    B62 = [NSString stringWithFormat:@"%@%@",B62, isSalvage ? [APPDELEGATE isEmpty:txtSalvage.text] : @"The discarded Materials have no value "];
    B64 = @"SUBROGATION: No subrogation available, this is a weather related claim. ";
    B68 = @"OVERHEAD & PROFIT: ";
    D68 = isOP ? @"- Based on the complexity of work & number of trades Overhead & Profit are necessary & therefore included in this estimate." : @"- Based on the complexity of work & number of trades Overhead & Profit are not necessary & there for NOT included in this estimate.";
    B70 = @"CLAIM COMPLETION: ";
    D70 = [NSString stringWithFormat:@" All documents and estimates are being forwarded via electronic upload to %@",[APPDELEGATE isEmpty:btnDropDownMisc.titleLabel.text]];
    M46 = [NSString stringWithFormat:@"%@\n\n%@\n%@%@\n%@\n%@\n%@%@\n\n%@%@",M51, M48, B58, C58, B62, B64, B68, D68, B70, D70];
    N74 = [NSString stringWithFormat:@"%@\n%@",N29, M46];
    
    return N74;
}

- (void)setupScrollView {
    // Initial information
    if (isInsuredName == true) {
        viewMainCausesOfLoss.frame = CGRectMake(viewMainCausesOfLoss.frame.origin.x, viewMainInsuredName.frame.origin.y + viewMainInsuredName.frame.size.height, viewMainCausesOfLoss.frame.size.width, viewMainCausesOfLoss.frame.size.height);
    }else {
        viewMainCausesOfLoss.frame = CGRectMake(viewMainCausesOfLoss.frame.origin.x, btnCheckInsuredName.frame.origin.y + btnCheckInsuredName.frame.size.height, viewMainCausesOfLoss.frame.size.width, viewMainCausesOfLoss.frame.size.height);
    }
    
    viewMainDateOfLoss.frame = CGRectMake(viewMainDateOfLoss.frame.origin.x, viewMainCausesOfLoss.frame.origin.y + viewMainCausesOfLoss.frame.size.height, viewMainDateOfLoss.frame.size.width, viewMainDateOfLoss.frame.size.height);
    
    btnCheckInsuredPerson.frame = CGRectMake(btnCheckInsuredPerson.frame.origin.x, viewMainDateOfLoss.frame.origin.y + viewMainDateOfLoss.frame.size.height, btnCheckInsuredPerson.frame.size.width, btnCheckInsuredPerson.frame.size.height);
    
    lblCheckInsuredPerson.frame = CGRectMake(lblCheckInsuredPerson.frame.origin.x, viewMainDateOfLoss.frame.origin.y + viewMainDateOfLoss.frame.size.height, lblCheckInsuredPerson.frame.size.width, lblCheckInsuredPerson.frame.size.height);
    
    btnCheckMortgagee.frame = CGRectMake(btnCheckMortgagee.frame.origin.x, btnCheckInsuredPerson.frame.origin.y + btnCheckInsuredPerson.frame.size.height, btnCheckMortgagee.frame.size.width, btnCheckMortgagee.frame.size.height);
    
    lblCheckMortgagee.frame = CGRectMake(lblCheckMortgagee.frame.origin.x, lblCheckInsuredPerson.frame.origin.y + lblCheckInsuredPerson.frame.size.height, lblCheckMortgagee.frame.size.width, lblCheckMortgagee.frame.size.height);
    
    if (isMortgagee == true) {
        viewMainMortgagee.frame = CGRectMake(viewMainMortgagee.frame.origin.x, btnCheckMortgagee.frame.origin.y + btnCheckMortgagee.frame.size.height, viewMainMortgagee.frame.size.width, viewMainMortgagee.frame.size.height);
        
        viewMainDateOfInspected.frame = CGRectMake(viewMainDateOfInspected.frame.origin.x, viewMainMortgagee.frame.origin.y + viewMainMortgagee.frame.size.height, viewMainDateOfInspected.frame.size.width, viewMainDateOfInspected.frame.size.height);
    }else {
        viewMainDateOfInspected.frame = CGRectMake(viewMainDateOfInspected.frame.origin.x, btnCheckMortgagee.frame.origin.y + btnCheckMortgagee.frame.size.height, viewMainDateOfInspected.frame.size.width, viewMainDateOfInspected.frame.size.height);
    }
    
    viewMainTimeOfInspected.frame = CGRectMake(viewMainTimeOfInspected.frame.origin.x, viewMainDateOfInspected.frame.origin.y + viewMainDateOfInspected.frame.size.height, viewMainTimeOfInspected.frame.size.width, viewMainTimeOfInspected.frame.size.height);
    
    // Roof
    viewROOF.frame = CGRectMake(viewROOF.frame.origin.x, viewMainTimeOfInspected.frame.origin.y + viewMainTimeOfInspected.frame.size.height + 8.f, viewROOF.frame.size.width, viewROOF.frame.size.height);
    
    btnCheckRoof.frame = CGRectMake(btnCheckRoof.frame.origin.x, viewROOF.frame.origin.y + viewROOF.frame.size.height + 4.f, btnCheckRoof.frame.size.width, btnCheckRoof.frame.size.height);
    
    lblCheckRoof.frame = CGRectMake(lblCheckRoof.frame.origin.x, viewROOF.frame.origin.y + viewROOF.frame.size.height + 4.f, lblCheckRoof.frame.size.width, lblCheckRoof.frame.size.height);
    
    viewMainPitch.frame = CGRectMake(viewMainPitch.frame.origin.x, btnCheckRoof.frame.origin.y + btnCheckRoof.frame.size.height, viewMainPitch.frame.size.width, viewMainPitch.frame.size.height);
    
    viewMainLayers.frame = CGRectMake(viewMainLayers.frame.origin.x, viewMainPitch.frame.origin.y + viewMainPitch.frame.size.height, viewMainLayers.frame.size.width, viewMainLayers.frame.size.height);
    
    viewMainEdgeMetal.frame = CGRectMake(viewMainEdgeMetal.frame.origin.x, viewMainLayers.frame.origin.y + viewMainLayers.frame.size.height, viewMainEdgeMetal.frame.size.width, viewMainEdgeMetal.frame.size.height);
    
    viewMainType.frame = CGRectMake(viewMainType.frame.origin.x, viewMainEdgeMetal.frame.origin.y + viewMainEdgeMetal.frame.size.height, viewMainType.frame.size.width, viewMainType.frame.size.height);
    
    viewMainAge.frame = CGRectMake(viewMainAge.frame.origin.x, viewMainType.frame.origin.y + viewMainType.frame.size.height, viewMainAge.frame.size.width, viewMainAge.frame.size.height);
    
    // Dweling
    viewDweling.frame = CGRectMake(viewDweling.frame.origin.x, viewMainAge.frame.origin.y + viewMainAge.frame.size.height + 8.f, viewDweling.frame.size.width, viewDweling.frame.size.height);
    
    viewMainStory.frame = CGRectMake(viewMainStory.frame.origin.x, viewDweling.frame.origin.y + viewDweling.frame.size.height, viewMainStory.frame.size.width, viewMainStory.frame.size.height);
    
    viewMainDweling1.frame = CGRectMake(viewMainDweling1.frame.origin.x, viewMainStory.frame.origin.y + viewMainStory.frame.size.height, viewMainDweling1.frame.size.width, viewMainDweling1.frame.size.height);
    
    viewMainDweling2.frame = CGRectMake(viewMainDweling2.frame.origin.x, viewMainDweling1.frame.origin.y + viewMainDweling1.frame.size.height, viewMainDweling2.frame.size.width, viewMainDweling2.frame.size.height);
    
    viewMainDweling3.frame = CGRectMake(viewMainDweling3.frame.origin.x, viewMainDweling2.frame.origin.y + viewMainDweling2.frame.size.height, viewMainDweling3.frame.size.width, viewMainDweling3.frame.size.height);
    
    viewMainDweling4.frame = CGRectMake(viewMainDweling4.frame.origin.x, viewMainDweling3.frame.origin.y + viewMainDweling3.frame.size.height, viewMainDweling4.frame.size.width, viewMainDweling4.frame.size.height);
    
    viewMainDweling5.frame = CGRectMake(viewMainDweling5.frame.origin.x, viewMainDweling4.frame.origin.y + viewMainDweling4.frame.size.height, viewMainDweling5.frame.size.width, viewMainDweling5.frame.size.height);
    
    // Damage
    viewDamage.frame = CGRectMake(viewDamage.frame.origin.x, viewMainDweling5.frame.origin.y + viewMainDweling5.frame.size.height + 8.f, viewDamage.frame.size.width, viewDamage.frame.size.height);
    
    viewMainInteriorDamage.frame = CGRectMake(viewMainInteriorDamage.frame.origin.x, viewDamage.frame.origin.y + viewDamage.frame.size.height, viewMainInteriorDamage.frame.size.width, viewMainInteriorDamage.frame.size.height);
    
    viewMainRoof.frame = CGRectMake(viewMainRoof.frame.origin.x, viewMainInteriorDamage.frame.origin.y + viewMainInteriorDamage.frame.size.height, viewMainRoof.frame.size.width, viewMainRoof.frame.size.height);
    
    viewMainFrontElevation.frame = CGRectMake(viewMainFrontElevation.frame.origin.x, viewMainRoof.frame.origin.y + viewMainRoof.frame.size.height, viewMainFrontElevation.frame.size.width, viewMainFrontElevation.frame.size.height);
    
    viewMainLeftElevation.frame = CGRectMake(viewMainLeftElevation.frame.origin.x, viewMainFrontElevation.frame.origin.y + viewMainFrontElevation.frame.size.height, viewMainLeftElevation.frame.size.width, viewMainLeftElevation.frame.size.height);
    
    viewMainBackElevation.frame = CGRectMake(viewMainBackElevation.frame.origin.x, viewMainLeftElevation.frame.origin.y + viewMainLeftElevation.frame.size.height, viewMainBackElevation.frame.size.width, viewMainBackElevation.frame.size.height);
    
    viewMainRightElevation.frame = CGRectMake(viewMainRightElevation.frame.origin.x, viewMainBackElevation.frame.origin.y + viewMainBackElevation.frame.size.height, viewMainRightElevation.frame.size.width, viewMainRightElevation.frame.size.height);
    
    viewMainNotes.frame = CGRectMake(viewMainNotes.frame.origin.x, viewMainRightElevation.frame.origin.y + viewMainRightElevation.frame.size.height, viewMainNotes.frame.size.width, viewMainNotes.frame.size.height);
    
    // Misc
    viewMisc.frame = CGRectMake(viewMisc.frame.origin.x, viewMainNotes.frame.origin.y + viewMainNotes.frame.size.height + 8.f, viewMisc.frame.size.width, viewMisc.frame.size.height);
    
    viewMainDropDown.frame = CGRectMake(viewMainDropDown.frame.origin.x, viewMisc.frame.origin.y + viewMisc.frame.size.height, viewMainDropDown.frame.size.width, viewMainDropDown.frame.size.height);
    
    btnCheckOP.frame = CGRectMake(btnCheckOP.frame.origin.x, viewMainDropDown.frame.origin.y + viewMainDropDown.frame.size.height, btnCheckOP.frame.size.width, btnCheckOP.frame.size.height);
    
    lblCheckOP.frame = CGRectMake(lblCheckOP.frame.origin.x, viewMainDropDown.frame.origin.y + viewMainDropDown.frame.size.height, lblCheckOP.frame.size.width, lblCheckOP.frame.size.height);
    
    btnCheckDepreciation.frame = CGRectMake(btnCheckDepreciation.frame.origin.x, btnCheckOP.frame.origin.y + btnCheckOP.frame.size.height, btnCheckDepreciation.frame.size.width, btnCheckDepreciation.frame.size.height);
    
    lblCheckDepreciation.frame = CGRectMake(lblCheckDepreciation.frame.origin.x, lblCheckOP.frame.origin.y + lblCheckOP.frame.size.height, lblCheckDepreciation.frame.size.width, lblCheckDepreciation.frame.size.height);
    
    if (isDepreciation == true) {
        viewMainDepreciation.frame = CGRectMake(viewMainDepreciation.frame.origin.x, btnCheckDepreciation.frame.origin.y + btnCheckDepreciation.frame.size.height, viewMainDepreciation.frame.size.width, viewMainDepreciation.frame.size.height);
        
        btnCheckAPSDamage.frame = CGRectMake(btnCheckAPSDamage.frame.origin.x, viewMainDepreciation.frame.origin.y + viewMainDepreciation.frame.size.height, btnCheckAPSDamage.frame.size.width, btnCheckAPSDamage.frame.size.height);
        
        lblCheckAPSDamage.frame = CGRectMake(lblCheckAPSDamage.frame.origin.x, viewMainDepreciation.frame.origin.y + viewMainDepreciation.frame.size.height, lblCheckAPSDamage.frame.size.width, lblCheckAPSDamage.frame.size.height);
    }else {
        btnCheckAPSDamage.frame = CGRectMake(btnCheckAPSDamage.frame.origin.x, btnCheckDepreciation.frame.origin.y + btnCheckDepreciation.frame.size.height, btnCheckAPSDamage.frame.size.width, btnCheckAPSDamage.frame.size.height);
        
        lblCheckAPSDamage.frame = CGRectMake(lblCheckAPSDamage.frame.origin.x, btnCheckDepreciation.frame.origin.y + btnCheckDepreciation.frame.size.height, lblCheckAPSDamage.frame.size.width, lblCheckAPSDamage.frame.size.height);
    }
    
    if (isAPSDamage == true) {
        viewMainAPSDamage.frame = CGRectMake(viewMainAPSDamage.frame.origin.x, btnCheckAPSDamage.frame.origin.y + btnCheckAPSDamage.frame.size.height, viewMainAPSDamage.frame.size.width, viewMainAPSDamage.frame.size.height);
        
        btnCheckContents.frame = CGRectMake(btnCheckContents.frame.origin.x, viewMainAPSDamage.frame.origin.y + viewMainAPSDamage.frame.size.height, btnCheckContents.frame.size.width, btnCheckContents.frame.size.height);
        
        lblCheckContents.frame = CGRectMake(lblCheckContents.frame.origin.x, viewMainAPSDamage.frame.origin.y + viewMainAPSDamage.frame.size.height, lblCheckContents.frame.size.width, lblCheckContents.frame.size.height);
    }else {
        btnCheckContents.frame = CGRectMake(btnCheckContents.frame.origin.x, btnCheckAPSDamage.frame.origin.y + btnCheckAPSDamage.frame.size.height, btnCheckContents.frame.size.width, btnCheckContents.frame.size.height);
        
        lblCheckContents.frame = CGRectMake(lblCheckContents.frame.origin.x, lblCheckAPSDamage.frame.origin.y + lblCheckAPSDamage.frame.size.height, lblCheckContents.frame.size.width, lblCheckContents.frame.size.height);
    }
    
    btnCheckSalvage.frame = CGRectMake(btnCheckSalvage.frame.origin.x, btnCheckContents.frame.origin.y + btnCheckContents.frame.size.height, btnCheckSalvage.frame.size.width, btnCheckSalvage.frame.size.height);
    
    lblCheckSalvage.frame = CGRectMake(lblCheckSalvage.frame.origin.x, lblCheckContents.frame.origin.y + lblCheckContents.frame.size.height, lblCheckSalvage.frame.size.width, lblCheckSalvage.frame.size.height);
    
    if (isSalvage == true) {
        viewMainSalvage.frame = CGRectMake(viewMainSalvage.frame.origin.x, btnCheckSalvage.frame.origin.y + btnCheckSalvage.frame.size.height, viewMainSalvage.frame.size.width, viewMainSalvage.frame.size.height);
        
        btnLaborMin.frame = CGRectMake(btnLaborMin.frame.origin.x, viewMainSalvage.frame.origin.y + viewMainSalvage.frame.size.height, btnLaborMin.frame.size.width, btnLaborMin.frame.size.height);
        
        lblLaborMin.frame = CGRectMake(lblLaborMin.frame.origin.x, viewMainSalvage.frame.origin.y + viewMainSalvage.frame.size.height, lblLaborMin.frame.size.width, lblLaborMin.frame.size.height);
    }else {
        btnLaborMin.frame = CGRectMake(btnLaborMin.frame.origin.x, btnCheckSalvage.frame.origin.y + btnCheckSalvage.frame.size.height, btnLaborMin.frame.size.width, btnLaborMin.frame.size.height);
        
        lblLaborMin.frame = CGRectMake(lblLaborMin.frame.origin.x, lblCheckSalvage.frame.origin.y + lblCheckSalvage.frame.size.height, lblLaborMin.frame.size.width, lblLaborMin.frame.size.height);
    }
    
    if (isLaborMin == true) {
        viewMainAdded.frame = CGRectMake(viewMainAdded.frame.origin.x, btnLaborMin.frame.origin.y + btnLaborMin.frame.size.height, viewMainAdded.frame.size.width, viewMainAdded.frame.size.height);
        
        viewMainRemoved.frame = CGRectMake(viewMainRemoved.frame.origin.x, viewMainAdded.frame.origin.y + viewMainAdded.frame.size.height, viewMainRemoved.frame.size.width, viewMainRemoved.frame.size.height);
        
        viewMainDropDownMisc.frame = CGRectMake(viewMainDropDownMisc.frame.origin.x, viewMainRemoved.frame.origin.y + viewMainRemoved.frame.size.height, viewMainDropDownMisc.frame.size.width, viewMainDropDownMisc.frame.size.height);
    }else {
        viewMainDropDownMisc.frame = CGRectMake(viewMainDropDownMisc.frame.origin.x, btnLaborMin.frame.origin.y + btnLaborMin.frame.size.height, viewMainDropDownMisc.frame.size.width, viewMainDropDownMisc.frame.size.height);
    }
    
    viewScroll.frame = CGRectMake(viewScroll.frame.origin.x, viewScroll.frame.origin.y, viewScroll.frame.size.width, viewMainDropDownMisc.frame.origin.y + viewMainDropDownMisc.frame.size.height + 8.f);
    tblView.contentSize = viewScroll.frame.size;
    [tblView reloadData];
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

- (IBAction)onClickInside:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    if ([txtClaimantName.text isEqualToString:@""] || [txtCausesOfLoss.text isEqualToString:@""]) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
        return;
    }
    
    if (isInsuredName == true) {
        if ([txtInsuredName.text isEqualToString:@""]) {
            [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
            return;
        }
    }
    
    if (isMortgagee == true) {
        if ([txtMortgagee.text isEqualToString:@""]) {
            [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
            return;
        }
    }
    
    if ([txtPitch.text isEqualToString:@""] || [txtLayers.text isEqualToString:@""] || [txtAge.text isEqualToString:@""]) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
        return;
    }
    
    if ([txtStory.text isEqualToString:@""]) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
        return;
    }
    
    if (isDepreciation == true) {
        if ([txtDepreciation.text isEqualToString:@""]) {
            [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
            return;
        }
    }
    
    if (isAPSDamage == true) {
        if ([txtAPSDamage.text isEqualToString:@""]) {
            [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
            return;
        }
    }
    
    if (isSalvage == true) {
        if ([txtSalvage.text isEqualToString:@""]) {
            [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
            return;
        }
    }
    
    if (isLaborMin == true) {
        if ([txtAdded.text isEqualToString:@""] || [txtRemoved.text isEqualToString:@""]) {
            [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
            return;
        }
    }
    
    NSDictionary *dictUserData = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserData"];
    NSDictionary *parameters1 = @{
                                 @"report_id": [_dictPrev valueForKey:@"id"],
                                 @"user_name": [dictUserData valueForKey:@"fullname"],
                                 @"report": @"",
                                 @"mr": [APPDELEGATE isEmpty:txtMr.text],
                                 @"claimant_name": [APPDELEGATE isEmpty:txtClaimantName.text],
                                 @"insuredNameDiffernt": isInsuredName ? @"1" : @"0",
                                 @"insuredName": isInsuredName ? [APPDELEGATE isEmpty:txtInsuredName.text] : @"",
                                 @"causesOfLoss": [APPDELEGATE isEmpty:txtCausesOfLoss.text],
                                 @"dateLoss": [APPDELEGATE isEmpty:txtDateOfLoss.text],
                                 @"insuredPersonPresent": isInsuredPerson ? @"1" : @"0",
                                 @"isMortgagee": isMortgagee ? @"1" : @"0",
                                 @"mortgagee": isMortgagee ? [APPDELEGATE isEmpty:txtMortgagee.text] : @"",
                                 @"isNoMortgagee": isMortgagee ? isNoMortgagee ? @"1" : @"0" : @"0",
                                 @"dateInspected": [APPDELEGATE isEmpty:txtDateOfInspected.text],
                                 @"timeInspected": [APPDELEGATE isEmpty:txtTimeOfInspected.text],
                                 @"isRoof": isRoof ? @"1" : @"0",
                                 @"pitch": [APPDELEGATE isEmpty:txtPitch.text],
                                 @"layers": [APPDELEGATE isEmpty:txtLayers.text],
                                 @"edgeMetal": [APPDELEGATE isEmpty:btnEdgeMetal.titleLabel.text],
                                 @"edgeMetalCustom": @"",
                                 @"type": [APPDELEGATE isEmpty:btnType.titleLabel.text],
                                 @"typeCustom": @"",
                                 @"age": [APPDELEGATE isEmpty:txtAge.text],
                                 @"story": [APPDELEGATE isEmpty:txtStory.text],
                                 @"dwl_first": [APPDELEGATE isEmpty:btnMainDweling1.titleLabel.text],
                                 @"dwl_first_custom": @"",
                                 @"dwl_second": [APPDELEGATE isEmpty:btnMainDweling2.titleLabel.text],
                                 @"dwl_second_custom": @"",
                                 @"dwl_third": [APPDELEGATE isEmpty:btnMainDweling3.titleLabel.text],
                                 @"dwl_third_custom": @"",
                                 @"dwl_fourth": [APPDELEGATE isEmpty:btnMainDweling4.titleLabel.text],
                                 @"dwl_fourth_custom": @"",
                                 @"dwl_fifth": [APPDELEGATE isEmpty:btnMainDweling5.titleLabel.text],
                                 @"dwl_fifth_custom": @""
                                };
    
    NSDictionary *parameters2 = @{
                                 @"report_id": [_dictPrev valueForKey:@"id"],
                                 @"dmg_interior": [APPDELEGATE isEmpty:btnInteriorDamage.titleLabel.text],
                                 @"dmg_interior_custom": @"",
                                 @"dmg_roof": [APPDELEGATE isEmpty:btnRoof.titleLabel.text],
                                 @"dmg_roof_custom": @"",
                                 @"dmg_front_eleva": [APPDELEGATE isEmpty:btnFrontElevation.titleLabel.text],
                                 @"dmg_front_custom": @"",
                                 @"dmg_left_eleva": [APPDELEGATE isEmpty:btnLeftElevation.titleLabel.text],
                                 @"dmg_left_custom": @"",
                                 @"dmg_back_eleva": [APPDELEGATE isEmpty:btnBackElevation.titleLabel.text],
                                 @"dmg_back_custom": @"",
                                 @"dmg_right_eleva": [APPDELEGATE isEmpty:btnRightElevation.titleLabel.text],
                                 @"dmg_right_custom": @"",
                                 @"dmg_notes": [APPDELEGATE isEmpty:btnNotes.titleLabel.text],
                                 @"dmg_notes_custom": @"",
                                 @"misc_title": [APPDELEGATE isEmpty:btnDropDown.titleLabel.text],
                                 @"misc_title_custom": @"",
                                 @"misc_op": isOP ? @"1" : @"0",
                                 @"misc_depreciation": isDepreciation ? @"1" : @"0",
                                 @"misc_depreciation_year": isDepreciation ? [APPDELEGATE isEmpty:txtDepreciation.text] : @"",
                                 @"misc_aps_damage": isAPSDamage ? @"1" : @"0",
                                 @"misc_aps_damage_custome": [APPDELEGATE isEmpty:txtAPSDamage.text],
                                 @"misc_contents": isContents ? @"1" : @"0",
                                 @"misc_salvage": isSalvage ? @"1" : @"0",
                                 @"misc_salvage_custom": isSalvage ? [APPDELEGATE isEmpty:txtSalvage.text] : @"",
                                 @"LaborMin": isLaborMin ? @"1" : @"0",
                                 @"LaborMinAdded": isLaborMin ? [APPDELEGATE isEmpty:txtAdded.text] : @"",
                                 @"LaborMinRemoved": isLaborMin ? [APPDELEGATE isEmpty:txtRemoved.text] : @"",
                                 @"all": [APPDELEGATE isEmpty:btnDropDownMisc.titleLabel.text],
                                 @"AllCustom": @"",
                                };
    
    ReportVC *objVC = (ReportVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"ReportVC"];
    objVC.isUpdate = true;
    objVC.dictPrev1 = parameters1;
    objVC.dictPrev2 = parameters2;
    objVC.strPrev = [self getReport];
    objVC.strEmailSubject = [NSString stringWithFormat:@"%@ Inspection Report",[[APPDELEGATE isEmpty:txtMr.text] isEqualToString:@"None"] ? @"" : [NSString stringWithFormat:@"%@ %@",[APPDELEGATE isEmpty:txtMr.text], [APPDELEGATE isEmpty:txtClaimantName.text]]];
    [self.navigationController pushViewController:objVC animated:YES];
}

#pragma mark Initial information
- (IBAction)onClickCheckInsuredName:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    if (btnTemp.tag == 0) {
        btnTemp.tag = 5;
        isInsuredName = true;
        [btnTemp setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        viewMainInsuredName.hidden = false;
    }else {
        btnTemp.tag = 0;
        isInsuredName = false;
        [btnTemp setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        viewMainInsuredName.hidden = true;
    }
    
    [self setupScrollView];
}

- (IBAction)onClickCheckInsuredPerson:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    if (btnTemp.tag == 0) {
        btnTemp.tag = 5;
        isInsuredPerson = true;
        [btnTemp setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }else {
        btnTemp.tag = 0;
        isInsuredPerson = false;
        [btnTemp setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    
    [self setupScrollView];
}

- (IBAction)onClickCheckMortgagee:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    if (btnTemp.tag == 0) {
        btnTemp.tag = 5;
        isMortgagee = true;
        [btnTemp setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        viewMainMortgagee.hidden = false;
    }else {
        btnTemp.tag = 0;
        isMortgagee = false;
        [btnTemp setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        viewMainMortgagee.hidden = true;
    }
    
    [self setupScrollView];
}

- (IBAction)onClickCheckNoMortgagee:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    if (btnTemp.tag == 0) {
        btnTemp.tag = 5;
        isNoMortgagee = true;
        [btnTemp setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }else {
        btnTemp.tag = 0;
        isNoMortgagee = false;
        [btnTemp setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    
    [self setupScrollView];
}

#pragma mark Roof
- (IBAction)onClickCheckRoof:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    if (btnTemp.tag == 0) {
        btnTemp.tag = 5;
        isRoof = true;
        [btnTemp setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }else {
        btnTemp.tag = 0;
        isRoof = false;
        [btnTemp setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    
    [self setupScrollView];
}

- (IBAction)onClickEdgeMetal:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictEdgeMetal;
    objVC.strTitle = @"Edge Metal";
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)onClickType:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictType;
    objVC.strTitle = @"Type";
    [self.navigationController pushViewController:objVC animated:YES];
}

#pragma mark Dweling
- (IBAction)onClickDweling1:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictDweling1;
    objVC.strTitle = @"Dweling 1";
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)onClickDweling2:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictDweling2;
    objVC.strTitle = @"Dweling 2";
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)onClickDweling3:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictDweling3;
    objVC.strTitle = @"Dweling 3";
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)onClickDweling4:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictDweling4;
    objVC.strTitle = @"Dweling 4";
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)onClickDweling5:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictDweling5;
    objVC.strTitle = @"Dweling 5";
    [self.navigationController pushViewController:objVC animated:YES];
}

#pragma mark Damage
- (IBAction)onClickInteriorDamage:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictInteriorDamage;
    objVC.strTitle = @"Interior Damage";
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)onClickRoof:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictRoof;
    objVC.strTitle = @"Roof";
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)onClickFrontElevation:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictFrontElevation;
    objVC.strTitle = @"Front Elevation";
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)onClickLeftElevation:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictLeftElevation;
    objVC.strTitle = @"Left Elevation";
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)onClickBackElevation:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictBackElevation;
    objVC.strTitle = @"Back Elevation";
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)onClickRightElevation:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictRightElevation;
    objVC.strTitle = @"Right Elevation";
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)onClickNotes:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictNotes;
    objVC.strTitle = @"Notes";
    [self.navigationController pushViewController:objVC animated:YES];
}

#pragma mark Misc
- (IBAction)onClickDropDown:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictDropDown;
    objVC.strTitle = @"Title";
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)onClickCheckOP:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    if (btnTemp.tag == 0) {
        btnTemp.tag = 5;
        isOP = true;
        [btnTemp setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }else {
        btnTemp.tag = 0;
        isOP = false;
        [btnTemp setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    
    [self setupScrollView];
}

- (IBAction)onClickCheckDepreciation:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    if (btnTemp.tag == 0) {
        btnTemp.tag = 5;
        isDepreciation = true;
        [btnTemp setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        viewMainDepreciation.hidden = false;
    }else {
        btnTemp.tag = 0;
        isDepreciation = false;
        [btnTemp setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        viewMainDepreciation.hidden = true;
    }
    
    [self setupScrollView];
}

- (IBAction)onClickCheckAPSDamage:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    if (btnTemp.tag == 0) {
        btnTemp.tag = 5;
        isAPSDamage = true;
        [btnTemp setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        viewMainAPSDamage.hidden = false;
    }else {
        btnTemp.tag = 0;
        isAPSDamage = false;
        [btnTemp setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        viewMainAPSDamage.hidden = true;
    }
    
    [self setupScrollView];
}

- (IBAction)onClickCheckContents:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    if (btnTemp.tag == 0) {
        btnTemp.tag = 5;
        isContents = true;
        [btnTemp setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }else {
        btnTemp.tag = 0;
        isContents = false;
        [btnTemp setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    
    [self setupScrollView];
}

- (IBAction)onClickCheckSalvage:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    if (btnTemp.tag == 0) {
        btnTemp.tag = 5;
        isSalvage = true;
        [btnTemp setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        viewMainSalvage.hidden = false;
    }else {
        btnTemp.tag = 0;
        isSalvage = false;
        [btnTemp setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        viewMainSalvage.hidden = true;
    }
    
    [self setupScrollView];
}

- (IBAction)onClickCheckLaborMin:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    if (btnTemp.tag == 0) {
        btnTemp.tag = 5;
        isLaborMin = true;
        [btnTemp setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        viewMainAdded.hidden = false;
        viewMainRemoved.hidden = false;
    }else {
        btnTemp.tag = 0;
        isLaborMin = false;
        [btnTemp setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        viewMainAdded.hidden = true;
        viewMainRemoved.hidden = true;
    }
    
    [self setupScrollView];
}

- (IBAction)onClickCheckDropDownMisc:(id)sender {
    if (txtTemp != nil) {
        [txtTemp resignFirstResponder];
        txtTemp = nil;
    }
    
    btnTemp = (UIButton *)sender;
    
    DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictDropDownMisc;
    objVC.strTitle = @"Company";
    [self.navigationController pushViewController:objVC animated:YES];
}

#pragma mark - Delegate Methods
#pragma mark UITextFiled
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    txtTemp = textField;
    
    if (txtTemp == txtMr) {
        [pickerMr selectRow:[arrMr indexOfObject:txtMr.text] inComponent:0 animated:FALSE];
    }
    
    if (txtTemp == txtPitch || txtTemp == txtLayers || txtTemp == txtAge || txtTemp == txtStory || txtTemp == txtDepreciation) {
        
        if (keyboard != nil) {
            keyboard = nil;
        }
        
        keyboard = [[MMNumberKeyboard alloc] initWithFrame:CGRectZero];
        keyboard.allowsDecimalPoint = NO;
        keyboard.delegate = self;
        keyboard.returnKeyTitle = @"return";
        keyboard.returnKeyButtonStyle = MMNumberKeyboardButtonStyleGray;
        txtTemp.inputView = keyboard;
    }
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

#pragma mark UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [arrMr count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [arrMr objectAtIndex:row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = nil;
    
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 44.0)];
        
        label = [[UILabel alloc] initWithFrame:view.frame];
        label.font = [UIFont systemFontOfSize:22.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.text = [arrMr objectAtIndex:row];
        [view addSubview:label];
    }
    
    if (label == nil) {
        label = view.subviews[0];
    }
    
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    txtMr.text = [arrMr objectAtIndex:row];
}

#pragma mark DropDownVC
- (void)didPressBack:(NSDictionary *)dictData {
    if (btnTemp == btnEdgeMetal) {
        dictEdgeMetal = dictData;
    }else if (btnTemp == btnType) {
        dictType = dictData;
    }else if (btnTemp == btnMainDweling1) {
        dictDweling1 = dictData;
    }else if (btnTemp == btnMainDweling2) {
        dictDweling2 = dictData;
    }else if (btnTemp == btnMainDweling3) {
        dictDweling3 = dictData;
    }else if (btnTemp == btnMainDweling4) {
        dictDweling4 = dictData;
    }else if (btnTemp == btnMainDweling5) {
        dictDweling5 = dictData;
    }else if (btnTemp == btnInteriorDamage) {
        dictInteriorDamage = dictData;
    }else if (btnTemp == btnRoof) {
        dictRoof = dictData;
    }else if (btnTemp == btnFrontElevation) {
        dictFrontElevation = dictData;
    }else if (btnTemp == btnLeftElevation) {
        dictLeftElevation = dictData;
    }else if (btnTemp == btnBackElevation) {
        dictBackElevation = dictData;
    }else if (btnTemp == btnRightElevation) {
        dictRightElevation = dictData;
    }else if (btnTemp == btnNotes) {
        dictNotes = dictData;
    }else if (btnTemp == btnDropDown) {
        dictDropDown = dictData;
    }else if (btnTemp == btnDropDownMisc) {
        dictDropDownMisc = dictData;
    }else {
        
    }
    
    if (dictData != nil) {
        [btnTemp setTitle:[dictData valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnTemp setTitle:@"" forState:UIControlStateNormal];
    }
}

@end
