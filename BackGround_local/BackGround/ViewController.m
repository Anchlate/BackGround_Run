//
//  ViewController.m
//  BackGround
//
//  Created by Anchlate Lee on 16/7/10.
//  Copyright © 2016年 Anchlate. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testAudio];
    
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];    
    
}


- (void)testAudio {
    
    //后台播放音频设置
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //让app支持接受远程控制事件
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"235319.mp3" withExtension:nil];
    
    // 创建播放器
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player prepareToPlay];
    [self.player setVolume:1.0];
    self.player.numberOfLoops = -1; //设置音乐播放次数  -1为一直循环
    [self.player play]; //播放
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timeChange {
    
    NSLog(@"......还在后台运行");
    
}


@end
