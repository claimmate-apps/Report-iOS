//
//  ViewCarGarage.h
//  ClaimMateReport
//
//  Created by Mac Mini on 06/10/19.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepperView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewCarGarage : UIView
@property (weak, nonatomic) IBOutlet StepperView *stepperCarGarage;
@property (weak, nonatomic) IBOutlet UIButton *btnAttach;
@property (weak, nonatomic) IBOutlet UIButton *btnRemove;

- (IBAction)btnRemoveTapped:(UIButton *)sender;
- (IBAction)btnAttachPressed:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
