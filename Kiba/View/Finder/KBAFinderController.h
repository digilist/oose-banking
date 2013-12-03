//
//  KBAFinderController.h
//  Kiba
//
//  Created by 1fasselt on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAViewController.h"
#import <MapKit/MapKit.h>

@interface KBAFinderController : KBAViewController<MKMapViewDelegate>


@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end
