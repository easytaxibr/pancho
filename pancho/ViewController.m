//
//  ViewController.m
//  pancho
//
//  Created by Paulo Mendes on 5/16/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet TheMap *map;
@property (weak, nonatomic) NSTimer* taxiTimer;
@property BOOL mapMoving;
@property (strong, nonatomic) NSString *session;
@property CLLocationCoordinate2D current;
@property float angle;
@property Annotation *_annotation;
@end

@implementation ViewController

@synthesize _annotation;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.map.delegate = self;
    self.map.rotateEnabled = false;
    [self configSession];
    [self centerUserLocation];
    [self configTaxisTimer:3.0];
}

- (IBAction)currentLocationButtonPressed:(id)sender {
    [self centerUserLocation];
}

- (IBAction)currentTaxiLocationButtonPressed:(id)sender {
    _mapMoving = TRUE;
}

- (void)configSession {
    int r = arc4random_uniform(10000);
    _session = [NSString stringWithFormat:@"%d", r];
}

- (void)configTaxisTimer:(CGFloat)time{
    _taxiTimer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(getTaxisPosition) userInfo:nil repeats:YES];
    [_taxiTimer fire];
}

- (void)getTaxisPosition{
    
    
    NSString *url = [NSString stringWithFormat:ENDPOINT, _session];
    
    TaxiClient *t = [TaxiClient shared];
    
    [t GET:url atGetParameter:nil atBlock:^(id responseObj, NSURLSessionTask *task, NSError *error) {
        TaxiDriverViewModel *tx = [[TaxiDriverViewModel alloc]init];
        [tx configure:[[TaxiDriver alloc] initWithDictionary:responseObj]];
        
        CLLocationCoordinate2D cl = CLLocationCoordinate2DMake(tx.latitude.floatValue, tx.longitude.floatValue);
        CLLocation *location = [[CLLocation alloc] initWithLatitude:cl.latitude longitude:cl.longitude];
        
        _angle = [self angleFromCoordinates:cl toCoordinate:_current];
        _annotation = [[Annotation alloc] init];
        [_annotation setCoordinate:cl];
        
        [UIView beginAnimations:@"annotation" context:nil];
        [UIView setAnimationDuration:3.0];
        [UIView commitAnimations];
        [self.map removeAnnotations:_map.annotations];
        if(_mapMoving)[self.map centerMapOnLocation:location];
        [self.map addAnnotation:_annotation];
        _current = cl;
        
    } atKey:(NSString *)NSURLErrorDomain];
    
}

- (void)centerUserLocation{
    _mapMoving = FALSE;
    [[GPSManager sharedManager] myLocation:^(CLLocation *location, NSError *error) {
        [self.map centerMapOnLocation:location];
        Annotation *ann = [[Annotation alloc] init];
        ann.coordinate = location.coordinate;
        [self.map addAnnotation:self.map.userLocation];
    }];
}


#pragma mark -  MK Delegates

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *MyPin = nil;//[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
    
    if(annotation != mapView.userLocation)
    {
        if (MyPin == nil) {
            MyPin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
            MyPin.image = [UIImage imageNamed:@"pin_taxi_regular"];
            MyPin.image = [MyPin.image imageRotatedByDegrees:_angle];
        }
    }
    else{
        self.map.userLocation.title = @"Estou Aqui";
    }
    
    return MyPin;
}

#pragma mark - Método Auxiliar

/*
 Usei uma interpolação simples, é possível calcular com maior precisão.
 http://www.pilotopolicial.com.br/calculando-distancias-e-direcoes-utilizando-coordenadas-geograficas/
 https://www.youtube.com/watch?v=_mlcNa1Odxo
 */

-(float)angleFromCoordinates:(CLLocationCoordinate2D)firstCoordinate
                toCoordinate:(CLLocationCoordinate2D)secondCoordinate {
    
    float deltaLongitude = secondCoordinate.longitude - firstCoordinate.longitude;
    float deltaLatitude = secondCoordinate.latitude - firstCoordinate.latitude;
    
    float angle = (M_PI * .5f) - atan(deltaLatitude / deltaLongitude);
    
    if (deltaLongitude > 0)      return RADIANS_TO_DEGREES(angle);
    else if (deltaLongitude < 0) return RADIANS_TO_DEGREES(angle + M_PI);
    else if (deltaLatitude < 0)  return RADIANS_TO_DEGREES(M_PI);
    
    return 0.0f;
}


@end
