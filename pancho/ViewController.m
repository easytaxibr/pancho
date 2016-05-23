//
//  ViewController.m
//  pancho
//
//  Created by Paulo Mendes on 5/16/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import "ViewController.h"
#import "GPSManager.h"
#import "TheMap.h"
#import "Annotation.h"

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet TheMap *map;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.map.delegate = self;
}

- (IBAction)currentLocationButtonPressed:(id)sender {
    [[GPSManager sharedManager] myLocation:^(CLLocation *location, NSError *error) {
        [self.map centerMapOnLocation:location];
        Annotation *ann = [[Annotation alloc] init];
        ann.coordinate = location.coordinate;
        [self.map addAnnotation:ann];
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *MyPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
    
    return MyPin;
}

@end
