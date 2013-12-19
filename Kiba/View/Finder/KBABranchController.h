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
@property (weak, nonatomic) IBOutlet UIDatePicker *appointmentPicker;

@property (weak, nonatomic) IBOutlet UIButton *currencySelectButton;
@property (nonatomic, weak) IBOutlet UIPickerView *currencyPickerView;
@property (weak, nonatomic) IBOutlet UITextField *currencyField;
@property (weak, nonatomic) IBOutlet UILabel *euroLabel;

- (id) initWithBranch: (Branch*) branch;
- (IBAction)onCurrencyReturned:(UITextField *)sender;

@end
