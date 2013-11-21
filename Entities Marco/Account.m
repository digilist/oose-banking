//
//  Account.m
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Account.h"

@implementation Account

-(id)initWithbalance: (NSNumber*) newBalance overdraft: (NSNumber*) newOverdraft accountnr: (NSNumber*) newAccountnr owner: (Customer*) newOwner {
    
    if (self = [super init])
    {
        self.balance = newBalance;
        self.overdraft = newOverdraft;
        self.accountnr = newAccountnr;
        self.owner = newOwner;
       
        

        
    }
    return self;
    
    
    
}



@end
