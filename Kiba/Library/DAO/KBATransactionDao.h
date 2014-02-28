//
//  KBATransactionDao.h
//  Kiba
//
//  Created by Marco F. Jendryczko on 17.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"
#import "Account.h"

@protocol KBATransactionDao <NSObject>

- (NSArray *) transactionsForCustomer: (Customer *)account;

- (void) transferWithSender: (Account *) sender ToRecipient: (Account *) recipient withAmount: (NSNumber *) amount;

@end