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
    
    if (!self.mapMoving) {
        TaxiClient *t = [[TaxiClient alloc]init];
        CLLocationCoordinate2D coordinate = [self userLocation];
        
        
        //        [self.taxis removeAllObjects];
        //        [self reverseGeocodeLocation:coordinate completion:^(NSString *address, NSError *error) {}];
        //        [t getTaxisArround:coordinate andTaxis:self.taxis completion:^(NSError *error) {
        //            
        //            if (error) {
        //                NSLog(@"Erro ao obter coordenadas");
        //                return;
        //            }
        //            [[self mapView]clear];
        //            [self configureUserMarker];
        //            for (Taxi *tx in self.taxis) {
        //                TaxiViewModel *txv = [[TaxiViewModel alloc]initWithTaxi:tx];
        //                [self configureTaxisMarker:txv];
        //            }
        //        }];
    }
}

- (CLLocationCoordinate2D)userLocation{
    float latitude = [self.locationDictionary[@"latitude"] floatValue];
    float longitude = [self.locationDictionary[@"longitude"] floatValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    return coordinate;
}


#pragma mark - Dragable Marker Delegates

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *MyPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
    return MyPin;
}

-(void)mapView:(MKMapView *)mapView didBeginDraggingMarker:(MKMapView *)marker{
    self.mapMoving = TRUE;
}


@end
