//
//  ForgotPasswordVC.h
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordVC : UIViewController <UITextFieldDelegate>
{
    IBOutlet UIView *viewEmail;
    IBOutlet UITextField *txtEmail, *txtTemp;
    IBOutlet UIButton *btnSubmit;
}

#pragma mark - UI Methods

#pragma mark - IBAction Methods
- (IBAction)onClickSubmit:(id)sender;
- (IBAction)onClickBack:(id)sender;

@end

