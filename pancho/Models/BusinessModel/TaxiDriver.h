//
//  TaxiDriver.h
//  pancho
//
//  Created by Ezequiel on 5/30/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaxiDriver : NSObject

@property (weak, nonatomic) NSString *cardModel;
@property (nonatomic) BOOL *isArravied;
@property (weak, nonatomic) NSString *driverName;
@property (weak, nonatomic) NSString *licensePlate;
@property (weak, nonatomic) NSNumber *latitude;
@property (weak, nonatomic) NSNumber *longitude;

//{
//    "car_model": "Tesla Model",
//    "is_arravied": false,
//    "driver_name": "Foo Bar",
//    "license_plate": "FOO-4242",
//    "position": {
//        "lat": -23.544775,
//        "lng": -46.720251
//    }
//}

@end
