//
//  Account.m
//  Kiba
//
//  Created by Marco F. Jendryczko on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Account.h"


@implementation Account

-(id)initWithBalance: (NSNumber*) newBalance
           overDraft: (NSNumber*) newOverDraft
           accountNr: (NSNumber*) newAccountNr
                name: (NSString*) name
               owner: (Customer*) newOwner {
    
    if (self = [super init]) {
        self.balance = newBalance;
        self.overDraft = newOverDraft;
        self.accountNr = newAccountNr;
        self.description = name;
        self.owner = newOwner;
    }
    return self;
}



@end
