//
//  TheMap.m
//  pancho
//
//  Created by Paulo Mendes on 5/16/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import "TheMap.h"

@implementation TheMap

- (void)centerMapOnLocation:(CLLocation *)location {
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.01, 0.01));
    self.region = region;
}

@end
