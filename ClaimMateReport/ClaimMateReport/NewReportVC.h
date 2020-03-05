//
//  NewReportVC.h
//  ClaimMateReport
//
//  Created by Mac Mini on 05/10/19.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomField.h"
#import "BorderedView.h"
#import "StepperView.h"
#import "SelectableView.h"
#import "MMNumberKeyboard.h"
#import "DropDownVC.h"
#import "ReportsVC.h"
#import "ViewCarGarage.h"
#import "DropDownView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewReportVC : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,DropDownVCDelegate,DropDowViewDelegate>
{
    UIToolbar *toolbar;
    MMNumberKeyboard *keyboard;
    NSArray *arrMr;
    BOOL isInsuredName, isInsuredPerson, isMortgagee, isNoMortgagee;
    UIPickerView *pickerMr;
    UIDatePicker *dateOfLoss, *dateOfInspected, *timeOfInspected;
    
    BOOL isRoof;
    NSDictionary *dictEdgeMetal, *dictType;
    NSMutableArray *arrEdgeMetal, *arrDwlResidential,*arrCompany, *arrRoofType, *arrDwlFirst, *arrDwlThird, *arrDwlFifth, *arrDmgInterior, *arrDmgRoof, *arrDmgElevation, *arrDmgNotes, *arrMiscTitle;
    
    // Dweling
    NSDictionary *dictDweling1, *dictDweling2, *dictDweling3, *dictDweling4, *dictDweling5;
    
    // Damage
    NSDictionary *dictInteriorDamage, *dictRoof, *dictFrontElevation, *dictLeftElevation, *dictBackElevation, *dictRightElevation, *dictNotes;
    
    // Misc
    BOOL isOP, isDepreciation, isAPSDamage, isContents, isSalvage, isLaborMin;
    NSDictionary *dictDropDown, *dictDropDownMisc;
    
    //None
    UITextField *activeField;
    int activeElevation;
}




@property (weak, nonatomic) IBOutlet UIStackView *stackEdgeMetal;
@property (weak, nonatomic) IBOutlet UIScrollView *scollView;
@property (weak, nonatomic) IBOutlet UIView *viewScrollContainer;
@property (weak, nonatomic) IBOutlet UITextField *txtfRoofType;
@property (readwrite) BOOL isEdit;
@property (strong, nonatomic) NSDictionary *dictPrev;

@property (weak, nonatomic) IBOutlet UITextField *txtfMr;
@property (weak, nonatomic) IBOutlet UITextField *txtfClimantName;

@property (weak, nonatomic) IBOutlet UIButton *btnNotPresent;
- (IBAction)onBtnNotPresent:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnContractor;

- (IBAction)btnContractorPressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIStackView *stackContractor;
@property (weak, nonatomic) IBOutlet UIStackView *stackDwellingContainer;
@property (weak, nonatomic) IBOutlet UITextField *txtfContractorName;
@property (weak, nonatomic) IBOutlet UITextField *txtfInsuredName;
@property (weak, nonatomic) IBOutlet UITextField *txtfCompanyName;
@property (weak, nonatomic) IBOutlet UIButton *btnMortgagee;
- (IBAction)onBtnMortgageePressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnDifferentClimant;
- (IBAction)btnDiffClimantPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *viewMortgagee;
@property (weak, nonatomic) IBOutlet UITextField *txtfMortgagee;
@property (weak, nonatomic) IBOutlet UIButton *btnNotMortgagee;
- (IBAction)btnNotMortgageePressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *viewDifferentClimant;
@property (weak, nonatomic) IBOutlet CustomField *txtfDateInspected;
@property (weak, nonatomic) IBOutlet CustomField *txtfTimeInspected;
@property (weak, nonatomic) IBOutlet UITextField *txtfCausesLoss;
@property (weak, nonatomic) IBOutlet CustomField *txtfDateLoss;
@property (weak, nonatomic) IBOutlet UIButton *btnRoof;
- (IBAction)btnRoofPressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet StepperView *stepperPitch;
@property (weak, nonatomic) IBOutlet StepperView *stepperLayers;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;

@property (weak, nonatomic) IBOutlet UISlider *sliderAge;
- (IBAction)onSliderChange:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet StepperView *stepperStory;
@property (weak, nonatomic) IBOutlet UIStackView *stackDwelling;
@property (weak, nonatomic) IBOutlet UITextField *txtfDwellingType;
@property (weak, nonatomic) IBOutlet UITextField *txtfSingleCombo;
@property (weak, nonatomic) IBOutlet StepperView *stepperCarGarrage;
@property (weak, nonatomic) IBOutlet UIButton *btnDwellingAttached;
-(IBAction)btnDwellingAttachedPressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnAddDwelling;
@property (weak, nonatomic) IBOutlet UITextField *txtfDwellBrickVeneer;
- (IBAction)btnAddDwellingPressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblInteriorDamage;
@property (weak, nonatomic) IBOutlet UILabel *lblRoof;
@property (weak, nonatomic) IBOutlet UILabel *lblFrontElevation;
@property (weak, nonatomic) IBOutlet UILabel *lblLeftElevation;
@property (weak, nonatomic) IBOutlet UILabel *lblBackElevation;
@property (weak, nonatomic) IBOutlet UILabel *lblRightElevation;
@property (weak, nonatomic) IBOutlet UILabel *lblNotes;

- (IBAction)lblInteriorDamagePressed:(UITapGestureRecognizer *)sender;
- (IBAction)lblRoofTapped:(UITapGestureRecognizer *)sender;

- (IBAction)lblFrontElevTapped:(UITapGestureRecognizer *)sender;
- (IBAction)lblLeftElevTapped:(UITapGestureRecognizer *)sender;
- (IBAction)lblBackElevTapped:(UITapGestureRecognizer *)sender;
- (IBAction)lblRightElevTapped:(UITapGestureRecognizer *)sender;
- (IBAction)lblNotesTapped:(UITapGestureRecognizer *)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnOP;
- (IBAction)btnOPPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDepriciation;
- (IBAction)btnDepreciationPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *viewDepreciation;
@property (weak, nonatomic) IBOutlet UITextField *txtfDepreciation;
@property (weak, nonatomic) IBOutlet UIButton *btnAPSDamage;
- (IBAction)btnAPSDamagePressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtfAPSDamage;
@property (weak, nonatomic) IBOutlet UIView *viewAPSDamage;
@property (weak, nonatomic) IBOutlet UIButton *btnContents;
- (IBAction)btnContentPressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSalvage;
- (IBAction)btnSalvagePressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *viewSalvage;
@property (weak, nonatomic) IBOutlet UITextField *txtfSalvage;
@property (weak, nonatomic) IBOutlet UIButton *btnSubrogation;
- (IBAction)btnSubrogationPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtfSubrogation;
@property (weak, nonatomic) IBOutlet UIView *viewSubrogation;
@property (weak, nonatomic) IBOutlet UIButton *btnLaborMin;
- (IBAction)btnLabroMinPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtfMiscType;
@property (weak, nonatomic) IBOutlet UIView *viewAdded;
@property (weak, nonatomic) IBOutlet UIView *viewRemoved;
@property (weak, nonatomic) IBOutlet UITextField *txtfAdded;

@property (weak, nonatomic) IBOutlet UITextField *txtfRemoved;
@property (weak, nonatomic) IBOutlet UITextField *txtfReportType;

- (IBAction)btnCompletePressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *viewCustomEdgeMetal;
@property (weak, nonatomic) IBOutlet UITextField *txtfCustomEdgeMetal;

@property (weak, nonatomic) IBOutlet UIView *viewCustomRoofType;
@property (weak, nonatomic) IBOutlet UITextField *txtfCustomRoofType;

@property (weak, nonatomic) IBOutlet UIView *viewCustomDwelling2;
@property (weak, nonatomic) IBOutlet UITextField *txtfCustomDwelling2;

@property (weak, nonatomic) IBOutlet UIView *viewCustomDwelling1;
@property (weak, nonatomic) IBOutlet UITextField *txtfCustomDwelling1;

@property (weak, nonatomic) IBOutlet UIView *viewCustomDwelling3;
@property (weak, nonatomic) IBOutlet UITextField *txtfCustomDwelling3;

@property (weak, nonatomic) IBOutlet UIView *viewCustomDwelling5;
@property (weak, nonatomic) IBOutlet UITextField *txtfCustomDwelling5;

@property (weak, nonatomic) IBOutlet UIView *viewCustomInteriorDamage;
@property (weak, nonatomic) IBOutlet UITextField *txtfCustomInteriorDamage;

@property (weak, nonatomic) IBOutlet UIView *viewCustomRoof;
@property (weak, nonatomic) IBOutlet UITextField *txtfCustomRoof;

@property (weak, nonatomic) IBOutlet UIView *viewCustomFrontElev;
@property (weak, nonatomic) IBOutlet UITextField *txtfCustomFrontElev;

@property (weak, nonatomic) IBOutlet UIView *viewCustomLeftElev;
@property (weak, nonatomic) IBOutlet UITextField *txtfCustomLeftElev;

@property (weak, nonatomic) IBOutlet UIView *viewCustomBackElev;
@property (weak, nonatomic) IBOutlet UITextField *txtfCustomBackElev;

@property (weak, nonatomic) IBOutlet UIView *viewCustomRightElev;
@property (weak, nonatomic) IBOutlet UITextField *txtfCustomRightElev;

@property (weak, nonatomic) IBOutlet UIView *viewCustomNotes;
@property (weak, nonatomic) IBOutlet UITextField *txtfCustomNotes;
@property (weak, nonatomic) IBOutlet UIView *viewCustomDropDown;
@property (weak, nonatomic) IBOutlet UITextField *txtfCustomDropDown;

@property (weak, nonatomic) IBOutlet UIStackView *stackRoofMain;
@property (weak, nonatomic) IBOutlet UIView *viewRoofType;

@property (weak, nonatomic) IBOutlet BorderedView *viewDwelling1;
@property (weak, nonatomic) IBOutlet BorderedView *viewDwelling3;
@property (weak, nonatomic) IBOutlet BorderedView *viewDwelling5;

@property (weak, nonatomic) IBOutlet UIStackView *stackDamage;
@property (weak, nonatomic) IBOutlet UIView *viewInteriorDamage;
@property (weak, nonatomic) IBOutlet UIView *viewRoofDamage;
@property (weak, nonatomic) IBOutlet UIView *viewFrontElev;
@property (weak, nonatomic) IBOutlet UIView *viewLeftElev;
@property (weak, nonatomic) IBOutlet UIView *viewBackElev;
@property (weak, nonatomic) IBOutlet UIView *viewRightElev;
@property (weak, nonatomic) IBOutlet UIView *viewNotes;
@property (weak, nonatomic) IBOutlet BorderedView *viewMiscType;
@property (weak, nonatomic) IBOutlet UIStackView *stackMisc;
@property (weak, nonatomic) IBOutlet UIView *viewReportType;



@end

NS_ASSUME_NONNULL_END
