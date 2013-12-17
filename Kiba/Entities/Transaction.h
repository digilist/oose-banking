//
//  Transaction.h
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"


@interface Transaction : NSObject

@property id type;

// TODO: Recipient von andere bank? what what? :D
@property Account* recipient;
@property Account* sender;
@property NSNumber* amount;
@property NSDate* date;

-(id)initWithType: (id) newType
        recipient: (Account*) newRecipient
           sender: (Account*) newSender
           amount: (NSNumber*) newAmount
             date: (NSDate*) newDate;

-(NSString *)printTransactionTiny;


@end
