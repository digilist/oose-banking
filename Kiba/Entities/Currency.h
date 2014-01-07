//
//  Currency.h
//  Kiba
//
//  Created by 1fasselt on 10.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject

@property NSString *code;
@property float rate;

- (id) initWithCode:(NSString*)code
               rate:(float) rate;

- (NSString*) symbol;
- (float)euroWithCurrency:(float) otherCurrency;
- (float)convertFromEuro:(float) euro;
- (NSString *)formattedLabel;

@end
