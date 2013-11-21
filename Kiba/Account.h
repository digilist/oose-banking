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
@property NSNumber* overdraft;
@property NSNumber* accountnr;
@property Customer* owner;


-(id)initWithbalance: (NSNumber*) newBalance
           overdraft: (NSNumber*) newOverdraft
           accountnr: (NSNumber*) newAccountnr
               owner: (Customer*) newOwner;

@end
