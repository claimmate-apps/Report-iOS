//
//  BorderedView.m
//  ClaimMateReport
//
//  Created by Mac Mini on 06/10/19.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "BorderedView.h"

IB_DESIGNABLE
@implementation BorderedView

-(void)setIsBorder:(BOOL)isBorder
{
    self.layer.borderColor = [[UIColor blueColor] CGColor];
    self.layer.borderWidth = 2.0;
}

-(void)setIsCornerRadius:(BOOL)isCornerRadius
{
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.masksToBounds = true;
}

@end
