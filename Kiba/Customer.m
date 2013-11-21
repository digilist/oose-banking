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

-(id)initWithvname: (NSString*) newVname nname: (NSString*) newNname idintern: (int) newIdIntern pass: (NSString*) newPass ident: (NSString*) newIdent adress: (Adress*) newAdress accounts: (NSMapTable*) newAccounts cRating: (CreditRating*) newCRating{
    
    if (self = [super init])
    {
        self.vname = newVname;
        self.nname = newNname;
        self.idintern = newIdIntern;
        self.pass = newPass;
        self.ident = newIdent;
        self.adress = newAdress;
        self.accounts = newAccounts;
        self.cRating = newCRating;
    }
    return self;
    
    
    
}
/**
 *  Fügt einen neuen Account den Accountliste hinzu.
 *
 *  @param account <#account description#>
 */
-(void)addAccount: (Account*) account{
    [self.accounts setObject:account forKey: account.accountnr];
}
/**
 *  Gibt ein bestimmtes Konto des Nutzers zurück
 *
 *  @param accnr Kontonummer
 *
 *  @return Das Kontoobjekt
 */
-(Account*)gibAccount: (NSNumber*) accnr {
    return [self.accounts objectForKey:accnr];
}


@end
