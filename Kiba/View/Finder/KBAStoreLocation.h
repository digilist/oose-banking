//
//  KBAStoreLocation.h
//  Kiba
//
//  Created by 1fasselt on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Branch.h"

@interface KBAStoreLocation : NSObject <MKAnnotation>

@property (nonatomic, retain) Branch *branch;

- (id)initWithBranch: (Branch*)branch;
- (MKMapItem*)mapItem;

@end
