//
//  StepperView.h
//  ClaimMateReport
//
//  Created by Mac Mini on 05/10/19.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StepperView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lblCounter;

- (IBAction)btnPlusPressed:(UIButton *)sender;

- (IBAction)btnMinusPressed:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
