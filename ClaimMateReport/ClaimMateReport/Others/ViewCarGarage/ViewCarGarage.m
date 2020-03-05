//
//  ViewCarGarage.m
//  ClaimMateReport
//
//  Created by Mac Mini on 06/10/19.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "ViewCarGarage.h"

@implementation ViewCarGarage

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.btnRemove.layer.cornerRadius = self.btnRemove.frame.size.width/2;
    self.btnRemove.layer.masksToBounds = true;
}

- (IBAction)btnRemoveTapped:(UIButton *)sender {
    [self removeFromSuperview];
}

- (IBAction)btnAttachPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}
@end
