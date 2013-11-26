//
//  Adress.m
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Adress.h"

@implementation Adress


-(id)initWithStreet: (NSString*) newStreet houseNr: (NSString*) newHouseNr postalCode: (int) newPostalCode city: (NSString*) newCity {
    
    if (self = [super init])
    {
        self.street = newStreet;
        self.houseNr = newHouseNr;
        self.postalCode = newPostalCode;
        self.city = newCity;
    }
    return self;


    
}


@end
