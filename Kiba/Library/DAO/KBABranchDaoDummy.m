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
#import "OpenHour.h"

@implementation KBABranchDaoDummy

- (NSArray *)getBranchesNearPoint:(CGPoint)location {
    
    OpenHour *openHour1 = [[OpenHour alloc] initWithWeekDay:KBAMonday openingTime:480 closingTime:810];
    OpenHour *openHour2 = [[OpenHour alloc] initWithWeekDay:KBATuesday openingTime:480 closingTime:720];
    OpenHour *openHour3 = [[OpenHour alloc] initWithWeekDay:KBAWednesday openingTime:600 closingTime:810];
    OpenHour *openHour4 = [[OpenHour alloc] initWithWeekDay:KBAThursday openingTime:480 closingTime:1080];
    OpenHour *openHour5 = [[OpenHour alloc] initWithWeekDay:KBAFriday openingTime:600 closingTime:720];
    
    NSArray *openHours = @[openHour1, openHour2, openHour3, openHour4, openHour5];
    
    Address *address1 = [[Address alloc] initWithStreet:@"Schulterblatt"
                                                houseNr:@"65" postalCode:@"20357"
                                                   city:@"Hamburg"
                                            coordinates:CLLocationCoordinate2DMake(53.56162, 9.96195)];
    Branch *branch1 = [[Branch alloc] initWithName:@"KiBa Filiale Schulterblatt"
                                           address:address1
                                               bic:@"456"
                                         openHours:openHours];
    
    Address *address2 = [[Address alloc] initWithStreet:@"Vogt-Kölln-Straße"
                                                houseNr:@"30"
                                             postalCode:@"22527"
                                                   city:@"Hamburg"
                                            coordinates:CLLocationCoordinate2DMake(53.59934999999999, 9.93191)];
    Branch *branch2 = [[Branch alloc] initWithName:@"KiBa Filiale Informatikum"
                                           address:address2
                                               bic:@"456"
                                         openHours:openHours];
    
    return @[branch1, branch2];
}

@end
