//
//  Branch.h
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Adress.h"

@interface Branch : NSObject

@property Adress* adress;
@property NSString* iBan;
@property NSString* bic;
@property NSArray* openHours;
@property CLLocationCoordinate2D coordinates;

@end
