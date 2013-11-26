//
//  Branch.m
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Branch.h"

@implementation Branch

-(id)initWithadress: (Adress*) newAdress iBan: (NSString*) newIBan bic: (NSString*) newBic openHours: (NSArray*) NewOpenHours {
    
    if (self = [super init])
    {
        self.adress = newAdress;
        self.iBan = newIBan;
        self.bic = newBic;
        self.openHours = NewOpenHours;
    }
    return self;
    
    
    
}


@end
