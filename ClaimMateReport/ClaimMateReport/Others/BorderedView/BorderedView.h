//
//  BorderedView.h
//  ClaimMateReport
//
//  Created by Mac Mini on 06/10/19.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BorderedView : UIView

@property (nonatomic, readwrite) IBInspectable BOOL isBorder;
@property (nonatomic, readwrite) IBInspectable BOOL isCornerRadius;

@end

NS_ASSUME_NONNULL_END
