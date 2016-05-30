//
//  TaxiDriverViewModel.h
//  pancho
//
//  Created by Ezequiel on 5/30/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaxiDriver.h"

@interface TaxiDriverViewModel : NSObject

@property (strong, nonatomic) TaxiDriver *driver;

@property (strong, readonly) NSString *carModel;
@property (strong, readonly) NSString *is_arravied;
@property (strong, readonly) NSString *driverName;
@property (strong, readonly) NSString *licensePlate;
@property (strong, readonly) NSString *position;
@property (strong, readonly) NSNumber *latitude;
@property (strong, readonly) NSNumber *longitude;


-(void)configure:(TaxiDriver *)model;

@end
