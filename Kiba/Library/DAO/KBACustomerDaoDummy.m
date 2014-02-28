//
//  KBACustomerDaoDummy.m
//  Kiba
//
//  Created by Michael Schaarschmidt on 12.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBACustomerDaoDummy.h"
#import "KBAAccountDao.h"
#import "KBACreditRatingDao.h"
#import "KBACreditRatingDaoDummy.h"
#import "KBAMessageDao.h"
#import "KBADependencyInjector.h"
#import "Customer.h"
#import "Account.h"
@implementation KBACustomerDaoDummy

- (Customer *)customerWithName:(NSString*)name andPassword:(NSString*)password
{
    Customer *customer = [[Customer alloc] initWithForeName: @"Markus"
                                                    surname: @"König"
                                                 customerId: 1
                                                       pass: @"test"
                                                      ident: @"maxm"
                                                     adress: nil
                                                   accounts: nil
                                               creditRating: nil];
    
    // Relations
    id<KBAAccountDao> accountDao = [KBADependencyInjector getByKey:@"accountDao"];
    customer.accounts = [accountDao getAccounts:customer];
    
    id<KBACreditRatingDao> creditDao = [KBADependencyInjector getByKey:@"creditDao"];
    customer.creditRating = [creditDao getCreditRating];
    
    id<KBAMessageDao> messageDao = [KBADependencyInjector getByKey:@"messageDao"];
    customer.messages = [messageDao messagesForCustomer:customer];
    
    return customer;
}


    


@end
