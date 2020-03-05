//
//  SubValueVC.h
//

#import <UIKit/UIKit.h>
#import "SubValueVCCell.h"

@interface SubValueVC : UIViewController <UITableViewDelegate, UITableViewDataSource, SubValueVCCellDelegate>
{
    NSArray *arrData;
    
    IBOutlet UITableView *tblView;
    IBOutlet UIButton *btnEdit;
    IBOutlet UILabel *lblNoData, *lblTitle;
}

#pragma mark - UI Methods
@property (strong, nonatomic) NSString *strTitle;

#pragma mark - IBAction Methods
- (IBAction)onClickBack:(id)sender;
- (IBAction)onClickEdit:(UIButton *)sender;

@end

