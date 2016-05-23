//
//  Annotation.h
//  pancho
//
//  Created by Paulo Mendes on 5/16/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface Annotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
