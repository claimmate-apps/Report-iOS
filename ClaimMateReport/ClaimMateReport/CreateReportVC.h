//
//  CreateReportVC.h
//

#import <UIKit/UIKit.h>
#import "MMNumberKeyboard.h"
#import "DropDownVC.h"
#import "ReportVC.h"

@interface CreateReportVC : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MMNumberKeyboardDelegate, DropDownVCDelegate>
{
    IBOutlet UITableView *tblView;
    IBOutlet UIView *viewScroll;
    IBOutlet UIButton *btnInside, *btnTemp;
    
    UITextField *txtTemp;
    UIToolbar *toolbar;
    MMNumberKeyboard *keyboard;
    
    // Initial information
    NSArray *arrMr;
    BOOL isInsuredName, isInsuredPerson, isMortgagee, isNoMortgagee;
    UIPickerView *pickerMr;
    UIDatePicker *dateOfLoss, *dateOfInspected, *timeOfInspected;
    
    IBOutlet UIView *viewInitialInformation, *viewMr, *viewClaimantName;
    IBOutlet UITextField *txtMr, *txtClaimantName;
    IBOutlet UILabel *lblCheckInsuredPerson, *lblCheckMortgagee;
    IBOutlet UIButton *btnCheckInsuredName, *btnCheckInsuredPerson, *btnCheckMortgagee, *btnCheckNoMortgagee;
    IBOutlet UIView *viewMainInsuredName, *viewMainCausesOfLoss, *viewMainDateOfLoss, *viewMainMortgagee, *viewMainDateOfInspected, *viewMainTimeOfInspected;
    IBOutlet UIView *viewInsuredName, *viewCausesOfLoss, *viewDateOfLoss, *viewMortgagee, *viewDateOfInspected, *viewTimeOfInspected;
    IBOutlet UITextField *txtInsuredName, *txtCausesOfLoss, *txtDateOfLoss, *txtMortgagee, *txtDateOfInspected, *txtTimeOfInspected;
    
    // Roof
    BOOL isRoof;
    NSDictionary *dictEdgeMetal, *dictType;
    
    IBOutlet UIView *viewROOF, *viewPitch, *viewLayers, *viewEdgeMetal, *viewType, *viewAge;
    IBOutlet UIView *viewMainPitch, *viewMainLayers, *viewMainEdgeMetal, *viewMainType, *viewMainAge;
    IBOutlet UITextField *txtPitch, *txtLayers, *txtAge;
    IBOutlet UIButton *btnCheckRoof, *btnEdgeMetal, *btnType;
    IBOutlet UILabel *lblCheckRoof;
    
    // Dweling
    NSDictionary *dictDweling1, *dictDweling2, *dictDweling3, *dictDweling4, *dictDweling5;
    
    IBOutlet UIView *viewDweling, *viewStory, *viewDweling1, *viewDweling2, *viewDweling3, *viewDweling4, *viewDweling5;
    IBOutlet UIView *viewMainStory, *viewMainDweling1, *viewMainDweling2, *viewMainDweling3, *viewMainDweling4, *viewMainDweling5;
    IBOutlet UITextField *txtStory;
    IBOutlet UIButton *btnMainDweling1, *btnMainDweling2, *btnMainDweling3, *btnMainDweling4, *btnMainDweling5;
    
    // Damage
    NSDictionary *dictInteriorDamage, *dictRoof, *dictFrontElevation, *dictLeftElevation, *dictBackElevation, *dictRightElevation, *dictNotes;
    
    IBOutlet UIView *viewDamage, *viewInteriorDamage, *viewRoof, *viewFrontElevation, *viewLeftElevation, *viewBackElevation, *viewRightElevation, *viewNotes;
    IBOutlet UIView *viewMainInteriorDamage, *viewMainRoof, *viewMainFrontElevation, *viewMainLeftElevation, *viewMainBackElevation, *viewMainRightElevation, *viewMainNotes;
    IBOutlet UIButton *btnInteriorDamage, *btnRoof, *btnFrontElevation, *btnLeftElevation, *btnBackElevation, *btnRightElevation, *btnNotes;
    
    // Misc
    BOOL isOP, isDepreciation, isAPSDamage, isContents, isSalvage, isLaborMin;
    NSDictionary *dictDropDown, *dictDropDownMisc;
    
    IBOutlet UIView *viewMisc, *viewDropDown, *viewDepreciation, *viewAPSDamage, *viewSalvage, *viewAdded, *viewRemoved, *viewDropDownMisc;
    IBOutlet UIView *viewMainDropDown, *viewMainDepreciation, *viewMainAPSDamage, *viewMainSalvage, *viewMainAdded, *viewMainRemoved, *viewMainDropDownMisc;
    IBOutlet UITextField *txtDepreciation, *txtAPSDamage, *txtSalvage, *txtAdded, *txtRemoved;
    IBOutlet UIButton *btnDropDown, *btnCheckOP, *btnCheckDepreciation, *btnCheckAPSDamage, *btnCheckContents, *btnCheckSalvage, *btnLaborMin, *btnDropDownMisc;
    IBOutlet UILabel *lblCheckOP, *lblCheckDepreciation, *lblCheckAPSDamage, *lblCheckContents, *lblCheckSalvage, *lblLaborMin;
}

#pragma mark - UI Methods

#pragma mark - IBAction Methods
- (IBAction)onClickBack:(id)sender;
- (IBAction)onClickInside:(id)sender;

// Initial information
- (IBAction)onClickCheckInsuredName:(id)sender;
- (IBAction)onClickCheckInsuredPerson:(id)sender;
- (IBAction)onClickCheckMortgagee:(id)sender;
- (IBAction)onClickCheckNoMortgagee:(id)sender;

// Roof
- (IBAction)onClickCheckRoof:(id)sender;
- (IBAction)onClickEdgeMetal:(id)sender;
- (IBAction)onClickType:(id)sender;

// Dweling
- (IBAction)onClickDweling1:(id)sender;
- (IBAction)onClickDweling2:(id)sender;
- (IBAction)onClickDweling3:(id)sender;
- (IBAction)onClickDweling4:(id)sender;
- (IBAction)onClickDweling5:(id)sender;

// Damage
- (IBAction)onClickInteriorDamage:(id)sender;
- (IBAction)onClickRoof:(id)sender;
- (IBAction)onClickFrontElevation:(id)sender;
- (IBAction)onClickLeftElevation:(id)sender;
- (IBAction)onClickBackElevation:(id)sender;
- (IBAction)onClickRightElevation:(id)sender;
- (IBAction)onClickNotes:(id)sender;

// Misc
- (IBAction)onClickDropDown:(id)sender;
- (IBAction)onClickCheckOP:(id)sender;
- (IBAction)onClickCheckDepreciation:(id)sender;
- (IBAction)onClickCheckAPSDamage:(id)sender;
- (IBAction)onClickCheckContents:(id)sender;
- (IBAction)onClickCheckSalvage:(id)sender;
- (IBAction)onClickCheckLaborMin:(id)sender;
- (IBAction)onClickCheckDropDownMisc:(id)sender;

@end

