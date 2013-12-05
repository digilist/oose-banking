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
    
    Address *address1 = [[Address alloc] initWithStreet:@"Schulterblatt"
                                                houseNr:@"65" postalCode:@"20357"
                                                   city:@"Hamburg"
                                            coordinates:CLLocationCoordinate2DMake(53.56162, 9.96195)];
    Branch *branch1 = [[Branch alloc] initWithName:@"KiBa Filiale Schulterblatt"
                                           address:address1
                                               bic:@"456"
                                         openHours:@[]];
    
    Address *address2 = [[Address alloc] initWithStreet:@"Vogt-Kölln-Straße"
                                                houseNr:@"30"
                                             postalCode:@"22527"
                                                   city:@"Hamburg"
                                            coordinates:CLLocationCoordinate2DMake(53.59934999999999, 9.93191)];
    Branch *branch2 = [[Branch alloc] initWithName:@"KiBa Filiale Informatikum"
                                           address:address2
                                               bic:@"456"
                                         openHours:@[]];
    
    return @[branch1, branch2];
}

@end
