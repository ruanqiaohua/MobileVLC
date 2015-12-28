//
//  MorePlayerUrlViewController.h
//  MobileVLC
//
//  Created by ruanqiaohua on 15/12/28.
//  Copyright © 2015年 xiaohuoban. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MorePlayerUrlViewControllerDelegate <NSObject>

- (void)morePlayerUrlViewControllerChoosePlayerUrl:(NSString *)playerUrl;

@end

@interface MorePlayerUrlViewController : UIViewController
@property (weak, nonatomic) id<MorePlayerUrlViewControllerDelegate>delegate;
@end
