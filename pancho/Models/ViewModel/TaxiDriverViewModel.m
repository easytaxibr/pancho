//
//  TaxiDriverViewModel.m
//  pancho
//
//  Created by Ezequiel on 5/30/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import "TaxiDriverViewModel.h"

@implementation TaxiDriverViewModel

-(void)configure:(TaxiDriver *)model {
    self.driver = model;
}

-(NSString *)carModel{
    return _driver.car_model;
}
-(NSString *)driverName{
    return self.driver.driver_name;
}
-(NSString *)licensePlate{
    return self.driver.license_plate;
}
-(NSNumber *)latitude{
    return _driver.position[@"lat"];
}
-(NSNumber *)longitude{
    return _driver.position[@"lng"];
}
- (BOOL)isArravied{
    return _driver.is_arravied.boolValue;
}

@end
