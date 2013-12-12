//
//  KBAExchangeRateDao.h
//  Kiba
//
//  Created by 1fasselt on 10.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KBAExchangeRateDao <NSObject>

- (NSArray*) getExchangeRates;

@end
