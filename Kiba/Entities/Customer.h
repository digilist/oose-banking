//
//  Customer.h
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Adress.h"
#import "CreditRating.h"


@interface Customer : NSObject
-(id)initWithForeName: (NSString*) forename
             surname: (NSString*) surname
             customerId: (int) customerId
             pass: (NSString*) pass
             ident: (NSString*) ident
             adress: (Adress*) adress
             accounts: (NSMapTable*) accounts
             creditRating: (CreditRating*) creditRating;

@property NSString *forename;
@property NSString *surmame;
@property int customerId;
@property NSString *pass;

// Perso Ident Einloggkennung!
@property NSString *ident;
@property Adress *adress;
@property NSMapTable *accounts;
@property CreditRating *creditRating;
@property Boolean verificated;




@end
