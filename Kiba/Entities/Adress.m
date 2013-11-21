//
//  Adress.m
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Adress.h"

@implementation Adress


-(id)initWithstreet: (NSString*) newStreet housenr: (NSString*) newHousenr postalcode: (int) newPostalcode city: (NSString*) newCity {
    
    if (self = [super init])
    {
        self.street = newStreet;
        self.housenr = newHousenr;
        self.postalcode = newPostalcode;
        self.city = newCity;
    }
    return self;


    
}


@end
