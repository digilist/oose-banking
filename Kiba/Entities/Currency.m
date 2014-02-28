//
//  Currency.m
//  Kiba
//
//  Created by Markus Fasselt on 10.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Currency.h"

static NSMutableDictionary *currencySymbols;

@implementation Currency

+ (void)initialize {
    currencySymbols = [NSMutableDictionary new];
    [currencySymbols setValue:@"$" forKey:@"USD"];
    [currencySymbols setValue:@"¥" forKey:@"JPY"];
    [currencySymbols setValue:@"Lev" forKey:@"BGN"];
    [currencySymbols setValue:@"Kc" forKey:@"CZK"];
    [currencySymbols setValue:@"kr." forKey:@"DKK"];
    [currencySymbols setValue:@"£" forKey:@"GBP"];
    [currencySymbols setValue:@"Ft" forKey:@"HUF"];
    [currencySymbols setValue:@"Lt" forKey:@"LTL"];
    [currencySymbols setValue:@"Ls" forKey:@"LVL"];
    [currencySymbols setValue:@"zł" forKey:@"PLN"];
    [currencySymbols setValue:@"RON" forKey:@"RON"];
    [currencySymbols setValue:@"Skr" forKey:@"SEK"];
    [currencySymbols setValue:@"SFr." forKey:@"CHF"];
    [currencySymbols setValue:@"kr" forKey:@"NOK"];
    [currencySymbols setValue:@"kn" forKey:@"HRK"];
    [currencySymbols setValue:@"R" forKey:@"RUB"];
    [currencySymbols setValue:@"₺" forKey:@"TRY"];
    [currencySymbols setValue:@"$A" forKey:@"AUD"];
    [currencySymbols setValue:@"R$" forKey:@"BRL"];
    [currencySymbols setValue:@"$" forKey:@"CAD"];
    [currencySymbols setValue:@"元" forKey:@"CNY"];
    [currencySymbols setValue:@"HK$" forKey:@"HKD"];
    [currencySymbols setValue:@"Rp." forKey:@"IDR"];
    [currencySymbols setValue:@"₪" forKey:@"ILS"];
    [currencySymbols setValue:@"₹" forKey:@"INR"];
    [currencySymbols setValue:@"₩" forKey:@"KRW"];
    [currencySymbols setValue:@"$" forKey:@"MXN"];
    [currencySymbols setValue:@"RM" forKey:@"MYR"];
    [currencySymbols setValue:@"NZ$" forKey:@"NZD"];
    [currencySymbols setValue:@"₷" forKey:@"PHP"];
    [currencySymbols setValue:@"$" forKey:@"SGD"];
    [currencySymbols setValue:@"฿" forKey:@"THB"];
    [currencySymbols setValue:@"R" forKey:@"ZAR"];
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

- (float)euroWithCurrency:(float)otherCurrency {
    return otherCurrency / self.rate;
}

- (float)convertFromEuro:(float) euro {
    return euro * self.rate;
}

- (NSString *)formattedLabel {
    return [[NSString alloc] initWithFormat:@"%@ - %@", self.symbol, self.code];
}

@end
