//
//  AddValueVC.h
//

#import <UIKit/UIKit.h>
#import "ReportsVCCell.h"
#import "SubValueVC.h"

@interface AddValueVC : UIViewController <UITableViewDelegate, UITableViewDataSource, ReportsVCCellDelegate>
{
    NSArray *arrData;
    
    IBOutlet UITableView *tblView;
}

#pragma mark - UI Methods

#pragma mark - IBAction Methods
- (IBAction)onClickBack:(id)sender;

@end

