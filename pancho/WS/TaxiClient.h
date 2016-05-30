//
//  TaxiClient.h
//  pancho
//
//  Created by Ezequiel on 5/30/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import "NetworkClient.h"
#define ENDPOINT @"http://localhost:55/api/taxi-position/the-taxi?session=1"

@interface TaxiClient : NetworkClient

@end
