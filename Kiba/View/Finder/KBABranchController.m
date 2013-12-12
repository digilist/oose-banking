//
//  KBABranchController.m
//  Kiba
//
//  Created by 1fasselt on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAExchangeRateDao.h"
#import "KBADependencyInjector.h"

#import "KBABranchController.h"

#import "Branch.h"
#import "Currency.h"

static NSArray *currencies;

@interface KBABranchController ()

@property Branch *branch;
@property Currency *selectedCurrency;

@end

@implementation KBABranchController

+ (void)initialize {
    id<KBAExchangeRateDao> exchangeRateDao = [KBADependencyInjector getByKey:@"exchangeRateDao"];
    currencies = [exchangeRateDao getExchangeRates];
}

- (id) initWithBranch: (Branch *) branch {
    self = [self init];
    
    if (self)
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
    for (int i = 0; i < self.branch.openHours.count; i++)
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
    Currency *currency = currencies[row];
    
    return [[NSString alloc] initWithFormat:@"%@ - %@", currency.symbol, currency.code];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // value of picker view has changed
    self.selectedCurrency = currencies[row];
}

/**
 *  Will be executed when the user enters a new currency value.
 *
 *  @param sender The currency field.
 */
- (IBAction)onCurrencyReturned:(UITextField *)sender {
    if (sender == self.currencyField) {
        NSString *currencyValue = sender.text;
        NSString *cleanCurrency = [self cleanCurrencyString:currencyValue];
        sender.text = cleanCurrency;
    }
}

/**
 *  Cleans a string to have a valid currency value.
 *
 *  @param subject The string to be cleaned.
 *
 *  @return A clean currency value.
 */
- (NSString *)cleanCurrencyString:(NSString *)subject {
    NSError *error = NULL;
    NSRegularExpression *forbiddenCharsRegex = [NSRegularExpression regularExpressionWithPattern:@"[^\\d,]+"
                                                                                   options:0
                                                                                     error:&error];
    return [forbiddenCharsRegex stringByReplacingMatchesInString:subject options:0 range:NSMakeRange(0, subject.length) withTemplate:@""];
}

@end
