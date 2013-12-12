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
@property Address *address;
@property NSString *bic;
@property NSArray *openHours;

-(id)initWithName: (NSString*) name
          address: (Address*) address
              bic: (NSString*) bic
        openHours: (NSArray*) openHours;

@end
