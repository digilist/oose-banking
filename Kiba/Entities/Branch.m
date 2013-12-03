//
//  Branch.m
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Branch.h"

@implementation Branch

-(id)initWithAdress: (Adress*) address
               iBan: (NSString*) iBan
                bic: (NSString*) bic
                openHours: (NSArray*) openHours
                coordinates: (CLLocationCoordinate2D) coordinates {
    
    if (self = [super init])
    {
        self.adress = address;
        self.iBan = iBan;
        self.bic = bic;
        self.openHours = openHours;
        self.coordinates = coordinates;
    }
    return self;
}

@end