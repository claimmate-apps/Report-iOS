//
//  SettingsVC.h
//

#import <UIKit/UIKit.h>
#import "AddValueVC.h"
#import "DropDownVC.h"

@interface SettingsVC : UIViewController <UITextFieldDelegate, DropDownVCDelegate>
{
    NSDictionary *dictCompany;
    
    IBOutlet UIButton *btnSave, *btnAddValue, *btnCompany;
    IBOutlet UIView *viewEmail, *viewAddValue, *viewDate, *viewCompany;
    IBOutlet UITextField *txtEmail, *txtDate, *txtTemp;
    
    UIDatePicker *datePicker;
    UIToolbar *toolbar;
}

#pragma mark - UI Methods

#pragma mark - IBAction Methods
- (IBAction)onClickBack:(id)sender;
- (IBAction)onClickSave:(id)sender;
- (IBAction)onClickAddValue:(id)sender;
- (IBAction)onClickCompany:(id)sender;

@end

