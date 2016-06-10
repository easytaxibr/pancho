//
//  TaxiDriver.h
//  pancho
//
//  Created by Lidia Chou on 6/7/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface TaxiDriver : NSObject <MKAnnotation>  {
    CLLocationCoordinate2D lastCoordinate;
    CLLocationCoordinate2D newCoordinate;
}

@property (nonatomic, assign) CLLocationCoordinate2D lastCoordinate;
@property (nonatomic, assign) CLLocationCoordinate2D newCoordinate;
@property (nonatomic, assign) MKAnnotationView *pinView;

+ (id)sharedManager;

@end
