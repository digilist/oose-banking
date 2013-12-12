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
#import "Consultant.h"

@implementation KBABranchDaoDummy

- (NSArray *)getBranchesNearPoint:(CGPoint)location {
    
    OpenHour *openHour1 = [[OpenHour alloc] initWithWeekDay:KBAMonday openingTime:480 closingTime:810];
    OpenHour *openHour2 = [[OpenHour alloc] initWithWeekDay:KBATuesday openingTime:480 closingTime:720];
    OpenHour *openHour3 = [[OpenHour alloc] initWithWeekDay:KBAWednesday openingTime:600 closingTime:810];
    OpenHour *openHour4 = [[OpenHour alloc] initWithWeekDay:KBAThursday openingTime:480 closingTime:1080];
    OpenHour *openHour5 = [[OpenHour alloc] initWithWeekDay:KBAFriday openingTime:600 closingTime:720];
    
    NSArray *openHours = @[openHour1, openHour2, openHour3, openHour4, openHour5];
    Consultant *consultant = [[Consultant alloc] initWithId:1 forename:@"Max" surname:@"Mustermann" pass:@"passwort" phoneNumber:@"040 12 34 56" image:nil businessPosition:@"Kundenberater"];
    
    Address *address1 = [[Address alloc] initWithStreet:@"Schulterblatt"
                                                houseNr:@"65" postalCode:@"20357"
                                                   city:@"Hamburg"
                                            coordinates:CLLocationCoordinate2DMake(53.56162, 9.96195)];
    Branch *branch1 = [[Branch alloc] initWithName:@"KiBa Filiale Schulterblatt"
                                           address:address1
                                               bic:@"456"
                                         openHours:openHours
                                        consultant:consultant];
    
    Address *address2 = [[Address alloc] initWithStreet:@"Vogt-Kölln-Straße"
                                                houseNr:@"30"
                                             postalCode:@"22527"
                                                   city:@"Hamburg"
                                            coordinates:CLLocationCoordinate2DMake(53.59934999999999, 9.93191)];
    Branch *branch2 = [[Branch alloc] initWithName:@"KiBa Filiale Informatikum"
                                           address:address2
                                               bic:@"456"
                                         openHours:openHours
                                        consultant:consultant];
    Address *address3 = [[Address alloc] initWithStreet:@"Jungfernstieg"
                                                houseNr:@"7"
                                             postalCode:@"20534"
                                                   city:@"Hamburg"
                                            coordinates:CLLocationCoordinate2DMake(53.55281, 9.99326)];
    Branch *branch3 = [[Branch alloc] initWithName:@"KiBa Filiale Jungfernstieg"
                                           address:address3
                                               bic:@"456"
                                         openHours:openHours
                                        consultant:consultant];
    
    Address *address4 = [[Address alloc] initWithStreet:@"Steintorwall"
                                                houseNr:@"10"
                                             postalCode:@"20534"
                                                   city:@"Hamburg"
                                            coordinates:CLLocationCoordinate2DMake(53.55108, 9.99368)];
    Branch *branch4 = [[Branch alloc] initWithName:@"KiBa Filiale Rathaus"
                                           address:address4
                                               bic:@"456"
                                         openHours:openHours
                                        consultant:consultant];
    Address *address5 = [[Address alloc] initWithStreet:@"Rothenbaumchaussee"
                                                houseNr:@"27"
                                             postalCode:@"20144"
                                                   city:@"Hamburg"
                                            coordinates:CLLocationCoordinate2DMake(53.56594, 9.98837)];
    Branch *branch5 = [[Branch alloc] initWithName:@"KiBa Filiale Rothenbaum"
                                           address:address5
                                               bic:@"456"
                                         openHours:openHours
                                        consultant:consultant];
    
    Address *address6 = [[Address alloc] initWithStreet:@"Grindelhof"
                                                houseNr:@"57"
                                             postalCode:@"20144"
                                                   city:@"Hamburg"
                                            coordinates:CLLocationCoordinate2DMake(53.56969, 9.98393)];
    Branch *branch6 = [[Branch alloc] initWithName:@"KiBa Filiale Grindelhof"
                                           address:address6
                                               bic:@"456"
                                         openHours:openHours
                                        consultant:consultant];
    
    
    Address *address7 = [[Address alloc] initWithStreet:@"Lesserstraße"
                                                houseNr:@"7"
                                             postalCode:@"22049"
                                                   city:@"Hamburg"
                                            coordinates:CLLocationCoordinate2DMake(53.58003, 10.07188)];
    Branch *branch7 = [[Branch alloc] initWithName:@"KiBa Filiale Wandsbek"
                                           address:address7
                                               bic:@"456"
                                         openHours:openHours
                                        consultant:consultant];
    
    Address *address8 = [[Address alloc] initWithStreet:@"Max-Brauer-Allee"
                                                houseNr:@"51"
                                             postalCode:@"22767"
                                                   city:@"Hamburg"
                                            coordinates:CLLocationCoordinate2DMake(53.55135, 9.93579)];
    Branch *branch8 = [[Branch alloc] initWithName:@"KiBa Filiale Altona"
                                           address:address8
                                               bic:@"456"
                                         openHours:openHours
                                        consultant:consultant];
    
    Address *address9 = [[Address alloc] initWithStreet:@"Reeperbahn"
                                                houseNr:@"83"
                                             postalCode:@"20359"
                                                   city:@"Hamburg"
                                            coordinates:CLLocationCoordinate2DMake(53.54921, 9.96192)];
    Branch *branch9 = [[Branch alloc] initWithName:@"KiBa Filiale Reeperbahn"
                                           address:address9
                                               bic:@"456"
                                         openHours:openHours
                                        consultant:consultant];
    
    Address *address10 = [[Address alloc] initWithStreet:@"Osterstraße"
                                                 houseNr:@"104"
                                              postalCode:@"20255"
                                                    city:@"Hamburg"
                                             coordinates:CLLocationCoordinate2DMake(53.57629, 9.95262)];
    Branch *branch10 = [[Branch alloc] initWithName:@"KiBa Filiale Osterstraße"
                                            address:address10
                                                bic:@"456"
                                          openHours:openHours
                                         consultant:consultant];
    
    
    
    return @[branch1, branch2, branch3, branch4, branch5, branch6, branch7, branch8, branch9, branch10];
}

@end
