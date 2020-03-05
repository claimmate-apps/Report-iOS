//
//  LoginVC.h
//

#import <UIKit/UIKit.h>
#import "SignUpVC.h"
#import "ReportsVC.h"
#import "ForgotPasswordVC.h"

@interface LoginVC : UIViewController <UITextFieldDelegate>
{
    IBOutlet UIView *viewEmail, *viewPassword;
    IBOutlet UITextField *txtEmail, *txtPassword, *txtTemp;
    IBOutlet UIButton *btnSignIn;
}

#pragma mark - UI Methods

#pragma mark - IBAction Methods
- (IBAction)onClickSignIn:(id)sender;
- (IBAction)onClickRegister:(id)sender;
- (IBAction)onClickForgotPassword:(id)sender;

@end

