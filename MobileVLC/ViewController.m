//
//  ViewController.m
//  MobileVLC
//
//  Created by fuland539 on 15/12/25.
//  Copyright © 2015年 xiaohuoban. All rights reserved.
//

#import "ViewController.h"
#import <MobileVLCKit/MobileVLCKit.h>
#import "MorePlayerUrlViewController.h"

#define playerDefaultUrl @"rtmp://live.hkstv.hk.lxdns.com/live/hks"

@interface ViewController ()<MorePlayerUrlViewControllerDelegate>
@property (strong, nonatomic) VLCMediaPlayer *mediaplayer;
@property (strong, nonatomic) UIView *playerView;
@property (strong, nonatomic) UIButton *moreBtn;
@property (assign, nonatomic) BOOL cancelHidden;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _playerView = [[UIView alloc]initWithFrame:self.view.bounds];
    _playerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_playerView];
   
    _moreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _moreBtn.frame = CGRectMake(0, 0, 50, 30);
    [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_moreBtn];
    [_moreBtn addTarget:self action:@selector(moreBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setHidden:YES];

    [self mediaplayerPlay:playerDefaultUrl];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)mediaplayerPlay:(NSString *)playerUrl
{
    _mediaplayer = [[VLCMediaPlayer alloc] init];
    _mediaplayer.delegate = self;
    _mediaplayer.drawable = _playerView;
    _mediaplayer.media = [VLCMedia mediaWithURL:[NSURL URLWithString:playerUrl]];
    [_mediaplayer play];
}

- (void)moreBtnDidClick:(UIButton *)sender
{
    [self hiddenToolBox];
    MorePlayerUrlViewController *VC = [[MorePlayerUrlViewController alloc]init];
    VC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    VC.delegate = self;
    [self presentViewController:VC animated:NO completion:nil];
}

- (void)hiddenToolBox
{
    [_moreBtn setHidden:YES];
    _cancelHidden = NO;
}

- (void)showToolBox
{
    [_moreBtn setHidden:NO];
    _cancelHidden = YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_cancelHidden) {
        [self hiddenToolBox];
    }else {
        [self showToolBox];
    }
}

- (void)morePlayerUrlViewControllerChoosePlayerUrl:(NSString *)playerUrl
{
    [_mediaplayer stop];
    [self mediaplayerPlay:playerUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
