//
//  DropDownView.h
//  ClaimMateReport
//
//  Created by Mac Mini on 07/10/19.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownViewCell.h"

@protocol DropDowViewDelegate <NSObject>

-(void)didPressBack:(NSDictionary *_Nonnull)dictData name:(NSString *_Nonnull)name;

@end

NS_ASSUME_NONNULL_BEGIN

@interface DropDownView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblOptions;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nslcTblOptionHeight;
@property (nonatomic, readwrite) NSArray *arrOptions;
@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, readwrite) CGFloat yPosition;
@property (nonatomic, readwrite) id<DropDowViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nslcTableTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nslcTableBottom;

@end

NS_ASSUME_NONNULL_END
