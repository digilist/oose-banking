//
//  KBAFinderController.m
//  Kiba
//
//  Created by 1fasselt on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAFinderController.h"
#import "KBAStoreLocation.h"
#import "KBABranchController.h"

#import "KBADependencyInjector.h"
#import "KBABranchDao.h"
#import "KBAColorHelper.h"

#import "Branch.h"
#import "OpenHour.h"

#define METERS_PER_MILE 1609.344

@interface KBAFinderController ()

@property id<KBABranchDao> branchDao;

@end

@implementation KBAFinderController

- (id) init {
    self = [super init];
    
    if (self) {
        self.branchDao = [KBADependencyInjector getByKey:@"branchDao"];
    }
    
    return self;
}

- (void)viewDidLoad {
    
    self.mapView.delegate = self;
    
    // set map center
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 53.57953999999999;
    zoomLocation.longitude = 9.963533099999999;
    
    int radius = 10;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, radius * METERS_PER_MILE, radius * METERS_PER_MILE);
    [_mapView setRegion:viewRegion animated:YES];
    
    [self addMarkers];
}

/**
 *  Add a single Marker to the Map.
 */
-(void)addMarkers {
    
    CGPoint mapCenter = CGPointMake(self.mapView.region.center.latitude, self.mapView.region.center.longitude);
    NSArray *branches = [self.branchDao getBranchesNearPoint: mapCenter];
    
    for (Branch *branch in branches) {
        KBAStoreLocation *annotation = [[KBAStoreLocation alloc] initWithBranch:branch];
        [_mapView addAnnotation:annotation];
    }
}

/**
 *  create an alternative marker icon.
 *
 *  @param mapView
 *  @param annotation
 *
 *  @return
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    
    if ([annotation isKindOfClass:[KBAStoreLocation class]]) {
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"MarkerFiliale"];
            
            KBAButton *rightButton = [KBAButton buttonWithType:UIButtonTypeDetailDisclosure];
            annotationView.rightCalloutAccessoryView = rightButton;
            
            annotationView.tintColor = KBATintColor;
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // KBAStoreLocation *location = (KBAStoreLocation*) view.annotation;
    // annotation clicked
}

- (void)mapView:(MKMapView *)map annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    KBAStoreLocation *location = (KBAStoreLocation*) view.annotation;
    
    // annotation bubble (accessory) clicked
    
    [self.navigationController pushViewController:[[KBABranchController alloc] initWithBranch: location.branch] animated:YES];
}

@end
