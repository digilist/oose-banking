//
//  Currency.m
//  Kiba
//
//  Created by 1fasselt on 10.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Currency.h"

static NSMutableDictionary *currencySymbols;

@implementation Currency

+ (void)initialize {
    currencySymbols = [NSMutableDictionary new];
    [currencySymbols setValue:@"$" forKey:@"USD"];
    [currencySymbols setValue:@"$" forKey:@"JPY"];
    [currencySymbols setValue:@"$" forKey:@"BGN"];
    [currencySymbols setValue:@"$" forKey:@"CZK"];
    [currencySymbols setValue:@"$" forKey:@"DKK"];
    [currencySymbols setValue:@"$" forKey:@"GBP"];
    [currencySymbols setValue:@"$" forKey:@"HUF"];
    [currencySymbols setValue:@"$" forKey:@"LTL"];
    [currencySymbols setValue:@"$" forKey:@"LVL"];
    [currencySymbols setValue:@"$" forKey:@"PLN"];
    [currencySymbols setValue:@"$" forKey:@"RON"];
    [currencySymbols setValue:@"$" forKey:@"SEK"];
    [currencySymbols setValue:@"$" forKey:@"CHF"];
    [currencySymbols setValue:@"$" forKey:@"NOK"];
    [currencySymbols setValue:@"$" forKey:@"HRK"];
    [currencySymbols setValue:@"$" forKey:@"RUB"];
    [currencySymbols setValue:@"$" forKey:@"TRY"];
    [currencySymbols setValue:@"$" forKey:@"AUD"];
    [currencySymbols setValue:@"$" forKey:@"BRL"];
    [currencySymbols setValue:@"$" forKey:@"CAD"];
    [currencySymbols setValue:@"$" forKey:@"CNY"];
    [currencySymbols setValue:@"$" forKey:@"HKD"];
    [currencySymbols setValue:@"$" forKey:@"IDR"];
    [currencySymbols setValue:@"$" forKey:@"ILS"];
    [currencySymbols setValue:@"$" forKey:@"INR"];
    [currencySymbols setValue:@"$" forKey:@"KRW"];
    [currencySymbols setValue:@"$" forKey:@"MXN"];
    [currencySymbols setValue:@"$" forKey:@"MYR"];
    [currencySymbols setValue:@"$" forKey:@"NZD"];
    [currencySymbols setValue:@"$" forKey:@"PHP"];
    [currencySymbols setValue:@"$" forKey:@"SGD"];
    [currencySymbols setValue:@"$" forKey:@"THB"];
    [currencySymbols setValue:@"$" forKey:@"ZAR"];
}

- (id) initWithCode:(NSString*)code
               rate:(float) rate {
    
    self = [self init];
    
    if(self) {
        self.code = code;
        self.rate = rate;
    }
    
    return self;
}

- (NSString*) symbol {
    return [currencySymbols valueForKey:self.code];
}

@end
