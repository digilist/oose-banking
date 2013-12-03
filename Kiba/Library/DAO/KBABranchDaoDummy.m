//
//  KBAFilialDaoDummy.m
//  Kiba
//
//  Created by 1fasselt on 19.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBABranchDaoDummy.h"
#import "Branch.h"
#import "Address.h"

@implementation KBABranchDaoDummy

- (NSArray *)getBranchesNearPoint:(CGPoint)location {
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 53.581516;
    coordinate.longitude = 10.080806;
    
    Address *address1 = [[Address alloc] initWithStreet:@"Schulterblatt" houseNr:@"42" postalCode:@"22763" city:@"Hamburg" coordinates:coordinate];
    
    Branch *branch1 = [[Branch alloc] initWithName:@"KiBa Filiale Schulterblatt" address:address1 iBan:@"123" bic:@"456" openHours:@[]];
    
    return @[branch1];
}

@end
