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
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) MKAnnotationView *pinView;

@end
