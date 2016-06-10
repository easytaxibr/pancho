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

BOOL firstTime;
BOOL tracking;

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet TheMap *map;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.map.delegate = self;
    
    ann = [[Annotation alloc] init];
    taxiDriver = [TaxiDriver sharedManager];
    firstTime = YES;
    tracking = NO;
    
}

//No momento o botão acha e centraliza o motorista do taxi 50, atualizando sua posição a cada 3 segundos
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
   
    //Salva a última coordenada encontrada antes de atualizá-la
    taxiDriver.lastCoordinate = taxiDriver.newCoordinate;

    //Obtendo coordenadas do taxi 50 no mapa
    [URLManager getTaxiLocationWithTaxiNumber:50 AndCompletionHandler:^(TaxiDriver *taxi) {
        
        taxiDriver = taxi;
        ann.coordinate = taxiDriver.newCoordinate;
        [self.map addAnnotation:ann];
        
        if (firstTime == YES) {
            firstTime = NO;
            
            //Para que a tela fique centralizada no taxi na primeira vez que o botão é clicado
            [self.map centerMapOnLocation:ann];
        }
        
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
