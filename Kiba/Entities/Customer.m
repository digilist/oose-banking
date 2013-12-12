//
//  Customer.m
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Customer.h"
#import "Account.h"

@implementation Customer

-(id)initWithForeName: (NSString *)forename
              surname: (NSString *)surname
           customerId: (int) customerId
                 pass: (NSString *)pass
                ident: (NSString *)ident
               adress: (Address *)address
             accounts: (NSMapTable *)accounts
         creditRating: (CreditRating *)creditRating {
    
    if (self = [super init]) {
        self.forename = forename;
        self.surmame = surname;
        self.customerId = customerId;
        self.pass = pass;
        self.ident = ident;
        self.address = address;
        self.accounts = accounts;
        self.creditRating = creditRating;
        // Vllt auch als Parameter im Konstruktor
        self.verificated = false;
    }
    return self;
}

/**
 *  Fügt einen neuen Account den Accountliste hinzu.
 *
 *  @param account Ein Bankaccount
 *
-(void)addAccount: (Account*) account{
    [self.accounts setObject:account forKey: account.accountNr];
}


 *  Gibt ein bestimmtes Konto des Nutzers zurück
 *
 *  @param accnr Kontonummer
 *
 *  @return Das Kontoobjekt
 *
-(Account*)getAccount: (NSNumber*) accnr {
    return [self.accounts objectForKey:accnr];
}
*/


@end
