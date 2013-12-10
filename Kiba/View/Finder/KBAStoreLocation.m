//
//  KBAStoreLocation.m
//  Kiba
//
//  Created by 1fasselt on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAStoreLocation.h"
#import "OpenHour.h"
#import <AddressBook/AddressBook.h>

@interface KBAStoreLocation ()

@end

@implementation KBAStoreLocation

/**
 *  Initializes a store location.
 *
 *  @param branch       The branch
 *  @return A new instance.
 */
- (id)initWithBranch:(Branch*)branch {
    self = [super init];
    
    if (self) {
        self.branch = branch;
    }
    return self;
}

- (NSString *)title {
    return self.branch.name;
}

- (NSString *)subtitle {
    return [NSString stringWithFormat:@"%@, %@", self.branch.address.formatted, ((OpenHour *) self.branch.openHours.firstObject).formatted];
}

- (CLLocationCoordinate2D)coordinate {
    return self.branch.address.coordinates;
}

- (MKMapItem*)mapItem {
    NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey : self.branch.address};
    
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}

@end