//
//  DropDownVCCell.h
//

#import <UIKit/UIKit.h>

@protocol DropDownVCCellDelegate <NSObject>
- (void)didPressDetails:(NSInteger)index;
@end

@interface DropDownVCCell : UITableViewCell
{
    
}

#pragma mark - Properties
@property (nonatomic, retain) NSObject <DropDownVCCellDelegate> *delegate;
@property (assign, nonatomic) NSInteger idx;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

#pragma mark - UI Methods

#pragma mark - IBAction Methods
- (IBAction)onClickDetails:(UIButton *)sender;

@end
