//
//  CreditRating.m
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "CreditRating.h"

@implementation CreditRating

-(id)initWithStatus: (NSString*) newStatus
        creditLimit: (NSNumber*) newCreditLimit
          riskLevel: (NSNumber*) newRiskLevel
    financingMatrix: (NSDictionary*) newFinancingMatrix{
    
    if (self = [super init])
    {
        self.status = newStatus;
        self.creditLimit = newCreditLimit;
        self.riskLevel = newRiskLevel;
        self.financingMatrix = newFinancingMatrix;
    }
    return self;
    
    
    
}

@end
