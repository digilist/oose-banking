//
//  KBACustomerDaoDummy.m
//  Kiba
//
//  Created by Schaarschmidt, Michael on 12.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBACustomerDaoDummy.h"
#import "Customer.h"

@implementation KBACustomerDaoDummy

- (Customer *) getCustomer: (NSString*)name :(NSString*)password {
    
    Customer *customer = [[Customer alloc] initWithForeName: @"Max"
                                                    surname: @"Mustermann"
                                                 customerId: 1
                                                       pass: @"test"
                                                      ident: @"maxm"
                                                     adress: nil
                                                   accounts: nil
                                               creditRating: nil];
    
    return customer;
                          
}

@end
