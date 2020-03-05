//
//  SelectableView.m
//  ClaimMateReport
//
//  Created by Mac Mini on 06/10/19.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "SelectableView.h"

@implementation SelectableView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.layer.cornerRadius = 20;
    self.layer.masksToBounds = true;
    
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [[UIColor blueColor] CGColor];
}

- (IBAction)btnSelectPressed:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(didFinishWithSelectView:index:)]) {
        [self.delegate didFinishWithSelectView:_isEdgeMetal index:_index];
    }
    sender.selected = !sender.isSelected;
    if(sender.isSelected)
    {
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self setBackgroundColor:[UIColor blueColor]];
    }
    else{
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}

-(void)deselect
{
    [self.btnView setSelected:NO];
    [self.btnView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor whiteColor]];
}



@end
