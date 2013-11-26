//
//  Transaction.m
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Transaction.h"


@implementation Transaction

-(id)initWithtype: (id) newType recipient: (Account*) newRecipient sender: (Account*) newSender amount: (NSNumber*) newAmount date: (NSDate*) newDate {
    
    if (self = [super init]) {
        self.type = newType;
        self.recipient = newRecipient;
        self.sender = newSender;
        self.amount = newAmount;
        self.date = newDate;
    }
    return self;
}
@end
