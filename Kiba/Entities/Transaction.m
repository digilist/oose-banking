//
//  Transaction.m
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Transaction.h"


@implementation Transaction

-(id)initWithType: (id) newType recipient: (Account*) newRecipient sender: (Account*) newSender amount: (NSNumber*) newAmount date: (NSDate*) newDate {
    
    if (self = [super init]) {
        self.type = newType;
        self.recipient = newRecipient;
        self.sender = newSender;
        self.amount = newAmount;
        self.date = newDate;
        
    }
    return self;
   
  
    
}

- (NSString *)printTransactionTiny {
    NSString *string = [NSString stringWithFormat: @"Sender: %@, %@ \nEmpfänger: %@, %@ \nBetrag: %.2f €" , self.sender.owner.surname, self.sender.owner.forename, self.recipient.owner.surname, self.recipient.owner.forename, [self.amount doubleValue]];
    return string;
}

- (NSString *)printTransactionTinyRecipient {
    NSString *string = [NSString stringWithFormat: @"%@, %@ \n%.2f €" , self.sender.owner.surname, self.sender.owner.forename, [self.amount doubleValue]];
    return string;
}

- (NSString *)printTransactionTinySender {
    NSString *string = [NSString stringWithFormat: @"%@, %@ \n%.2f €" ,  self.recipient.owner.surname, self.recipient.owner.forename, [self.amount doubleValue] ];
    return string;
}

- (NSString *)printTransactionTinyOwn {
    NSString *string = [NSString stringWithFormat: @"%@\n%.2f €\n%@" ,  self.recipient.name ,[self.amount doubleValue], self.sender.name ];
    return string;
}
@end
