//
//  locationUpdateManager.h
//  BackGround
//
//  Created by Anchlate Lee on 16/7/10.
//  Copyright © 2016年 Anchlate. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>

@interface ANLocationUpdateManager : NSObject<CLLocationManagerDelegate>

+ (instancetype)sharedStandardManager1;
- (void)startStandardUpdatingLocation;
- (void)stopStandardUpdatingLocation;

@end
