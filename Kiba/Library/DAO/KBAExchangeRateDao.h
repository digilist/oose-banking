//
//  KBAExchangeRateDao.h
//  Kiba
//
//  Created by Markus Fasselt on 10.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@protocol KBAExchangeRateDao <NSObject>

- (NSArray*) getExchangeRates;

- (void) transferWithSender: (Account *) sender ToRecipient: (Account *) recipient withAmount: (NSNumber *) amount;

@end
