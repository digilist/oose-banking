//
//  CreditRating.m
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "CreditRating.h"

@implementation CreditRating

-(id)initWithstatus: (NSString*) newStatus creditLimit: (NSNumber*) newCreditLimit riskLevel: (NSNumber*) newRiskLevel {
    
    if (self = [super init])
    {
        self.status = newStatus;
        self.creditLimit = newCreditLimit;
        self.risklevel = newRiskLevel;
        
    }
    return self;
    
    
    
}

@end
