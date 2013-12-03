//
//  KBAFinderController.m
//  Kiba
//
//  Created by 1fasselt on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAFinderController.h"
#import "KBAStoreLocation.h"

#define METERS_PER_MILE 1609.344

@interface KBAFinderController ()

@end

@implementation KBAFinderController

- (void)viewWillAppear:(BOOL)animated {
    
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 53.581516;
    zoomLocation.longitude = 10.080806;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 100 * METERS_PER_MILE, 100 * METERS_PER_MILE);
    
    [_mapView setRegion:viewRegion animated:YES];
    
    [self addMarkers];
}


-(void)addMarkers {
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 53.581516;
    coordinate.longitude = 10.080806;

    
    KBAStoreLocation *annotation = [[KBAStoreLocation alloc] initWithName:@"test" address:@"Vogt-Kölln-Straße 30, 22527 Hamburg" coordinate:coordinate] ;
    [_mapView addAnnotation:annotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    
    if ([annotation isKindOfClass:[KBAStoreLocation class]]) {
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"Image"];
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

@end
