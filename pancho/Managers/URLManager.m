//
//  URLManager.m
//  pancho
//
//  Created by Lidia Chou on 6/7/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import "URLManager.h"
#import <AFHTTPSessionManager.h>

static NSString * const BaseURLString = @"http://localhost:8080/api/taxi-position/the-taxi";

@implementation URLManager

//Recebe número do taxi e retorna suas coordenadas (latitude e longitude)
+(void) getTaxiLocationWithTaxiNumber: (int) taxiNumber AndCompletionHandler: (void(^)(TaxiDriver *taxi)) callback {
    
    //Busca a URL e retorna os dados do táxi cujo número é dado (40)
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"session":[NSNumber numberWithInt:taxiNumber]};
    
    [manager GET:BaseURLString parameters: parameters progress:nil success:^(NSURLSessionTask *task, NSDictionary *infos) {
        
        TaxiDriver *taxiDriverLocation = [[TaxiDriver alloc] init];
        
        NSDictionary *position = [infos objectForKey:@"position"];
        NSNumber *lat = [position objectForKey:@"lat"];
        NSNumber *lng = [position objectForKey:@"lng"];

        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat.doubleValue, lng.doubleValue);
        taxiDriverLocation.coordinate = coordinate;
        
        callback(taxiDriverLocation);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
 }

@end