//
//  Adress.m
//  Kiba
//
//  Created by Marco F. Jendryczko on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Address.h"
#import <MapKit/MapKit.h>

@implementation Address


-(id)initWithStreet: (NSString*) street
            houseNr: (NSString*) houseNr
         postalCode: (NSString*) postalCode
               city: (NSString*) city
        coordinates: (CLLocationCoordinate2D) coordinates
{
    if (self = [super init])
    {
        self.street = street;
        self.houseNr = houseNr;
        self.postalCode = postalCode;
        self.city = city;
        self.coordinates = coordinates;
    }
    
    return self;
}

-(NSString *)formatted
{
    return [NSString stringWithFormat:@"%@ %@, %@ %@",
            self.street,
            self.houseNr,
            self.postalCode,
            self.city];
}

@end
