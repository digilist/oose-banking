//
//  KBACustomerDaoDummy.m
//  Kiba
//
//  Created by Schaarschmidt, Michael on 12.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBACustomerDaoDummy.h"
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
    
    Account *acc1 = [[Account alloc] initWithBalance:balacne overDraft:nil accountNr:accountnr name:nil owner:customer];
    NSArray *accs = [[NSArray alloc] initWithObjects:(id) acc1, nil];
    customer.accounts = accs;
    
    return customer;
                          
}

@end
