//
//  ViewController.m
//  pancho
//
//  Created by Paulo Mendes on 5/16/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import "ViewController.h"
#import "GPSManager.h"
#import "URLManager.h"
#import "TheMap.h"
#import "Annotation.h"
#import "TaxiDriver.h"

Annotation *ann;
TaxiDriver *taxiDriver;

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet TheMap *map;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.map.delegate = self;
    
    ann = [[Annotation alloc] init];
    taxiDriver = [[TaxiDriver alloc] init];
    
}

//No momento o botão acha e centraliza o motorista de taxi 36
- (IBAction)currentLocationButtonPressed:(id)sender {
    
    //Método para mostrar minha localização
//    [[GPSManager sharedManager] myLocation:^(CLLocation *location, NSError *error) {
//        [self.map centerMapOnLocation:location];
//        ann.coordinate = location.coordinate;
//        [self.map addAnnotation:ann];
//    }];
    
    
    //Obtendo coordenadas do taxi no mapa
    [URLManager getTaxiLocationWithTaxiNumber:36 AndCompletionHandler:^(TaxiDriver *taxi) {
        taxiDriver = taxi;
        ann.coordinate = taxiDriver.coordinate;
        [self.map addAnnotation:ann];
        [self.map centerMapOnLocation:ann];
        
    }];
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    //Permitindo apenas uma Annotation de cada vez e mudando a imagem (apenas uma imagem de táxi por mapa)
    MKAnnotationView *MyPin = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"current"];
    if (!MyPin) {
        MyPin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
        MyPin.image = [UIImage imageNamed:@"pin_taxi_regular"];
    } else {
        MyPin.annotation = annotation;
    }
    return MyPin;
    
}

@end
