//
//  TaxiDriver.m
//  pancho
//
//  Created by Ezequiel on 5/30/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import "TaxiDriver.h"

@implementation TaxiDriver

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        self.car_model = dictionary[@"car_model"];
        self.driver_name = dictionary[@"driver_name"];
        self.license_plate = dictionary[@"license_plate"];
        self.position = dictionary[@"position"];
        self.is_arravied = dictionary[@"is_arravied"];
    }
    return self;
}

@end
