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

-(id)initWithvName: (NSString*) newVName nName: (NSString*) newNName idIntern: (int) newIdIntern pass: (NSString*) newPass ident: (NSString*) newIdent adress: (Adress*) newAdress accounts: (NSMapTable*) newAccounts cRating: (CreditRating*) newCRating{
    
    if (self = [super init])
    {
        self.vName = newVName;
        self.nName = newNName;
        self.idIntern = newIdIntern;
        self.pass = newPass;
        self.ident = newIdent;
        self.adress = newAdress;
        self.accounts = newAccounts;
        self.cRating = newCRating;
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
