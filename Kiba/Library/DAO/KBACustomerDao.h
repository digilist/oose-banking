//
//  KBACustomerDao.h
//  Kiba
//
//  Created by Schaarschmidt, Michael on 12.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"

@protocol KBACustomerDao <NSObject>

- (NSArray*) getAccounts: (Customer*)customer;

@end
