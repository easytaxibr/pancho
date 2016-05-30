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
@property (nonatomic, strong)  NSTimer* taxiTimer;
@property BOOL mapMoving;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.map.delegate = self;
    [self configTaxisTimer:5.0];
}

- (IBAction)currentLocationButtonPressed:(id)sender {
    [[GPSManager sharedManager] myLocation:^(CLLocation *location, NSError *error) {
        [self.map centerMapOnLocation:location];
        Annotation *ann = [[Annotation alloc] init];
        ann.coordinate = location.coordinate;
        [self.map addAnnotation:ann];
    }];
}



- (void)configTaxisTimer:(CGFloat)time{
    _taxiTimer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(getTaxisPosition) userInfo:nil repeats:YES];
    [_taxiTimer fire];
}

- (void)getTaxisPosition{
    
    //if (!self.mapMoving) {
    TaxiClient *t = [TaxiClient shared];
    
    [t GET:ENDPOINT atGetParameter:nil atBlock:^(id responseObj, NSURLSessionTask *task, NSError *error) {
        NSLog(@"%@", responseObj);
        
        TaxiDriverViewModel *tx = [[TaxiDriverViewModel alloc]init];
        [tx configure:[[TaxiDriver alloc] initWithDictionary:responseObj]];
        NSLog(@"%@", tx.latitude);
        NSLog(@"%@", tx.longitude);
        
        CLLocationCoordinate2D cl = CLLocationCoordinate2DMake(tx.latitude.floatValue, tx.longitude.floatValue);
        
        Annotation *annotation = [[Annotation alloc] init];
        [annotation setCoordinate:cl];
        //[annotation setTitle:@"Title"]; //You can set the subtitle too
        [self.map removeAnnotations:_map.annotations];
        [self.map addAnnotation:annotation];
        
    } atKey:(NSString *)NSURLErrorDomain];
    
}

- (CLLocationCoordinate2D)userLocation{
    float latitude = [self.locationDictionary[@"latitude"] floatValue];
    float longitude = [self.locationDictionary[@"longitude"] floatValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    return coordinate;
}


#pragma mark -  MK Delegates

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *MyPin = nil;//[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
    
    if(annotation != mapView.userLocation)
    {
        if (MyPin == nil) MyPin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
        MyPin.image = [UIImage imageNamed:@"pin_taxi_regular"];
    }
    else {
        [mapView.userLocation setTitle:@"I am here"];
    }
    return MyPin;
}



@end
