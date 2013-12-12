//
//  Branch.m
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Branch.h"

@implementation Branch

-(id)initWithName: (NSString*) name
                address: (Address*) address
                bic: (NSString*) bic
                openHours: (NSArray*) openHours {
    
    if (self = [super init])
    {
        self.name = name;
        self.address = address;
        self.bic = bic;
        self.openHours = openHours;
    }
    return self;
}

@end