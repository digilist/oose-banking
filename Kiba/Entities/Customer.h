//
//  Customer.h
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Address.h"
#import "CreditRating.h"
#import "Message.h"


@interface Customer : User
-(id)initWithForeName: (NSString*) forename
             surname: (NSString*) surname
             customerId: (int) userId
             pass: (NSString*) pass
             ident: (NSString*) ident
             adress: (Address*) address
             accounts: (NSArray*) accounts
             creditRating: (CreditRating*) creditRating;

// Perso Ident Einloggkennung!
@property NSString *ident;
@property Address *address;
@property NSArray *accounts;
@property NSMutableArray *messages;
@property CreditRating *creditRating;
@property Boolean authenticated;


@end
