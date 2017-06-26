//
//  BDJAdvertisementViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJAdvertisementViewController.h"



@interface BDJAdvertisementViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchView;
@property (weak, nonatomic) IBOutlet UIView *adView;

@end

@implementation BDJAdvertisementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpLaunchImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setUpLaunchImage {
    UIImage *launchImage;
    if (iPhonePlus) {
        launchImage = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iPhone7) {
        launchImage = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
    } else if (iPhone5) {
        launchImage = [UIImage imageNamed:@"LaunchImage-700-568h@2x"];
    } else if (iPhone4) {
        launchImage = [UIImage imageNamed:@"LaunchImage-700@2x"];
    }
    self.launchView.image = launchImage;
}

- (void)setUpAdView {
    
}

@end
