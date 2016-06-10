//
//  URLManager.h
//  pancho
//
//  Created by Lidia Chou on 6/7/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "TaxiDriver.h"

@interface URLManager : NSObject

+(void) getTaxiLocationWithTaxiNumber: (int) taxiNumber AndCompletionHandler: (void(^)(TaxiDriver *taxi)) callback;

@end
