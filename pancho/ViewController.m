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

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))



@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet TheMap *map;
@property (nonatomic, strong) NSTimer* taxiTimer;
@property BOOL mapMoving;
@property NSString *session;
@property CLLocationCoordinate2D current;
@property float angle;
@property Annotation *_annotation;
@end

@implementation ViewController

@synthesize _annotation;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.map.delegate = self;
    [self configSession];
    [self configTaxisTimer:3.0];
}

- (IBAction)currentLocationButtonPressed:(id)sender {
    [[GPSManager sharedManager] myLocation:^(CLLocation *location, NSError *error) {
        [self.map centerMapOnLocation:location];
        Annotation *ann = [[Annotation alloc] init];
        ann.coordinate = location.coordinate;
        [self.map addAnnotation:ann];
    }];
}


- (void)configSession {
    int r = arc4random_uniform(1000);
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
        NSLog(@"%@", responseObj);
        
        TaxiDriverViewModel *tx = [[TaxiDriverViewModel alloc]init];
        [tx configure:[[TaxiDriver alloc] initWithDictionary:responseObj]];
        NSLog(@"%@", tx.latitude);
        NSLog(@"%@", tx.longitude);
        
        CLLocationCoordinate2D cl = CLLocationCoordinate2DMake(tx.latitude.floatValue, tx.longitude.floatValue);
        _angle = [self angleFromCoordinates:cl toCoordinate:_current];
        
        NSLog(@"AGORA");
        NSLog(@"%@", tx.latitude);
        NSLog(@"%@", tx.longitude);
        NSLog(@"ANTES");
        NSLog(@"%f", _current.latitude);
        NSLog(@"%f", _current.longitude);
        NSLog(@"ANGULO");
        NSLog(@"%f", _angle);
        ;
        
        //        [annotation setCoordinate:cl];
        _annotation = [[Annotation alloc] init];
        [_annotation setCoordinate:cl];
        NSArray* currentAnnotations = [self.map annotations];
        _annotation = [currentAnnotations lastObject]; // I am assuming you only have 1 annotation
        [_annotation setCoordinate:cl];
        
        
        //        [self.map removeAnnotations:_map.annotations];
        //        [UIView beginAnimations:@"annotation" context:nil];
        //        [UIView setAnimationDuration:1.0];
        //        [UIView commitAnimations];
        [self.map addAnnotation:_annotation];
        _current = cl;
        
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
    
    //    if(annotation != mapView.userLocation)
    //    {
    if (MyPin == nil) MyPin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
    MyPin.image = [UIImage imageNamed:@"pin_taxi_regular"];
    MyPin.image = [MyPin.image imageRotatedByDegrees:_angle];
    return MyPin;
}



// Usei uma interpolação simples, é possível calcular com maior precisão. Neste caso atendeu razoavelmente bem.
// http://www.pilotopolicial.com.br/calculando-distancias-e-direcoes-utilizando-coordenadas-geograficas/
// https://www.youtube.com/watch?v=_mlcNa1Odxo

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
