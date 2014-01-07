//
//  KBACurrencyViewViewController.m
//  Kiba
//
//  Created by 1fasselt on 07.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBACurrencyContr.h"

#import "Currency.h"

#import "KBAExchangeRateDao.h"
#import "KBADependencyInjector.h"

static NSArray *currencies;

@interface KBACurrencyContr ()

@property Currency *selectedCurrency;

@end

@implementation KBACurrencyContr

+ (void)initialize {
    id<KBAExchangeRateDao> exchangeRateDao = [KBADependencyInjector getByKey:@"exchangeRateDao"];
    currencies = [exchangeRateDao getExchangeRates];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"KBACurrencyContr" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.preferredContentSize = self.view.frame.size;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currencyPickerView.delegate = self;
    [self pickerView:self.currencyPickerView didSelectRow:0 inComponent:0];
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
    
    return currency.formattedLabel;
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // value of picker view has changed
    self.selectedCurrency = currencies[row];
    [self onEuroFieldReturned:self.euroField];
}

#pragma mark Currency Logic

/**
 *  Will be executed when the user enters a new currency value.
 *
 *  @param sender The currency field.
 */
- (IBAction)onEuroFieldReturned:(UITextField *)sender {
    if (sender == self.euroField) {
        NSString *euroValue = sender.text;
        NSString *cleanEuro = [self cleanCurrencyString:euroValue];
        sender.text = cleanEuro;
        
        float euro = cleanEuro.floatValue;
        float convertedCurrency = [self.selectedCurrency convertFromEuro:euro];
        
        NSString *convertedCurrencyString = [NSString stringWithFormat:@"%.2f", convertedCurrency];
        convertedCurrencyString = [convertedCurrencyString stringByReplacingOccurrencesOfString:@"." withString:@","];
        convertedCurrencyString = [NSString stringWithFormat:@"%@ %@", convertedCurrencyString, self.selectedCurrency.symbol];
        
        [self.foreignCurrencyAmountLabel setText:convertedCurrencyString];
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
    if (!error) {
        NSString *cleanedString = [forbiddenCharsRegex stringByReplacingMatchesInString:subject options:0 range:NSMakeRange(0, subject.length) withTemplate:@""];
        NSRegularExpression *firstTrueMatchRegex = [NSRegularExpression regularExpressionWithPattern:@"\\d+(,\\d{2})?" options:0 error:&error];
        
        NSTextCheckingResult *match = [firstTrueMatchRegex firstMatchInString:cleanedString options:0 range:NSMakeRange(0, cleanedString.length)];
        
        if (match) {
            NSRange matchRange = match.range;
            return [cleanedString substringWithRange:matchRange];
        }
        
        return @"0,00";
    }
    
    return subject;
}

- (void)requestButtonPressed:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"Sortenanfrage"
                          message:@"Der angefragte Betrag ist verfügbar. Bitte vereinbaren Sie einen Termin!"
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    [alert show];

}

@end
