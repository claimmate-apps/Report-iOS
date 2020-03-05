//
//  ReportsVC.h
//

#import <UIKit/UIKit.h>
#import "ReportsVCCell.h"
#import "CreateReportVC.h"
#import "SettingsVC.h"
#import "EditReportVC.h"

@interface ReportsVC : UIViewController <UITableViewDelegate, UITableViewDataSource, ReportsVCCellDelegate>
{
    NSArray *arrReport;
    
    IBOutlet UIView *viewAdd;
    IBOutlet UITableView *tblReport;
    IBOutlet UIButton *btnEdit;
    IBOutlet UILabel *lblNoData;
}

#pragma mark - UI Methods

#pragma mark - IBAction Methods
- (IBAction)onClickAdd:(id)sender;
- (IBAction)onClickMore:(id)sender;
- (IBAction)onClickEdit:(UIButton *)sender;

@end

