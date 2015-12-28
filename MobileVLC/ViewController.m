//
//  ViewController.m
//  MobileVLC
//
//  Created by fuland539 on 15/12/25.
//  Copyright © 2015年 xiaohuoban. All rights reserved.
//

#import "ViewController.h"
#import <MobileVLCKit/MobileVLCKit.h>

#define playerDefaultUrl @"rtmp://live.hkstv.hk.lxdns.com/live/hks"

@interface ViewController ()
@property (strong, nonatomic) VLCMediaPlayer *mediaplayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mediaplayer = [[VLCMediaPlayer alloc] init];
    _mediaplayer.delegate = self;
    _mediaplayer.drawable = self.view;
    _mediaplayer.media = [VLCMedia mediaWithURL:[NSURL URLWithString:playerDefaultUrl]];
    [_mediaplayer play];
    [self backPlayerUrl:1];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSString *)backPlayerUrl:(NSInteger)index
{
    NSString *playerUrl = playerDefaultUrl;
    NSArray *plist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PlayerUrl" ofType:@"plist"]];
    NSDictionary *dic = plist[index];
    return playerUrl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
