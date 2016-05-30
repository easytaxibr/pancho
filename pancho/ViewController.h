//
//  ViewController.h
//  pancho
//
//  Created by Paulo Mendes on 5/16/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Rotate.h"
#import "TaxiClient.h"
#import "TaxiDriverViewModel.h"

@interface ViewController : UIViewController
@property (readonly, nonatomic) NSMutableDictionary *locationDictionary;
@end

