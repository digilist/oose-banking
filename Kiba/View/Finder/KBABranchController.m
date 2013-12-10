//
//  KBABranchController.m
//  Kiba
//
//  Created by 1fasselt on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBABranchController.h"
#import "Branch.h"

static NSArray *currencies;

@interface KBABranchController ()

@property Branch *branch;
@property NSString *selectedCurrency;

@end

@implementation KBABranchController

+ (void)initialize {
    currencies = @[@"$ - USD", @"¥ - Yen", @"£ - GBP", @"₨ - Rupee", @"﷼ - Rial", @"₩ - Won", @"S₣ - CHF", @"₯ - Drachme"];
}

- (id) initWithBranch: (Branch*) branch {
    self = [self init];
    
    if(self)
    {
        self.branch = branch;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self pickerView:self.currencyPickerView didSelectRow:0 inComponent:0];
    
    NSMutableString *openingHours = [NSMutableString new];
    for(int i = 0; i < self.branch.openHours.count; i++)
    {
        [openingHours appendFormat:@"%@\n", [self.branch.openHours[i] formatted]];
    }
    self.openingHoursLabel.text = openingHours;
    [self.openingHoursLabel sizeToFit];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return currencies.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return currencies[row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // value of picker view has changed
    self.selectedCurrency = currencies[row];
}

@end
