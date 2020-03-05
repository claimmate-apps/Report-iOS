//
//  SignUpVC.h
//

#import <UIKit/UIKit.h>
#import "MMNumberKeyboard.h"
#import "ReportsVC.h"

@interface SignUpVC : UIViewController <UITextFieldDelegate, MMNumberKeyboardDelegate>
{
    IBOutlet UIView *viewName, *viewMobile, *viewEmail, *viewPassword, *viewConfirmPassword;
    IBOutlet UITextField *txtName, *txtMobile, *txtEmail, *txtPassword, *txtConfirmPassword, *txtTemp;
    IBOutlet UIButton *btnSignUp;
}

#pragma mark - UI Methods

#pragma mark - IBAction Methods
- (IBAction)onClickSignIn:(id)sender;
- (IBAction)onClickSignUp:(id)sender;

@end

