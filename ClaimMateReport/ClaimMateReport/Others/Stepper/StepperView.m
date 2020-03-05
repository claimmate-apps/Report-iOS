//
//  StepperView.m
//  ClaimMateReport
//
//  Created by Mac Mini on 05/10/19.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "StepperView.h"

@implementation StepperView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.masksToBounds = true;
    
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer.borderWidth = 2.0;
    
}

- (IBAction)btnPlusPressed:(UIButton *)sender {
    int number = [self.lblCounter.text intValue];
    self.lblCounter.text = [NSString stringWithFormat:@"%d",number + 1];
}

- (IBAction)btnMinusPressed:(UIButton *)sender {
    int number = [self.lblCounter.text intValue];
    if (number < 1){
        return;
    }
    self.lblCounter.text = [NSString stringWithFormat:@"%d",number - 1];
}
@end
