//
//  ReportsVCCell.h
//

#import <UIKit/UIKit.h>

@protocol ReportsVCCellDelegate <NSObject>
- (void)didPressDetails:(NSInteger)index;
@end

@interface ReportsVCCell : UITableViewCell
{
    
}

#pragma mark - Properties
@property (nonatomic,retain) NSObject <ReportsVCCellDelegate> *delegate;
@property (assign, nonatomic) NSInteger idx;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

#pragma mark - UI Methods

#pragma mark - IBAction Methods
- (IBAction)onClickDetails:(UIButton *)sender;

@end
