//
//  Adress.h
//  Kiba
//
//  Created by Marco F. Jendryczko on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Address : NSObject

@property NSString* street;
@property NSString* houseNr;
@property NSString* postalCode;
@property NSString* city;
@property CLLocationCoordinate2D coordinates;
@property (readonly) NSString* formatted;

-(id)initWithStreet:(NSString*) street
            houseNr:(NSString*) houseNr
         postalCode:(NSString*) postalCode
               city:(NSString*) city
        coordinates:(CLLocationCoordinate2D) coordinates;

@end
