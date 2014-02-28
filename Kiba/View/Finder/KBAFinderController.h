//
//  KBAFinderController.h
//  Kiba
//
//  Created by Markus Fasselt on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAViewController.h"
#import <MapKit/MapKit.h>

@interface KBAFinderController : KBAViewController<MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end
