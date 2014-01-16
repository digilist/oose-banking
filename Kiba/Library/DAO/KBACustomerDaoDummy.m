//
//  KBACustomerDaoDummy.m
//  Kiba
//
//  Created by Schaarschmidt, Michael on 12.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBACustomerDaoDummy.h"
#import "KBAAccountDao.h"
#import "KBADependencyInjector.h"
#import "Customer.h"
#import "Account.h"
@implementation KBACustomerDaoDummy

- (Customer *) getCustomer: (NSString*)name :(NSString*)password {
    
    NSNumber *balacne = [[NSNumber alloc] initWithDouble:2000.00];
    NSNumber *accountnr = [[NSNumber alloc] initWithLongLong:4584796321589];
    
                         

    
    Customer *customer = [[Customer alloc] initWithForeName: @"Max"
                                                    surname: @"Mustermann"
                                                 customerId: 1
                                                       pass: @"test"
                                                      ident: @"maxm"
                                                     adress: nil
                                                   accounts: nil
                                               creditRating: nil];
    
    id<KBAAccountDao> accountDao = [KBADependencyInjector getByKey:@"accountDao"];
    customer.accounts = [accountDao getAccounts:customer];
    
    return customer;
                          
}

@end
