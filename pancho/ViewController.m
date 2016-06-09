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

BOOL tracking;

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet TheMap *map;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.map.delegate = self;
    
    ann = [[Annotation alloc] init];
    taxiDriver = [[TaxiDriver alloc] init];
    tracking = NO;
    
}

//No momento o botão acha e centraliza o motorista do taxi 40, atualizando sua posição a cada 3 segundos
- (IBAction)currentLocationButtonPressed:(id)sender {
    
    //Método para mostrar minha localização
//    [[GPSManager sharedManager] myLocation:^(CLLocation *location, NSError *error) {
//        [self.map centerMapOnLocation:location];
//        ann.coordinate = location.coordinate;
//        [self.map addAnnotation:ann];
//    }];
    
    
    //A cada 3 segundos a posição do taxi é atualizada
    NSTimer *timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(startTracking) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void) startTracking {
    //Obtendo coordenadas do taxi no mapa
    [URLManager getTaxiLocationWithTaxiNumber:40 AndCompletionHandler:^(TaxiDriver *taxi) {
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
