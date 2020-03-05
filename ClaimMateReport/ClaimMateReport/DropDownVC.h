//
//  DropDownVC.h
//

#import <UIKit/UIKit.h>
#import "DropDownVCCell.h"

@protocol DropDownVCDelegate <NSObject>
- (void)didPressBack:(NSDictionary *)dictData;
-(void)didPressBack:(NSDictionary *)dictData title:(NSString *)title;
@end

@interface DropDownVC : UIViewController <UITableViewDelegate, UITableViewDataSource, DropDownVCCellDelegate>
{
    NSArray *arrData;
    
    IBOutlet UITableView *tblView;
    IBOutlet UILabel *lblTitle;
    IBOutlet UIView *viewAdd;
}

#pragma mark - UI Methods
@property (nonatomic, retain) NSObject <DropDownVCDelegate> *delegate;
@property (strong, nonatomic) NSString *strTitle;
@property (strong, nonatomic) NSDictionary *diceSel;
@property (assign, nonatomic) BOOL isFromSettings;

#pragma mark - IBAction Methods
- (IBAction)onClickBack:(id)sender;
- (IBAction)onClickAdd:(id)sender;

@end

