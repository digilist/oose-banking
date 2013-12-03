//
//  KBABranchDao.h
//  Kiba
//
//  Created by 1fasselt on 19.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "KBABranchDao.h"
#import "Address.h"

@interface KBABranchDaoDummy : NSObject<KBABranchDao>

-(id)initWithName: (NSString*) name
          address: (Address*) address
             iBan: (NSString*) iBan
              bic: (NSString*) bic
        openHours: (NSArray*) openHours
      coordinates: (CLLocationCoordinate2D) coordinates;

@end
