//
//  TaxiDriver.h
//  pancho
//
//  Created by Ezequiel on 5/30/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TaxiDriver

@end

@interface TaxiDriver : NSObject

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@property (strong, nonatomic) NSString *car_model;
//@property (nonatomic) BOOL *isArravied;
@property (strong, nonatomic) NSString *is_arravied;
@property (strong, nonatomic) NSString *driver_name;
@property (strong, nonatomic) NSString* license_plate;
@property (strong, nonatomic) NSDictionary* position;

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
