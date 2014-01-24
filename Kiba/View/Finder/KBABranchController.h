//
//  KBABranchController.h
//  Kiba
//
//  Created by 1fasselt on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAViewController.h"
#import "Branch.h"

@interface KBABranchController : KBAViewController<UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *branchLabel;

@property (nonatomic, weak) IBOutlet UILabel *openingHoursLabel;
@property (nonatomic, weak) IBOutlet UILabel *contactPersonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contactImage;

@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *appointmentView;
@property (weak, nonatomic) IBOutlet UIView *currencyView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet KBAButton *currencyButton;
@property (weak, nonatomic) IBOutlet KBAButton *appointmentButton;

- (id) initWithBranch: (Branch*) branch;

@end
