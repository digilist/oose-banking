//
//  Branch.m
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Branch.h"
#import "Consultant.h"

@implementation Branch

-(id)initWithName:(NSString *)name
          address:(Address *)address
              bic:(NSString *)bic
        openHours:(NSArray *)openHours
       consultant:(Consultant *)consultant
      phoneNumber:(NSString *)phoneNumber {
    
    if (self = [super init]) {
        self.name = name;
        self.address = address;
        self.bic = bic;
        self.openHours = openHours;
        self.consultant = consultant;
        self.phoneNumber = phoneNumber;
    }
    return self;
}

@end