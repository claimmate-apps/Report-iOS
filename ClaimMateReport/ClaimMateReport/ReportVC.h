//
//  ReportVC.h
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ReportsVC.h"

@interface ReportVC : UIViewController <UITextViewDelegate, MFMailComposeViewControllerDelegate>
{
    IBOutlet UIButton *btnSave, *btnSendEmail;
    IBOutlet UITextView *txtViewReport;
}

#pragma mark - UI Methods
@property (strong, nonatomic) NSDictionary *dictPrev1;
@property (strong, nonatomic) NSDictionary *dictPrev2;
@property (assign, nonatomic) BOOL isUpdate;
@property (strong, nonatomic) NSString *strPrev;
@property (strong, nonatomic) NSString *strEmailSubject;

#pragma mark - IBAction Methods
- (IBAction)onClickBack:(id)sender;
- (IBAction)onClickSave:(id)sender;
- (IBAction)onClickSendEmail:(id)sender;

@end

