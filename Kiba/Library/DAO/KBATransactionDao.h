//
//  KBATransactionDao.h
//  Kiba
//
//  Created by 1jendryc on 17.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"

@protocol KBATransactionDao <NSObject>

- (NSArray *) transactionsForCustomer: (Customer *)account;

@end