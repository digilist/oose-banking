//
//  Account.h
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"

@interface Account : NSObject

@property NSNumber* balance;
@property NSNumber* overDraft;
@property NSNumber* accountNr;
@property Customer* owner;

-(void)sendMoney: (NSNumber*) amount;


-(id)initWithBalance: (NSNumber*) newBalance
           overDraft: (NSNumber*) newOverDraft
           accountNr: (NSNumber*) newAccountNr
               owner: (Customer*) newOwner;

@end
