//
//  NewReportVC.m
//  ClaimMateReport
//
//  Created by Mac Mini on 05/10/19.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "NewReportVC.h"


@interface NewReportVC ()<SelectableDelegates>

@end

@implementation NewReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupCustomeToolbar];
    arrMr = [[NSArray alloc] initWithObjects:@"Mr.", @"Ms.", @"Mr. & Ms.", @"None", nil];
    _txtfMr.text = arrMr.firstObject;
    
    pickerMr = [[UIPickerView alloc] init];
    pickerMr.delegate = self;
    pickerMr.dataSource = self;
    pickerMr.showsSelectionIndicator = YES;
    [pickerMr selectRow:[arrMr indexOfObject:_txtfMr.text] inComponent:0 animated:FALSE];
    _txtfMr.inputView = pickerMr;
    arrEdgeMetal = [self getData:@"roof_edge_metal"];
    arrDwlResidential = [self getData:@"dwl_second"];
    NSDictionary *customDict = @{
                                 @"name":@"Insert custom data",
                                 @"id":@"998"
                                 };
    NSDictionary *newOptionDict = @{
                                    @"name":@"Add New Option",
                                    @"id":@"999"
                                    };
    [arrEdgeMetal addObject:customDict];
    [arrEdgeMetal addObject:newOptionDict];
    
    [arrDwlResidential addObject:customDict];
    [arrDwlResidential addObject:newOptionDict];
    
    [self addEdgeMetal];
    NSLog(@"Dwl Residentials %@",arrDwlResidential);
    [self addDwellingType];
    
    
    if(!_isEdit)
    {
        [self setupNewData];
    }
    else{
        [self setupPreviousData];
    }
    
    
    arrCompany = [self getData:@"Company"];
    [arrCompany addObject:customDict];
    [arrCompany addObject:newOptionDict];
    
    arrRoofType = [self getData:@"roof_type"];
    [arrRoofType addObject:customDict];
    [arrRoofType addObject:newOptionDict];
    
    arrDwlFirst = [self getData:@"dwl_first"];
    [arrDwlFirst addObject:customDict];
    [arrDwlFirst addObject:newOptionDict];
    
    arrDwlThird = [self getData:@"dwl_third"];
    [arrDwlThird addObject:customDict];
    [arrDwlThird addObject:newOptionDict];
    
    arrDwlFifth = [self getData:@"dwl_fifth"];
    [arrDwlFifth addObject:customDict];
    [arrDwlFifth addObject:newOptionDict];
    
    arrDmgInterior = [self getData:@"dmg_interior_damage"];
    [arrDmgInterior addObject:customDict];
    [arrDmgInterior addObject:newOptionDict];
    
    arrDmgRoof = [self getData:@"dmg_roof"];
    [arrDmgRoof addObject:customDict];
    [arrDmgRoof addObject:newOptionDict];
    
    arrDmgElevation = [self getData:@"dmg_elevation"];
    [arrDmgElevation addObject:customDict];
    [arrDmgElevation addObject:newOptionDict];
    
    arrDmgNotes = [self getData:@"dmg_notes"];
    [arrDmgNotes addObject:customDict];
    [arrDmgNotes addObject:newOptionDict];
    
    arrMiscTitle = [self getData:@"misc_title"];
    [arrMiscTitle addObject:customDict];
    [arrMiscTitle addObject:newOptionDict];
    
    [_txtfDateInspected setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [_txtfTimeInspected setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [_txtfDateLoss setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

-(void)addEdgeMetal
{
    for (int i = 0; i < arrEdgeMetal.count; i++) {
        NSDictionary *dict = arrEdgeMetal[i];
        SelectableView *view = [[[NSBundle mainBundle] loadNibNamed:@"SelectableView" owner:self options:nil] objectAtIndex:0];
        view.delegate = self;
        view.isEdgeMetal = true;
        view.index = i;
        view.accessibilityValue = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
        [view.btnView setTitle:[NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]] forState:UIControlStateNormal];
        [self.stackEdgeMetal addArrangedSubview:view];
    }
}

-(void)addDwellingType
{
    for (int i = 0; i < arrDwlResidential.count; i++) {
        NSDictionary *dict = arrDwlResidential[i];
        SelectableView *view = [[[NSBundle mainBundle] loadNibNamed:@"SelectableView" owner:self options:nil] objectAtIndex:0];
        view.delegate = self;
        view.isEdgeMetal = false;
        view.index = i;
        view.accessibilityValue = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
        [view.btnView setTitle:[NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]] forState:UIControlStateNormal];
        [self.stackDwelling addArrangedSubview:view];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
}


#pragma mark : - SETUP DATA

-(void)setupNewData
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    dateOfLoss = [[UIDatePicker alloc] init];
    [dateOfLoss setDatePickerMode:UIDatePickerModeDate];
    [dateOfLoss setDate:[NSDate date]];
    [dateOfLoss addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    _txtfDateLoss.inputView = dateOfLoss;
    _txtfDateLoss.text = [dateFormat stringFromDate:dateOfLoss.date];
    
    dateOfInspected = [[UIDatePicker alloc] init];
    [dateOfInspected setDatePickerMode:UIDatePickerModeDate];
    [dateOfInspected setDate:[NSDate date]];
    [dateOfInspected addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    _txtfDateInspected.inputView = dateOfInspected;
    _txtfDateInspected.text = [dateFormat stringFromDate:dateOfInspected.date];
    
    [dateFormat setDateFormat:@"hh:mm a"];
    
    timeOfInspected = [[UIDatePicker alloc] init];
    [timeOfInspected setDatePickerMode:UIDatePickerModeTime];
    [timeOfInspected setDate:[NSDate date]];
    [timeOfInspected addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    _txtfTimeInspected.inputView = timeOfInspected;
    _txtfTimeInspected.text = [dateFormat stringFromDate:timeOfInspected.date];
    
    dictEdgeMetal = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"roof_edge_metal"]];
    NSLog(@"Dict Edge Metal : %@", dictEdgeMetal);
    
    
    dictType = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"roof_type"]];
    if (dictType != nil) {
        [_txtfRoofType setText:[dictType valueForKey:@"name"]];
    }else {
        [_txtfRoofType setText:@""];
    }
    
    // Dweling
    dictDweling1 = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dwl_first"]];
    if (dictDweling1 != nil) {
        [_txtfDwellingType setText:[dictDweling1 valueForKey:@"name"]];
    }else {
        [_txtfDwellingType setText:@""];
    }
    
    
    dictDweling3 = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dwl_third"]];
    if (dictDweling3 != nil) {
        [_txtfSingleCombo setText:[dictDweling3 valueForKey:@"name"]];
    }else {
        [_txtfSingleCombo setText:@""];
    }
    
    dictDweling4 = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dwl_fourth"]];
    if (dictDweling4 != nil) {
        //        [btnMainDweling4 setTitle:[dictDweling4 valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        //        [btnMainDweling4 setTitle:@"" forState:UIControlStateNormal];
    }
    
    dictDweling5 = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dwl_fifth"]];
    if (dictDweling5 != nil) {
        [_txtfDwellBrickVeneer setText:[dictDweling5 valueForKey:@"name"]];
    }else {
        [_txtfDwellBrickVeneer setText:@""];
    }
    
    // Damage
    dictInteriorDamage = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_interior_damage"]];
    if (dictInteriorDamage != nil) {
        _lblInteriorDamage.text = [dictInteriorDamage valueForKey:@"name"];
    }else {
        _lblInteriorDamage.text = @"";
    }
    
    dictRoof = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_roof"]];
    if (dictRoof != nil) {
        _lblRoof.text = [dictRoof valueForKey:@"name"];
    }else {
        _lblRoof.text = [dictRoof valueForKey:@"name"];
    }
    
    dictFrontElevation = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_elevation"]];
    if (dictFrontElevation != nil) {
        _lblFrontElevation.text = [dictFrontElevation valueForKey:@"name"];
    }else {
        _lblFrontElevation.text = @"";
    }
    
    dictLeftElevation = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_elevation"]];
    if (dictLeftElevation != nil) {
        _lblLeftElevation.text = [dictLeftElevation valueForKey:@"name"];
    }else {
        _lblLeftElevation.text = @"";
    }
    
    dictBackElevation = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_elevation"]];
    if (dictBackElevation != nil) {
        _lblBackElevation.text = [dictBackElevation valueForKey:@"name"];
    }else {
        _lblBackElevation.text = @"";
    }
    
    dictRightElevation = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_elevation"]];
    if (dictRightElevation != nil) {
        _lblRightElevation.text = [dictRightElevation valueForKey:@"name"];
    }else {
        _lblRightElevation.text = @"";
    }
    
    dictNotes = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_notes"]];
    if (dictNotes != nil) {
        _lblNotes.text = [dictNotes valueForKey:@"name"];
    }else {
        _lblNotes.text = @"";
    }
    
    dictDropDown = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"misc_title"]];
    if (dictDropDown != nil) {
        _txtfReportType.text = [dictDropDown valueForKey:@"names"];
    }else {
        _txtfReportType.text = @"";
    }
    
    dictDropDownMisc = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"Company"]];
    if (dictDropDownMisc != nil) {
        _txtfMiscType.text = [dictDropDown valueForKey:@"names"];
    }else {
        _txtfReportType.text = @"";
    }
    
    _txtfAdded.text = @"No";
    _txtfRemoved.text = @"No";
    
    _btnAddDwelling.layer.cornerRadius = _btnAddDwelling.frame.size.width/2;
    _btnAddDwelling.layer.masksToBounds = true;
    
}

-(void)setupPreviousData
{
    // Initial information
    if ([[_dictPrev valueForKey:@"insuredNameDiffernt"] isEqualToString:@"0"]) {
        _btnDifferentClimant.selected = false;
        self.viewDifferentClimant.hidden = true;
    }else {
        _btnDifferentClimant.selected  = true;
        _viewDifferentClimant.hidden = false;
    }
    
    _txtfInsuredName.text = [_dictPrev valueForKey:@"insuredName"];
    _txtfCausesLoss.text = [_dictPrev valueForKey:@"causesOfLoss"];
    
    /*if ([[_dictPrev valueForKey:@"insuredPersonPresent"] isEqualToString:@"0"]) {
        btnI.tag = 0;
        isInsuredPerson = false;
        [btnCheckInsuredPerson setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }else {
        btnCheckInsuredPerson.tag = 5;
        isInsuredPerson = true;
        [btnCheckInsuredPerson setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }*/
    
    if ([[_dictPrev valueForKey:@"isMortgagee"] isEqualToString:@"0"]) {
        _btnMortgagee.selected = false;
        isMortgagee = false;
        _viewMortgagee.hidden = true;
    }else {
        _btnMortgagee.selected = false;
        isMortgagee = true;
        _viewMortgagee.hidden = false;
    }
    
    _txtfMortgagee.text = [_dictPrev valueForKey:@"mortgagee"];
    
    if ([[_dictPrev valueForKey:@"isNoMortgagee"] isEqualToString:@"0"]) {
        _btnNotMortgagee.selected = false;
        isNoMortgagee = false;
    }else {
        _btnNotMortgagee.selected = true;
        isNoMortgagee = true;
    }
    
    arrMr = [[NSArray alloc] initWithObjects:@"Mr.", @"Ms.", @"Mr. & Ms.", @"None", nil];
    _txtfMr.text = [_dictPrev valueForKey:@"mr"];
    _txtfClimantName.text = [_dictPrev valueForKey:@"claimant_name"];
    
    pickerMr = [[UIPickerView alloc] init];
    pickerMr.delegate = self;
    pickerMr.dataSource = self;
    pickerMr.showsSelectionIndicator = YES;
    NSUInteger index = [arrMr indexOfObject:_txtfMr.text];
    if (index < arrMr.count) {
        [pickerMr selectRow:[arrMr indexOfObject:_txtfMr.text] inComponent:0 animated:FALSE];
    }
    
    _txtfMr.inputView = pickerMr;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    dateOfLoss = [[UIDatePicker alloc] init];
    [dateOfLoss setDatePickerMode:UIDatePickerModeDate];
    
    NSLog(@"claim_id => %@", [_dictPrev valueForKey:@"claim_id"]);
    
    [dateOfLoss setDate:[dateFormat dateFromString:[_dictPrev valueForKey:@"dateLoss"]]];
    [dateOfLoss addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    _txtfDateLoss.inputView = dateOfLoss;
    _txtfDateLoss.text = [dateFormat stringFromDate:dateOfLoss.date];
    
    dateOfInspected = [[UIDatePicker alloc] init];
    [dateOfInspected setDatePickerMode:UIDatePickerModeDate];
    [dateOfInspected setDate:[dateFormat dateFromString:[_dictPrev valueForKey:@"dateInspected"]]];
    [dateOfInspected addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    _txtfDateInspected.inputView = dateOfInspected;
    _txtfDateInspected.text = [dateFormat stringFromDate:dateOfInspected.date];
    
    [dateFormat setDateFormat:@"hh:mm a"];
    
    timeOfInspected = [[UIDatePicker alloc] init];
    [timeOfInspected setDatePickerMode:UIDatePickerModeTime];
    [timeOfInspected setDate:[dateFormat dateFromString:[_dictPrev valueForKey:@"timeInspected"]]];
    [timeOfInspected addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    _txtfTimeInspected.inputView = timeOfInspected;
    _txtfTimeInspected.text = [dateFormat stringFromDate:timeOfInspected.date];
    
    // Roof
    if ([[_dictPrev valueForKey:@"isRoof"] isEqualToString:@"0"]) {
        _btnRoof.selected = false;
        isRoof = false;
    }else {
        _btnRoof.selected = true;
        isRoof = true;
    }
    
    _stepperPitch.lblCounter.text = [_dictPrev valueForKey:@"pitch"];
    _stepperLayers.lblCounter.text = [_dictPrev valueForKey:@"layers"];
    _lblAge.text = [NSString stringWithFormat:@"Age : %@",[_dictPrev valueForKey:@"age"]];
    [_sliderAge setValue:[[_dictPrev valueForKey:@"age"] floatValue]];
    
    dictEdgeMetal = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"roof_edge_metal" WithName:[_dictPrev valueForKey:@"edgeMetal"]]];
    if (dictEdgeMetal != nil) {
        for (SelectableView *view in self.stackEdgeMetal.subviews) {
            if([view.accessibilityValue isEqualToString:[dictEdgeMetal valueForKey:@"name"]])
            {
                [view btnSelectPressed:view.btnView];
            }
        }
    }else {
        
    }
    
    dictType = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"roof_type" WithName:[_dictPrev valueForKey:@"type"]]];
    if (dictType != nil) {
        self.txtfRoofType.text = [dictType valueForKey:@"name"];
    }else {
        self.txtfRoofType.text = @"";
    }
    
    // Dweling
    _stepperStory.lblCounter.text = [_dictPrev valueForKey:@"story"];
    
    dictDweling1 = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dwl_first" WithName:[_dictPrev valueForKey:@"dwl_first"]]];
    if (dictDweling1 != nil) {
        _txtfDwellingType.text = [dictDweling1 valueForKey:@"name"];
    }else {
        _txtfDwellingType.text = @"";
    }
    
    dictDweling2 = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dwl_second" WithName:[_dictPrev valueForKey:@"dwl_second"]]];
    if (dictDweling2 != nil) {
        for (SelectableView *view in self.stackDwelling.subviews) {
            if([view.accessibilityValue isEqualToString:[dictDweling2 valueForKey:@"name"]])
            {
                [view btnSelectPressed:view.btnView];
            }
        }
    }else {
    }
    
    dictDweling3 = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dwl_third" WithName:[_dictPrev valueForKey:@"dwl_third"]]];
    if (dictDweling3 != nil) {
        _txtfSingleCombo.text = [dictDweling3 valueForKey:@"name"];
    }else {
        _txtfSingleCombo.text = @"";
    }
    
    dictDweling4 = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dwl_fourth" WithName:[_dictPrev valueForKey:@"dwl_fourth"]]];
    if (dictDweling4 != nil) {
//        _txtfDwellBrickVeneer.text = [dictDweling4 valueForKey:@"name"];
    }else {
//        _txtfDwellBrickVeneer.text = @"";
    }
    
    dictDweling5 = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dwl_fifth" WithName:[_dictPrev valueForKey:@"dwl_fifth"]]];
    if (dictDweling5 != nil) {
        _txtfDwellBrickVeneer.text = [dictDweling5 valueForKey:@"name"];
    }else {
        _txtfDwellBrickVeneer.text = @"";
    }
    
    // Damage
    dictInteriorDamage = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_interior_damage" WithName:[_dictPrev valueForKey:@"dmg_interior"]]];
    if (dictInteriorDamage != nil) {
        _lblInteriorDamage.text = [dictInteriorDamage valueForKey:@"name"];
    }else {
        _lblInteriorDamage.text = @"";
    }
    
    dictRoof = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_roof" WithName:[_dictPrev valueForKey:@"dmg_roof"]]];
    if (dictRoof != nil) {
        self.lblRoof.text = [dictRoof valueForKey:@"name"];
    }else {
        self.lblRoof.text = @"";
    }
    
    dictFrontElevation = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_elevation" WithName:[_dictPrev valueForKey:@"dmg_front_eleva"]]];
    if (dictFrontElevation != nil) {
        self.lblFrontElevation.text = [dictFrontElevation valueForKey:@"name"];
    }else {
        self.lblFrontElevation.text = @"";
    }
    
    dictLeftElevation = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_elevation" WithName:[_dictPrev valueForKey:@"dmg_left_eleva"]]];
    if (dictLeftElevation != nil) {
        self.lblLeftElevation.text = [dictLeftElevation valueForKey:@"name"];
    }else {
        self.lblLeftElevation.text = @"";
    }
    
    dictBackElevation = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_elevation" WithName:[_dictPrev valueForKey:@"dmg_back_eleva"]]];
    if (dictBackElevation != nil) {
        self.lblBackElevation.text = [dictBackElevation valueForKey:@"name"];
    }else {
        self.lblBackElevation.text = @"";
    }
    
    dictRightElevation = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_elevation" WithName:[_dictPrev valueForKey:@"dmg_right_eleva"]]];
    if (dictRightElevation != nil) {
        self.lblRightElevation.text = [dictRightElevation valueForKey:@"name"];
    }else {
        self.lblRightElevation.text = @"";
    }
    
    dictNotes = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"dmg_notes" WithName:[_dictPrev valueForKey:@"dmg_notes"]]];
    if (dictNotes != nil) {
        self.lblNotes.text = [dictNotes valueForKey:@"name"];
    }else {
        self.lblNotes.text = @"";
    }
    
    // Misc
    if ([[_dictPrev valueForKey:@"misc_op"] isEqualToString:@"0"]) {
        _btnOP.selected = false;
        isOP = false;
    }else {
        _btnOP.selected = true;
        isOP = true;
    }
    
    if ([[_dictPrev valueForKey:@"misc_depreciation"] isEqualToString:@"0"]) {
        _btnDepriciation.selected = false;
        isDepreciation = false;
        _viewDepreciation.hidden = true;
    }else {
        _btnDepriciation.selected = true;
        isDepreciation = true;
        _viewDepreciation.hidden = false;
    }
    
    _txtfDepreciation.text = [_dictPrev valueForKey:@"misc_depreciation_year"];
    
    if ([[_dictPrev valueForKey:@"misc_aps_damage"] isEqualToString:@"0"]) {
        _btnAPSDamage.selected = false;
        isAPSDamage = false;
        _viewAPSDamage.hidden = true;
    }else {
        _btnAPSDamage.selected = true;
        isAPSDamage = true;
        _viewAPSDamage.hidden = false;
    }
    
    _txtfAPSDamage.text = [_dictPrev valueForKey:@"misc_aps_damage_custome"];
    
    if ([[_dictPrev valueForKey:@"misc_contents"] isEqualToString:@"0"]) {
        _btnContents.selected = false;
        isContents = false;
    }else {
        _btnContents.selected = true;
        isContents = true;
    }
    
    if ([[_dictPrev valueForKey:@"misc_salvage"] isEqualToString:@"0"]) {
        _btnSalvage.selected = false;
        isSalvage = false;
        _viewSalvage.hidden = true;
    }else {
        _btnSalvage.selected = true;
        isSalvage = true;
        _viewSalvage.hidden = false;
    }
    
    _txtfSalvage.text = [_dictPrev valueForKey:@"misc_salvage_custom"];
    
    if ([[_dictPrev valueForKey:@"LaborMin"] isEqualToString:@"0"]) {
        _btnLaborMin.selected = false;
        isLaborMin = false;
        _viewAdded.hidden = true;
        _viewRemoved.hidden = true;
    }else {
        _btnLaborMin.selected = true;
        isLaborMin = true;
        _viewAdded.hidden = false;
        _viewRemoved.hidden = false;
    }
    
    dictDropDown = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"misc_title" WithName:[_dictPrev valueForKey:@"misc_title"]]];
    if (dictDropDown != nil) {
        _txtfMiscType.text = [dictDropDown valueForKey:@"name"];
    }else {
        _txtfMiscType.text = @"";
    }
    
    dictDropDownMisc = [[NSDictionary alloc] initWithDictionary:[self getDefault:@"Company" WithName:[_dictPrev valueForKey:@"all"]]];
    if (dictDropDownMisc != nil) {
        _txtfReportType.text =  [dictDropDownMisc valueForKey:@"name"];
    }else {
        _txtfReportType.text =  @"";
    }
    
    _txtfAdded.text = [_dictPrev valueForKey:@"LaborMinAdded"];
    _txtfRemoved.text = [_dictPrev valueForKey:@"LaborMinRemoved"];
    
    if(![[_dictPrev valueForKey:@"dmg_back_custom"] isEqualToString:@""])
    {
        [_viewCustomBackElev setHidden:NO];
        _txtfCustomBackElev.text = [_dictPrev valueForKey:@"dmg_back_custom"];
    }
    if(![[_dictPrev valueForKey:@"dmg_front_custom"] isEqualToString:@""])
    {
        [_viewCustomFrontElev setHidden:NO];
        _txtfCustomFrontElev.text = [_dictPrev valueForKey:@"dmg_front_custom"];
    }
    if(![[_dictPrev valueForKey:@"dmg_interior_custom"] isEqualToString:@""])
    {
        [_viewCustomInteriorDamage setHidden:NO];
        _txtfCustomInteriorDamage.text = [_dictPrev valueForKey:@"dmg_interior_custom"];
    }
    if(![[_dictPrev valueForKey:@"dmg_left_custom"] isEqualToString:@""])
    {
        [_viewCustomLeftElev setHidden:NO];
        _txtfCustomLeftElev.text = [_dictPrev valueForKey:@"dmg_left_custom"];
    }
    if(![[_dictPrev valueForKey:@"dmg_notes_custom"] isEqualToString:@""])
    {
        [_viewCustomNotes setHidden:NO];
        _txtfCustomNotes.text = [_dictPrev valueForKey:@"dmg_notes_custom"];
    }
    if(![[_dictPrev valueForKey:@"dmg_right_custom"] isEqualToString:@""])
    {
        [_viewCustomRightElev setHidden:NO];
        _txtfCustomRightElev.text = [_dictPrev valueForKey:@"dmg_right_custom"];
    }
    if(![[_dictPrev valueForKey:@"dmg_roof_custom"] isEqualToString:@""])
    {
        [_viewCustomRoof setHidden:NO];
        _txtfCustomRoof.text = [_dictPrev valueForKey:@"dmg_roof_custom"];
    }
    if(![[_dictPrev valueForKey:@"dwl_fifth_custom"] isEqualToString:@""])
    {
        [_viewCustomDwelling5 setHidden:NO];
        _txtfCustomDwelling5.text = [_dictPrev valueForKey:@"dwl_fifth_custom"];
    }
    if(![[_dictPrev valueForKey:@"dwl_first_custom"] isEqualToString:@""])
    {
        [_viewCustomDwelling1 setHidden:NO];
        _txtfCustomDwelling1.text = [_dictPrev valueForKey:@"dwl_first_custom"];
    }
    
    if(![[_dictPrev valueForKey:@"dwl_second_custom"] isEqualToString:@""])
    {
        [_viewCustomDwelling2 setHidden:NO];
        _txtfCustomDwelling2.text = [_dictPrev valueForKey:@"dwl_second_custom"];
    }
    if(![[_dictPrev valueForKey:@"dwl_third_custom"] isEqualToString:@""])
    {
        [_viewCustomDwelling3 setHidden:NO];
        _txtfCustomDwelling3.text = [_dictPrev valueForKey:@"dwl_third_custom"];
    }
    if(![[_dictPrev valueForKey:@"edgeMetalCustom"] isEqualToString:@""])
    {
        [_viewCustomEdgeMetal setHidden:NO];
        _txtfCustomEdgeMetal.text = [_dictPrev valueForKey:@"edgeMetalCustom"];
    }
    if(![[_dictPrev valueForKey:@"misc_title_custom"] isEqualToString:@""])
    {
        [_viewCustomDropDown setHidden:NO];
        _txtfCustomDropDown.text = [_dictPrev valueForKey:@"misc_title_custom"];
    }
}

- (void)didFinishWithSelectView:(BOOL)isMetal index:(int)index
{
    if (isMetal)
    {
        for (SelectableView *view in self.stackEdgeMetal.arrangedSubviews) {
            [view deselect];
        }
        dictEdgeMetal = arrEdgeMetal[index];
        if([[dictEdgeMetal valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomEdgeMetal setHidden:YES];
            [self addTextfieldWithName:@"roof_edge_metal" array:arrEdgeMetal];
        }
        else if([[dictEdgeMetal valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomEdgeMetal setHidden:NO];
        }
        else{
            [self.viewCustomEdgeMetal setHidden:YES];
        }
    }
    else
    {
        for (SelectableView *view in self.stackDwelling.arrangedSubviews) {
            [view deselect];
        }
        dictDweling2 = arrDwlResidential[index];
        if([[dictDweling2 valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomDwelling2 setHidden:YES];
            [self addTextfieldWithName:@"dwl_second" array:arrDwlResidential];
        }
        else if([[dictDweling2 valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomDwelling2 setHidden:NO];
        }
        else{
            [self.viewCustomDwelling2 setHidden:YES];
        }
    }
    
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

- (void)didFinishWithSelectView {
    
}

-(void)serviceCall
{
    [self.view endEditing:YES];
    
    if ([_txtfClimantName.text isEqualToString:@""] || [_txtfCausesLoss.text isEqualToString:@""]) {
        [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
        return;
    }
    
    if (_btnDifferentClimant.isSelected == true) {
        if ([_txtfInsuredName.text isEqualToString:@""]) {
            [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
            return;
        }
    }
    
    if (_btnMortgagee.isSelected == true) {
        if ([_txtfMortgagee.text isEqualToString:@""]) {
            [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
            return;
        }
    }
    
    
    if (_btnDepriciation.isSelected == true) {
        if ([_txtfDepreciation.text isEqualToString:@""]) {
            [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
            return;
        }
    }
    
    if (_btnAPSDamage.isSelected == true) {
        if ([_txtfAPSDamage.text isEqualToString:@""]) {
            [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
            return;
        }
    }
    
    if (_btnSalvage.isSelected == true) {
        if ([_txtfSalvage.text isEqualToString:@""]) {
            [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
            return;
        }
    }
    
    if (_btnLaborMin.isSelected == true) {
        if ([_txtfAdded.text isEqualToString:@""] || [_txtfRemoved.text isEqualToString:@""]) {
            [APPDELEGATE showMessageWithTitle:Error Message:@"Please fill the required field."];
            return;
        }
    }
    
    NSDictionary *dictUserData = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserData"];
    NSDictionary *parameters1 = @{
                                  @"user_id": [dictUserData valueForKey:@"id"],
                                  @"user_name": [dictUserData valueForKey:@"fullname"],
                                  @"report": @"",
                                  @"mr": [APPDELEGATE isEmpty:_txtfMr.text],
                                  @"claimant_name": [APPDELEGATE isEmpty:_txtfClimantName.text],
                                  @"insuredNameDiffernt": _btnDifferentClimant.isSelected ? @"1" : @"0",
                                  @"insuredName": _btnDifferentClimant.isSelected ? [APPDELEGATE isEmpty:_txtfInsuredName.text] : @"",
                                  @"causesOfLoss": [APPDELEGATE isEmpty:_txtfCausesLoss.text],
                                  @"dateLoss": [APPDELEGATE isEmpty:_txtfDateLoss.text],
                                  @"insuredPersonPresent": !_btnDifferentClimant.isSelected ? @"1" : @"0",
                                  @"isMortgagee": _btnMortgagee.isSelected ? @"1" : @"0",
                                  @"mortgagee": _btnMortgagee.isSelected ? [APPDELEGATE isEmpty:_txtfMortgagee.text] : @"",
                                  @"isNoMortgagee": _btnMortgagee.isSelected ? _btnNotMortgagee.isSelected ? @"1" : @"0" : @"0",
                                  @"dateInspected": [APPDELEGATE isEmpty:_txtfDateInspected.text],
                                  @"timeInspected": [APPDELEGATE isEmpty:_txtfTimeInspected.text],
                                  @"isRoof": _btnRoof.isSelected ? @"1" : @"0",
                                  @"pitch": [APPDELEGATE isEmpty:_stepperPitch.lblCounter.text],
                                  @"layers": [APPDELEGATE isEmpty:_stepperLayers.lblCounter.text],
                                  @"edgeMetal": [APPDELEGATE isEmpty:[dictEdgeMetal valueForKey:@"name"]],
                                  @"edgeMetalCustom": _viewCustomEdgeMetal.isHidden ? @"" : _txtfCustomEdgeMetal.text,
                                  @"type": [APPDELEGATE isEmpty:_txtfRoofType.text],
                                  @"typeCustom": _viewCustomRoofType.isHidden ? @"" : _txtfCustomRoofType.text,
                                  @"age": [APPDELEGATE isEmpty:[NSString stringWithFormat:@"%.0f",_sliderAge.value]],
                                  @"story": [APPDELEGATE isEmpty:_stepperStory.lblCounter.text],
                                  @"dwl_first": [APPDELEGATE isEmpty:[dictDweling1 valueForKey:@"name"]],
                                  @"dwl_first_custom": _viewCustomDwelling1.isHidden ? @"" : _txtfCustomDwelling1.text,
                                  @"dwl_second": [APPDELEGATE isEmpty:[dictDweling2 valueForKey:@"name"]],
                                  @"dwl_second_custom": _viewCustomDwelling2.isHidden ? @"" : _txtfCustomDwelling2.text,
                                  @"dwl_third": [APPDELEGATE isEmpty:[dictDweling3 valueForKey:@"name"]],
                                  @"dwl_third_custom": _viewCustomDwelling3.isHidden ? @"" : _txtfCustomDwelling3.text,
                                  @"dwl_fourth": [APPDELEGATE isEmpty:[dictDweling4 valueForKey:@"name"]],
                                  @"dwl_fourth_custom": @"",
                                  @"dwl_fifth": [APPDELEGATE isEmpty:[dictDweling5 valueForKey:@"name"]],
                                  @"dwl_fifth_custom": _viewCustomDwelling5.isHidden ? @"" : _txtfCustomDwelling5.text
                                  };
    
    
    NSDictionary *parameters2 = @{
                                  @"dmg_interior": [APPDELEGATE isEmpty:_lblInteriorDamage.text],
                                  @"dmg_interior_custom": _viewCustomInteriorDamage.isHidden ? @"" : _txtfCustomInteriorDamage.text,
                                  @"dmg_roof": [APPDELEGATE isEmpty:_lblRoof.text],
                                  @"dmg_roof_custom": _viewCustomRoof.isHidden ? @"" : _txtfCustomRoof.text,
                                  @"dmg_front_eleva": [APPDELEGATE isEmpty:_lblFrontElevation.text],
                                  @"dmg_front_custom": _viewCustomFrontElev.isHidden ? @"" : _txtfCustomFrontElev.text,
                                  @"dmg_left_eleva": [APPDELEGATE isEmpty:_lblLeftElevation.text],
                                  @"dmg_left_custom": _viewCustomLeftElev.isHidden ? @"" : _txtfCustomLeftElev.text,
                                  @"dmg_back_eleva": [APPDELEGATE isEmpty:_lblBackElevation.text],
                                  @"dmg_back_custom": _viewCustomBackElev.isHidden ? @"" : _txtfCustomBackElev.text,
                                  @"dmg_right_eleva": [APPDELEGATE isEmpty:_lblRightElevation.text],
                                  @"dmg_right_custom": _viewCustomRightElev.isHidden ? @"" : _txtfCustomRightElev.text,
                                  @"dmg_notes": [APPDELEGATE isEmpty:_lblNotes.text],
                                  @"dmg_notes_custom": _viewCustomNotes.isHidden ? @"" : _txtfCustomNotes.text,
                                  @"misc_title": [APPDELEGATE isEmpty:_txtfMiscType.text],
                                  @"misc_title_custom": _viewCustomDropDown.isHidden ? @"" : _txtfCustomDropDown.text,
                                  @"misc_op": _btnOP.isSelected ? @"1" : @"0",
                                  @"misc_depreciation": _btnDepriciation.isSelected ? @"1" : @"0",
                                  @"misc_depreciation_year": _btnDepriciation.isSelected ? [APPDELEGATE isEmpty:_txtfDepreciation.text] : @"",
                                  @"misc_aps_damage": _btnAPSDamage.isSelected ? @"1" : @"0",
                                  @"misc_aps_damage_custome": _btnAPSDamage.isSelected ? [APPDELEGATE isEmpty:_txtfAPSDamage.text] : @"",
                                  @"misc_contents": _btnContents.isSelected ? @"1" : @"0",
                                  @"misc_salvage": _btnSalvage.isSelected ? @"1" : @"0",
                                  @"misc_salvage_custom": _btnSalvage.isSelected ? [APPDELEGATE isEmpty:_txtfSalvage.text] : @"",
                                  @"LaborMin": _btnLaborMin.isSelected ? @"1" : @"0",
                                  @"LaborMinAdded": _btnLaborMin.isSelected ? [APPDELEGATE isEmpty:_txtfAdded.text] : @"",
                                  @"LaborMinRemoved": _btnLaborMin.isSelected ? [APPDELEGATE isEmpty:_txtfRemoved.text] : @"",
                                  @"all": [APPDELEGATE isEmpty:_txtfReportType.text],
                                  @"AllCustom": @"",
                                  };
    NSMutableDictionary *param1 = [NSMutableDictionary dictionaryWithDictionary:parameters1];
    NSMutableDictionary *param2 = [NSMutableDictionary dictionaryWithDictionary:parameters2];
    if(_isEdit)
    {
        [param1 setValue:[_dictPrev valueForKey:@"id"] forKey:@"report_id"];
        [param2 setValue:[_dictPrev valueForKey:@"id"] forKey:@"report_id"];
    }
    
    NSLog(@"Param 1 : %@",param1);
    NSLog(@"Param 2 : %@",param2);
    
    ReportVC *objVC = (ReportVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"ReportVC"];
    objVC.isUpdate = _isEdit;
    objVC.dictPrev1 = param1;
    objVC.dictPrev2 = param2;
    objVC.strPrev = [self getReport];
    objVC.strEmailSubject = [NSString stringWithFormat:@"%@ Inspection Report",[[APPDELEGATE isEmpty:_txtfMr.text] isEqualToString:@"None"] ? @"" : [NSString stringWithFormat:@"%@ %@",[APPDELEGATE isEmpty:_txtfMr.text], [APPDELEGATE isEmpty:_txtfClimantName.text]]];
    [self.navigationController pushViewController:objVC animated:YES];
    
}

- (NSString *)getReport {
    NSString *B6, *G6, *C7, *G7, *I7, *C8, *C9, *N6;
    B6 = @"Arrived for scheduled appointment at ";
    G6 = [APPDELEGATE isEmpty:_txtfTimeInspected.text];
    C7 = @"on";
    G7 = [APPDELEGATE isEmpty:_txtfDateInspected.text];
    I7 = [[APPDELEGATE isEmpty:_txtfMr.text] isEqualToString:@"None"] ? @"" : [NSString stringWithFormat:@"%@ %@",[APPDELEGATE isEmpty:_txtfMr.text], [APPDELEGATE isEmpty:_txtfClimantName.text]];
    C8 = _btnDifferentClimant.isSelected ? @" was not present during inspection and asked for me to inspect the loss alone." : @" was present during inspection.";
    C9 = @" An onsite inspection of the loss was performed and the following was found: ";
    N6 = [NSString stringWithFormat:@"%@%@ %@ %@. %@%@%@",B6, G6, C7, G7, I7, C8,C9];
    
    NSString *B11, *C12, *D12, *F12, *G12, *C13, *C14, *H15, *H16, *B46, *N11;
    B11 = @"DWELLING INSPECTION: ";
    C12 = [NSString stringWithFormat:@"%@ Story ",[APPDELEGATE isEmpty:_stepperStory.lblCounter.text]];
    D12 = [NSString stringWithFormat:@"%@ ",[APPDELEGATE isEmpty:[dictDweling1 valueForKey:@"name"]]];
    F12 = [NSString stringWithFormat:@"%@ ",[APPDELEGATE isEmpty:[dictDweling2 valueForKey:@"name"]]];
    G12 = [NSString stringWithFormat:@"%@",[APPDELEGATE isEmpty:[dictDweling3 valueForKey:@"name"]]];
    C13 = [NSString stringWithFormat:@"%@",[APPDELEGATE isEmpty:[dictDweling4 valueForKey:@"name"]]];
    C14 = @"- The dwelling appears to be owner occupied on a year round basis. ";
    H15 = @"- The exterior of the dwelling is ";
    H15 = [NSString stringWithFormat:@"%@%@ ",H15,[APPDELEGATE isEmpty:[dictDweling5 valueForKey:@"name"]]];
    H16 = @"- The dwelling roof is ";
    H16 = [NSString stringWithFormat:@"%@%@ ",H16,[APPDELEGATE isEmpty:_txtfRoofType.text]];
    H16 = [NSString stringWithFormat:@"%@%@",H16,[APPDELEGATE isEmpty:[dictEdgeMetal valueForKey:@"name"]]];
    B46 = _btnDepriciation.isSelected ? [NSString stringWithFormat:@"- Depreciation documentation: Based on the age and condition of the materials, depreciation was set at %@ years.",[APPDELEGATE isEmpty:_txtfDepreciation.text]] : @"- Depreciation was not covered at inspection because depreciation is not applied.";
    N11 = [NSString stringWithFormat:@"%@\n%@%@%@%@\n%@\n\n%@\n%@\n%@\n%@",B11, C12, D12, F12, G12, C13, C14, H15, H16, B46];
    
    NSString *B18, *C19, *C20, *D20, *E20, *F20, *I20, *C21, *H21, *I21, *C22, *N16;
    B18 = @"ROOFING:";
    C19 = [NSString stringWithFormat:@"%@ Roof with a %@/12  Roof Pitch",C12, [APPDELEGATE isEmpty:_stepperPitch.lblCounter.text]];
    C20 = @"There is ";
    D20 = [APPDELEGATE isEmpty:_stepperLayers.lblCounter.text];
    E20 = @" Layer ";
    F20 = [APPDELEGATE isEmpty:_txtfRoofType.text];
    I20 = @" on the roof of the dwelling. ";
    C21 = @"Approximate age of the roof in years:";
    H21 = [APPDELEGATE isEmpty:[NSString stringWithFormat:@"%.0f",_sliderAge.value]];
    I21 = @"yrs";
    C22 = @"ROOF: ";
    C22 = [NSString stringWithFormat:@"%@%@",C22,[[APPDELEGATE isEmpty:_lblRoof.text] isEqualToString:@""] ? @"No roof damage." : [APPDELEGATE isEmpty:_lblRoof.text]];
    N16 = [NSString stringWithFormat:@"\n%@\n%@ \n%@%@%@%@",B18, C19, C20, D20, E20, F20];
    N16 = [NSString stringWithFormat:@"%@%@",N16, [APPDELEGATE isEmpty:[dictEdgeMetal valueForKey:@"name"]]];
    N16 = [NSString stringWithFormat:@"%@%@\n%@%@%@\n%@\n",N16, I20, C21, H21, I21, C22];
    
    NSString *M16 = [APPDELEGATE isEmpty:_txtfAPSDamage.text];
    M16 = [NSString stringWithFormat:@"%@\n%@",M16, C22];
    
    NSString *E24, *B25, *E25, *B26, *E26, *B27, *E27, *B28, *E28, *B30, *E30, *F30, *G30, *B32, *C32, *B33, *C33, *B36, *C36, *B38, *C38, *G38, *B40, *G40, *I40, *B42, *D42, *B44, *N25;
    E24 = @"NO STORM RELATED DAMAGE FOUND TO THIS ELEVATION. NO REPAIRS RECOMMENDED.";
    B25 = @"Front elevation: ";
    E25 = [[APPDELEGATE isEmpty:_lblFrontElevation.text] isEqualToString:@""] ? E24 : [APPDELEGATE isEmpty:_lblFrontElevation.text];
    B26 = @"Left elevation: ";
    E26 = [[APPDELEGATE isEmpty:_lblLeftElevation.text] isEqualToString:@""] ? E24 : [APPDELEGATE isEmpty:_lblLeftElevation.text];
    B27 = @"Rear elevation: ";
    E27 = [[APPDELEGATE isEmpty:_lblBackElevation.text] isEqualToString:@""] ? E24 : [APPDELEGATE isEmpty:_lblBackElevation.text];
    B28 = @"Right elevation: ";
    E28 = [[APPDELEGATE isEmpty:_lblRightElevation.text] isEqualToString:@""] ? E24 : [APPDELEGATE isEmpty:_lblRightElevation.text];
    B30 = @"Interior of Dwelling: ";
    E30 = [[APPDELEGATE isEmpty:_lblInteriorDamage.text] isEqualToString:@""] ? @"No Interior damage reported - Inspection of interior declined. " : [APPDELEGATE isEmpty:_lblInteriorDamage.text];
    F30 = @"";
    G30 = @"";
    B32 = @"APS: ";
    C32 = _btnAPSDamage.isSelected ? [APPDELEGATE isEmpty:_txtfAPSDamage.text] : @"There was no visible damage to the APS Structures or any fencing";
    B33 = @"CONTENTS: ";
    C33 = _btnContents.isSelected ? @" Content damage being claimed on loss for Inside Rep to review- Overview photos of some contents included for Inside rep" : [NSString stringWithFormat:@" No content damage reported by %@",I7];
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
    N29 = _btnRoof.isSelected ? O29 : M29;
    
    NSString *M51, *M48, *B58, *C58, *B62, *B64, *B68, *D68, *B70, *D70, *M46, *N74;
    M51 = [NSString stringWithFormat:@"Discussed with %@ that I completed my inspection of damage to their property. I reviewed the scope of damages with them as noted in the above descriptions. I advised that I cannot comment on the payment of coverage but their Inside claim representative will do so upon receipt of my report. I let them know I would be submitting my report and that they should be hearing from their Inside Rep within 6 to 10 business days. ",I7];
    M51 = [NSString stringWithFormat:@"%@%@",M51,_btnMortgagee.isSelected ? _btnNotMortgagee.isSelected ? @"Confirmed No mortgage for this property." : [NSString stringWithFormat:@"Confirmed that %@ as the mortgage company.",[APPDELEGATE isEmpty:_txtfMortgagee.text]] : @""];
    M48 = _btnLaborMin.isSelected ? [NSString stringWithFormat:@"LABOR MINIMUMS: %@ Labor Minimums were removed and %@ labor minimums were added to this estimate.",[APPDELEGATE isEmpty:_txtfRemoved.text], [APPDELEGATE isEmpty:_txtfAdded.text]] : @"";
    B58 = @"CAUSE OF LOSS: ";
    C58 = [NSString stringWithFormat:@"%@ - %@",[APPDELEGATE isEmpty:_txtfCausesLoss.text],[APPDELEGATE isEmpty:_txtfDateLoss.text]];
    B62 = @"SALVAGE: ";
    B62 = [NSString stringWithFormat:@"%@%@",B62, _btnSalvage.isSelected ? [APPDELEGATE isEmpty:_txtfSalvage.text] : @"The discarded Materials have no value "];
    B64 = @"SUBROGATION: No subrogation available, this is a weather related claim. ";
    B68 = @"OVERHEAD & PROFIT: ";
    D68 = _btnOP.isSelected ? @"- Based on the complexity of work & number of trades Overhead & Profit are necessary & therefore included in this estimate." : @"- Based on the complexity of work & number of trades Overhead & Profit are not necessary & there for NOT included in this estimate.";
    B70 = @"CLAIM COMPLETION: ";
    D70 = [NSString stringWithFormat:@" All documents and estimates are being forwarded via electronic upload to %@",[APPDELEGATE isEmpty:_txtfMiscType.text]];
    M46 = [NSString stringWithFormat:@"%@\n\n%@\n%@%@\n%@\n%@\n%@%@\n\n%@%@",M51, M48, B58, C58, B62, B64, B68, D68, B70, D70];
    N74 = [NSString stringWithFormat:@"%@\n%@",N29, M46];
    
    return N74;
}


- (IBAction)onBtnNotPresent:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}
- (IBAction)btnContractorPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    [_stackContractor setHidden:!sender.isSelected];
}
- (IBAction)onBtnMortgageePressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    [_viewMortgagee setHidden:!sender.isSelected];
}
- (IBAction)btnDiffClimantPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    [_viewDifferentClimant setHidden:!sender.isSelected];
}

- (IBAction)btnNotMortgageePressed:(UIButton *)sender{
    sender.selected = !sender.isSelected;
}
- (IBAction)onSliderChange:(UISlider *)sender {
    int value = sender.value;
    self.lblAge.text = [NSString stringWithFormat:@"Age : %d",value];
}
- (IBAction)btnDwellingAttachedPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}
- (IBAction)lblInteriorDamagePressed:(UITapGestureRecognizer *)sender {
    [self openDropDownWithName:arrDmgInterior name:@"Interior Damage" stack:_stackDamage vinView:_viewInteriorDamage];
    /*DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictInteriorDamage;
    objVC.strTitle = @"Interior Damage";
    [self.navigationController pushViewController:objVC animated:YES];*/
}

- (IBAction)lblRoofTapped:(UITapGestureRecognizer *)sender {
    [self openDropDownWithName:arrDmgRoof name:@"Roof" stack:_stackDamage vinView:_viewRoofDamage];
    /*DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictRoof;
    objVC.strTitle = @"Roof";
    [self.navigationController pushViewController:objVC animated:YES];*/
}

- (IBAction)lblFrontElevTapped:(UITapGestureRecognizer *)sender {
    activeElevation = 1;
    [self openDropDownWithName:arrDmgElevation name:@"Front Elevation" stack:_stackDamage vinView:_viewFrontElev];
    /*DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictFrontElevation;
    objVC.strTitle = @"Front Elevation";
    [self.navigationController pushViewController:objVC animated:YES];*/
}

- (IBAction)lblLeftElevTapped:(UITapGestureRecognizer *)sender {
    activeElevation = 2;
    [self openDropDownWithName:arrDmgElevation name:@"Left Elevation" stack:_stackDamage vinView:_viewLeftElev];
    /*DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictLeftElevation;
    objVC.strTitle = @"Left Elevation";
    [self.navigationController pushViewController:objVC animated:YES];*/
}

- (IBAction)lblBackElevTapped:(UITapGestureRecognizer *)sender {
    activeElevation = 3;
    [self openDropDownWithName:arrDmgElevation name:@"Back Elevation" stack:_stackDamage vinView:_viewBackElev];
    /*DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictBackElevation;
    objVC.strTitle = @"Back Elevation";
    [self.navigationController pushViewController:objVC animated:YES];*/
}

- (IBAction)lblRightElevTapped:(UITapGestureRecognizer *)sender {
    activeElevation = 4;
    [self openDropDownWithName:arrDmgElevation name:@"Right Elevation" stack:_stackDamage vinView:_viewRightElev];
    /*DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictRightElevation;
    objVC.strTitle = @"Right Elevation";
    [self.navigationController pushViewController:objVC animated:YES];*/
}

- (IBAction)lblNotesTapped:(UITapGestureRecognizer *)sender {
    [self openDropDownWithName:arrDmgNotes name:@"Notes" stack:_stackDamage vinView:_viewCustomNotes];
    /*DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
    objVC.delegate = self;
    objVC.isFromSettings = false;
    objVC.diceSel = dictNotes;
    objVC.strTitle = @"Notes";
    [self.navigationController pushViewController:objVC animated:YES];*/
}
- (IBAction)btnOPPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}
- (IBAction)btnDepreciationPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    [_viewDepreciation setHidden:!sender.isSelected];
}

- (IBAction)btnAPSDamagePressed:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    [_viewAPSDamage setHidden:!sender.isSelected];
}

- (IBAction)btnContentPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}
- (IBAction)btnSalvagePressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    [_viewSalvage setHidden:!sender.isSelected];
}
- (IBAction)btnSubrogationPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    [_viewSubrogation setHidden:!sender.isSelected];
}

- (IBAction)btnLabroMinPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    [_viewAdded setHidden:!sender.isSelected];
    [_viewRemoved setHidden:!sender.isSelected];
}
- (IBAction)btnRoofPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}
- (IBAction)btnAddDwellingPressed:(UIButton *)sender {
    ViewCarGarage *view = [[[NSBundle mainBundle] loadNibNamed:@"ViewCarGarage" owner:self options:nil] objectAtIndex:0];
    [self.stackDwellingContainer insertArrangedSubview:view atIndex:4];
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
        
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] initWithDictionary:@{}];
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

#pragma mark :-  Custom Methods
- (void)setupCustomeToolbar {
    toolbar = [[UIToolbar alloc] init];
    [toolbar sizeToFit];
    
    UIBarButtonItem *btnExtraSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onClickDone)];
    
    [toolbar setItems:[[NSArray alloc] initWithObjects:btnExtraSpace,btnDone,nil]];
    
    _txtfMr.inputAccessoryView = toolbar;
    _txtfMr.delegate = self;
    _txtfDateLoss.inputAccessoryView = toolbar;
    _txtfDateLoss.delegate = self;
    _txtfDateInspected.inputAccessoryView = toolbar;
    _txtfDateInspected.delegate = self;
    _txtfTimeInspected.inputAccessoryView = toolbar;
    _txtfTimeInspected.delegate = self;
}

- (void)onClickDone {
    if (activeField == _txtfDateLoss || activeField == _txtfDateInspected || activeField == _txtfTimeInspected) {
        [self datePickerValueChanged:activeField];
    }
    [self.view endEditing:YES];
}

- (void)datePickerValueChanged:(UITextField *)txtTemp
{
    UIDatePicker *picker = (UIDatePicker *)txtTemp.inputView;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    
    if ([_txtfTimeInspected isFirstResponder]) {
        [dateFormat setDateFormat:@"hh:mm a"];
    }else {
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
    }
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    activeField.text = [NSString stringWithFormat:@"%@",dateString];
}


#pragma mark: - Textfield Delegates
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return true;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == _txtfRoofType)
    {
        [self openDropDownWithName:arrRoofType name:@"Type" stack:_stackRoofMain vinView:_viewRoofType];
        /*DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
        objVC.delegate = self;
        objVC.isFromSettings = false;
        objVC.diceSel = dictType;
        objVC.strTitle = @"Type";
        [self.navigationController pushViewController:objVC animated:YES];*/
        return false;
    }
    else if(textField == _txtfDwellingType)
    {
        [self openDropDownWithName:arrDwlFirst name:@"Dweling 1" stack:_stackDwellingContainer vinView:_viewDwelling1];
        /*DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
        objVC.delegate = self;
        objVC.isFromSettings = false;
        objVC.diceSel = dictDweling1;
        objVC.strTitle = @"Dweling 1";
        [self.navigationController pushViewController:objVC animated:YES];*/
        return false;
    }
    else if(textField == _txtfSingleCombo)
    {
        [self openDropDownWithName:arrDwlThird name:@"Dweling 3" stack:_stackDwellingContainer vinView:_viewDwelling3];
        /*DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
        objVC.delegate = self;
        objVC.isFromSettings = false;
        objVC.diceSel = dictDweling3;
        objVC.strTitle = @"Dweling 3";
        [self.navigationController pushViewController:objVC animated:YES];*/
        return false;
    }
    else if(textField == _txtfDwellBrickVeneer)
    {
        [self openDropDownWithName:arrDwlFifth name:@"Dweling 5" stack:_stackDwellingContainer vinView:_viewDwelling5];
        /*DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
        objVC.delegate = self;
        objVC.isFromSettings = false;
        objVC.diceSel = dictDweling5;
        objVC.strTitle = @"Dweling 5";
        [self.navigationController pushViewController:objVC animated:YES];*/
        return false;
    }
    /*else if(textField == _txtfDepreciation)
    {
        DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
        objVC.delegate = self;
        objVC.isFromSettings = false;
        objVC.diceSel = dictDweling5;
        objVC.strTitle = @"Dweling 5";
        [self.navigationController pushViewController:objVC animated:YES];
        return false;
    }
    else if(textField == _txtfAPSDamage)
    {
        DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
        objVC.delegate = self;
        objVC.isFromSettings = false;
        objVC.diceSel = dictDweling5;
        objVC.strTitle = @"Dweling 5";
        [self.navigationController pushViewController:objVC animated:YES];
        return false;
    }
    else if(textField == _txtfSalvage)
    {
        DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
        objVC.delegate = self;
        objVC.isFromSettings = false;
        objVC.diceSel = dictDweling5;
        objVC.strTitle = @"Dweling 5";
        [self.navigationController pushViewController:objVC animated:YES];
        return false;
    }
    else if(textField == _txtfSubrogation)
    {
        DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
        objVC.delegate = self;
        objVC.isFromSettings = false;
        objVC.diceSel = dictDweling5;
        objVC.strTitle = @"Dweling 5";
        [self.navigationController pushViewController:objVC animated:YES];
        return false;
    }*/
    else if(textField == _txtfMiscType)
    {
        [self openDropDownWithName:arrMiscTitle name:@"Title" stack:_stackMisc vinView:_viewMiscType];
        /*DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
        objVC.delegate = self;
        objVC.isFromSettings = false;
        objVC.diceSel = dictDropDown;
        objVC.strTitle = @"Title";
        [self.navigationController pushViewController:objVC animated:YES];*/
        return false;
    }
    else if(textField == _txtfReportType)
    {
        [self openDropDownWithName:arrCompany name:@"Company" stack:_stackMisc vinView:_viewReportType];
        /*DropDownVC *objVC = (DropDownVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"DropDownVC"];
        objVC.delegate = self;
        objVC.isFromSettings = false;
        objVC.diceSel = dictDropDownMisc;
        objVC.strTitle = @"Company";
        [self.navigationController pushViewController:objVC animated:YES];*/
        return false;
    }
    return true;
}

-(void)openDropDownWithName:(NSArray *)array name:(NSString *)str stack:(UIStackView *)stack vinView:(UIView *)mainView
{
    [stack layoutIfNeeded];
    CGFloat yOffset = self.scollView.contentOffset.y;
    CGFloat pos = stack.frame.origin.y + mainView.frame.origin.y;
    
    
    DropDownView *view = [[[NSBundle mainBundle] loadNibNamed:@"DropDownView" owner:self options:nil] objectAtIndex:0];
    view.arrOptions = array;
    view.name = str;
    view.delegate = self;
    
    [self.view addSubview:view];
    
    view.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
                                              [view.leadingAnchor constraintEqualToAnchor:self.scollView.leadingAnchor],
                                              [view.trailingAnchor constraintEqualToAnchor:self.scollView.trailingAnchor],
                                              [view.topAnchor constraintEqualToAnchor:self.scollView.topAnchor],
                                              [view.bottomAnchor constraintEqualToAnchor:self.scollView.bottomAnchor]
                                              ]];
    
    view.yPosition = pos - yOffset;
}

-(NSString *)convertNames:(NSString *)str
{
    NSString *_strTitle = str;
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
    }
    return _strTitle;
}

-(void)didPressBack:(NSDictionary *)dictData name:(NSString *)name
{
    NSLog(@"Dict : %@,\n Name : %@",dictData,name);
    NSString *title = [self convertNames:name];
    if ([title isEqualToString:@"roof_type"]) {
        dictType = dictData;
        if([[dictType valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomRoofType setHidden:YES];
            [self addTextfieldWithName:@"roof_type" array:arrRoofType];
        }
        else if([[dictType valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomRoofType setHidden:NO];
        }
        else{
            [self.viewCustomRoofType setHidden:YES];
            self.txtfRoofType.text = [dictType valueForKey:@"name"];
        }
    }else if ([title isEqualToString:@"dwl_first"]) {
        dictDweling1 = dictData;
        if([[dictDweling1 valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomDwelling1 setHidden:YES];
            [self addTextfieldWithName:@"dwl_first" array:arrDwlFirst];
        }
        else if([[dictDweling1 valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomDwelling1 setHidden:NO];
        }
        else{
            [self.viewCustomDwelling1 setHidden:YES];
            self.txtfDwellingType.text = [dictDweling1 valueForKey:@"name"];
        }
    }else if ([title isEqualToString:@"dwl_second"]) {
        dictDweling2 = dictData;
        if([[dictDweling2 valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomDwelling2 setHidden:YES];
            [self addTextfieldWithName:@"dwl_second" array:arrDwlResidential];
        }
        else if([[dictDweling2 valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomDwelling2 setHidden:NO];
        }
        else{
            [self.viewCustomDwelling2 setHidden:YES];
        }
    }else if ([title isEqualToString:@"dwl_third"]) {
        dictDweling3 = dictData;
        if([[dictDweling3 valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomDwelling3 setHidden:YES];
            [self addTextfieldWithName:@"dwl_third" array:arrDwlThird];
        }
        else if([[dictDweling3 valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomDwelling3 setHidden:NO];
        }
        else{
            [self.viewCustomDwelling3 setHidden:YES];
            self.txtfSingleCombo.text = [dictDweling3 valueForKey:@"name"];
        }
    }else if ([title isEqualToString:@"dwl_fourth"]) {
        dictDweling4 = dictData;
    }else if ([title isEqualToString:@"dwl_fifth"]) {
        dictDweling5 = dictData;
        if([[dictDweling5 valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomDwelling5 setHidden:YES];
            [self addTextfieldWithName:@"dwl_fifth" array:arrDwlFifth];
        }
        else if([[dictDweling5 valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomDwelling5 setHidden:NO];
        }
        else{
            [self.viewCustomDwelling5 setHidden:YES];
            self.txtfDwellBrickVeneer.text = [dictDweling5 valueForKey:@"name"];
        }
        
    }else if ([title isEqualToString:@"dmg_interior_damage"]) {
        dictInteriorDamage = dictData;
        if([[dictInteriorDamage valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomInteriorDamage setHidden:YES];
            [self addTextfieldWithName:@"dmg_interior_damage" array:arrDmgInterior];
        }
        else if([[dictInteriorDamage valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomInteriorDamage setHidden:NO];
        }
        else{
            [self.viewCustomInteriorDamage setHidden:YES];
            self.lblInteriorDamage.text = [dictInteriorDamage valueForKey:@"name"];
        }
    }else if ([title isEqualToString:@"dmg_roof"]) {
        dictRoof = dictData;
        if([[dictRoof valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomRoof setHidden:YES];
            [self addTextfieldWithName:@"dmg_roof" array:arrDmgRoof];
        }
        else if([[dictRoof valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomRoof setHidden:NO];
        }
        else{
            [self.viewCustomRoof setHidden:YES];
            self.lblRoof.text = [dictRoof valueForKey:@"name"];
        }
    }else if ([title isEqualToString:@"dmg_elevation"] && activeElevation == 1) {
        dictFrontElevation = dictData;
        if([[dictFrontElevation valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomFrontElev setHidden:YES];
            [self addTextfieldWithName:@"dmg_elevation" array:arrDmgElevation];
        }
        else if([[dictFrontElevation valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomFrontElev setHidden:NO];
        }
        else{
            [self.viewCustomFrontElev setHidden:YES];
            self.lblFrontElevation.text = [dictFrontElevation valueForKey:@"name"];
        }
    }else if ([title isEqualToString:@"dmg_elevation"] && activeElevation == 2) {
        dictLeftElevation = dictData;
        if([[dictLeftElevation valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomLeftElev setHidden:YES];
            [self addTextfieldWithName:@"dmg_elevation" array:arrDmgElevation];
        }
        else if([[dictLeftElevation valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomLeftElev setHidden:NO];
        }
        else{
            [self.viewCustomLeftElev setHidden:YES];
            self.lblLeftElevation.text = [dictLeftElevation valueForKey:@"name"];
        }
    }else if ([title isEqualToString:@"dmg_elevation"] && activeElevation == 3) {
        dictBackElevation = dictData;
        if([[dictBackElevation valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomBackElev setHidden:YES];
            [self addTextfieldWithName:@"dmg_elevation" array:arrDmgElevation];
        }
        else if([[dictBackElevation valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomBackElev setHidden:NO];
        }
        else{
            [self.viewCustomBackElev setHidden:YES];
            self.lblBackElevation.text = [dictBackElevation valueForKey:@"name"];
        }
    }else if ([title isEqualToString:@"dmg_elevation"] && activeElevation == 4) {
        dictRightElevation = dictData;
        if([[dictRightElevation valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomRightElev setHidden:YES];
            [self addTextfieldWithName:@"dmg_elevation" array:arrDmgElevation];
        }
        else if([[dictRightElevation valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomRightElev setHidden:NO];
        }
        else{
            [self.viewCustomRightElev setHidden:YES];
            self.lblRightElevation.text = [dictRightElevation valueForKey:@"name"];
        }
    }else if ([title isEqualToString:@"dmg_notes"]) {
        dictNotes = dictData;
        if([[dictNotes valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomNotes setHidden:YES];
            [self addTextfieldWithName:@"dmg_notes" array:arrDmgNotes];
        }
        else if([[dictNotes valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomNotes setHidden:NO];
        }
        else{
            [self.viewCustomNotes setHidden:YES];
            self.lblNotes.text = [dictNotes valueForKey:@"name"];
        }
    }else if ([title isEqualToString:@"misc_title"]) {
        dictDropDown = dictData;
        if([[dictDropDown valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self.viewCustomDropDown setHidden:YES];
            [self addTextfieldWithName:@"misc_title" array:arrMiscTitle];
        }
        else if([[dictDropDown valueForKey:@"id"] isEqualToString:@"998"])
        {
            [self.viewCustomDropDown setHidden:NO];
        }
        else{
            [self.viewCustomDropDown setHidden:YES];
            self.txtfMiscType.text = [dictDropDown valueForKey:@"name"];
        }
    }else if ([title isEqualToString:@"Company"]) {
        dictDropDownMisc = dictData;
        if([[dictDropDownMisc valueForKey:@"id"] isEqualToString:@"999"])
        {
            [self addTextfieldWithName:@"Company" array:arrCompany];
        }
        else{
            self.txtfReportType.text = [dictDropDownMisc valueForKey:@"name"];
        }
    }else {
        
    }
}

-(void)addTextfieldWithName:(NSString *)name array:(NSMutableArray *)arr
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Alert"
                                                                              message: @"Enter Name"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"name";
        textField.textColor = [UIColor blackColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        NSLog(@"%@",namefield.text);
        NSUInteger count = arr.count;
        NSDictionary *dict = @{@"name":namefield.text,@"id":@"0"};
        [arr insertObject:dict atIndex:count-2];
        if([name isEqualToString:@"roof_edge_metal"])
        {
            for (SelectableView *view in [self.stackEdgeMetal arrangedSubviews]) {
                [view removeFromSuperview];
            }
            [self addEdgeMetal];
        }
        else if([name isEqualToString:@"dwl_second"])
        {
            for (SelectableView *view in [self.stackDwelling arrangedSubviews]) {
                [view removeFromSuperview];
            }
            [self addDwellingType];
        }
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];

}


#pragma mark : - Dropdown Delegates
- (void)didPressBack:(NSDictionary *)dictData title:(NSString *)title {
    
    
    /*if (dictData != nil) {
        [btnTemp setTitle:[dictData valueForKey:@"name"] forState:UIControlStateNormal];
    }else {
        [btnTemp setTitle:@"" forState:UIControlStateNormal];
    }*/
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
    _txtfMr.text = [arrMr objectAtIndex:row];
}

- (NSMutableDictionary *)getDefault:(NSString *)strTable {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    sqlite3 *database;
    sqlite3_stmt *statement;
    
    const char *dbpath = [APPDELEGATE.strDatabasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM \"%@\" WHERE selectname = '1'", strTable];
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

#pragma mark - UI Methods
- (NSMutableArray *)getData:(NSString *)strTitle {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    sqlite3 *database;
    sqlite3_stmt *statement;
    
    const char *dbpath = [APPDELEGATE.strDatabasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM \"%@\"", strTitle];
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

- (IBAction)btnCompletePressed:(UIButton *)sender {
    [self serviceCall];
}

- (IBAction)btnBackPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
