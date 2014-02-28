//
//  KBAAccountDao.h
//  Kiba
//
//  Created by Michael Schaarschmidt on 12.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"
#import "Account.h"

@protocol KBAAccountDao <NSObject>

- (NSArray *) getAccounts: (Customer *)customer;
- (NSArray *)turnoverForAccount:(Account *)account;

@end
