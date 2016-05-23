
#import <Foundation/Foundation.h>

@class CLLocation;

typedef void (^GPSLocationBlockType)(CLLocation *location, NSError *error);

@interface GPSManager : NSObject

+ (instancetype)sharedManager;
- (void)myLocation:(GPSLocationBlockType)completion;

- (void)askForPermition;

@end
