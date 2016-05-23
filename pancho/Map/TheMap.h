//
//  TheMap.h
//  pancho
//
//  Created by Paulo Mendes on 5/16/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TheMap : MKMapView

- (void)centerMapOnLocation:(CLLocation *)location;

@end
