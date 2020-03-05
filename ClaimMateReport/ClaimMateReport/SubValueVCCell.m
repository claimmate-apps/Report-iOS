//
//  SubValueVCCell.h
//

#import "SubValueVCCell.h"

@implementation SubValueVCCell

#pragma mark - Synthesize
@synthesize delegate = _delegate;
@synthesize lblTitle = _lblTitle;

#pragma mark - Init Method
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - UI Methods

#pragma mark - IBAction Methods
- (IBAction)onClickDetails:(UIButton *)sender {
    [_delegate didPressDetails:_idx];
}

@end
