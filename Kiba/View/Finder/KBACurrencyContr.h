//
//  KBACurrencyViewViewController.h
//  Kiba
//
//  Created by 1fasselt on 07.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAViewController.h"

@interface KBACurrencyContr : UIViewController<UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UIPickerView *currencyPickerView;
@property (weak, nonatomic) IBOutlet UITextField *euroField;
@property (weak, nonatomic) IBOutlet UILabel *foreignCurrencyAmountLabel;

- (IBAction)onEuroFieldReturned:(UITextField *)sender;
- (IBAction)requestButtonPressed:(UIButton *)sender;

@end