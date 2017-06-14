//
//  AppDelegate.m
//  BackGround
//
//  Created by Anchlate Lee on 16/7/10.
//  Copyright © 2016年 Anchlate. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()
{
    NSTimer *_timer;
    NSInteger _count;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance]setActive:YES error:nil];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantFuture]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    UIApplication *app = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
            
        });
    }];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
            
        });
        
    });
    
    [_timer setFireDate:[NSDate distantPast]];
    _count = 0;
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [_timer setFireDate:[NSDate distantFuture]];
    _count = 0;
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)timeChange {
    
    NSLog(@"......还在后台运行:%ld", _count);
    _count++;
}





@end
