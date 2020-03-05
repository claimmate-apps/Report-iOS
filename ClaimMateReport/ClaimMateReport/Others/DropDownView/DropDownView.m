//
//  DropDownView.m
//  ClaimMateReport
//
//  Created by Mac Mini on 07/10/19.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "DropDownView.h"

@implementation DropDownView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.tblOptions registerNib:[UINib nibWithNibName:@"DropDownViewCell" bundle:nil] forCellReuseIdentifier:@"DropDownViewCell"];
}

-(void)setYPosition:(CGFloat)yPosition
{
    [self layoutIfNeeded];
    if(yPosition + 300 >= self.frame.size.height)
    {
        _nslcTableTop.active = false;
        _nslcTableBottom.active = true;
        _nslcTableBottom.constant = self.frame.size.height - yPosition;
    }
    else
    {
        _nslcTableTop.active = true;
        _nslcTableBottom.active = false;
        _nslcTableTop.constant = yPosition;
    }
}

#pragma mark - Tableview Delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrOptions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DropDownViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DropDownViewCell" forIndexPath:indexPath];
    cell.lblOption.text = [_arrOptions[indexPath.row] valueForKey:@"name"];
    
    if([[_arrOptions[indexPath.row] valueForKey:@"id"] isEqualToString:@"998"])
    {
        [cell.viewOptions setBackgroundColor:[UIColor colorWithRed:173.0/255.0 green:224.0/255.0 blue:252.0/252.0 alpha:1.0]];
    }
    else if([[_arrOptions[indexPath.row] valueForKey:@"id"] isEqualToString:@"999"])
    {
        [cell.viewOptions setBackgroundColor:[UIColor colorWithRed:169.0/255.0 green:187.0/255.0 blue:239.0/252.0 alpha:1.0]];
    }
    else
    {
        [cell.viewOptions setBackgroundColor:[UIColor whiteColor]];
    }
    
    //Set Content Size
    if(tableView.contentSize.height < 300)
    {
        self.nslcTblOptionHeight.constant = tableView.contentSize.height;
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        }];
        
    }
    else
    {
        self.nslcTblOptionHeight.constant = 300;
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        }];
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(didPressBack:name:)])
    {
        NSDictionary *dict = [_arrOptions objectAtIndex:indexPath.row];
        [self.delegate didPressBack:dict name:_name];
        [self removeFromSuperview];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

@end
