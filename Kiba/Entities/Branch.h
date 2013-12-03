//
//  Branch.h
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Address.h"

@interface Branch : NSObject

@property NSString *name;
@property Address *adress;
@property NSString *iBan;
@property NSString *bic;
@property NSArray *openHours;

-(id)initWithName: (NSString*) name
          address: (Address*) address
             iBan: (NSString*) iBan
              bic: (NSString*) bic
        openHours: (NSArray*) openHours;

@end
