//
//  KBACustomerDaoDummy.h
//  Kiba
//
//  Created by Michael Schaarschmidt on 12.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBACustomerDao.h"

@interface KBACustomerDaoDummy : NSObject<KBACustomerDao>

@property NSArray* accounts;
@property CreditRating* creditRating;

@end
