//
//  BDJCheckPicktureController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/7/2.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJCheckPicktureController.h"
#import <FLAnimatedImageView+WebCache.h>
#import "BDJEssenceTopicItem.h"

@interface BDJCheckPicktureController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) FLAnimatedImageView *imageView;

@end

@implementation BDJCheckPicktureController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpImageView];
    
    //实现点击返回
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backButtonClick:)]];
    
    CGFloat currentScale = self.scrollView.YY_width /self.item.width;
    if (currentScale < 1) {
        self.scrollView.maximumZoomScale = 1/currentScale;
        self.scrollView.delegate = self;
    }
}
- (void)setUpImageView {
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    imageView.YY_width = self.scrollView.YY_width;
    imageView.YY_height = self.item.height * imageView.YY_width / self.item.width;
    imageView.YY_x = 0;
    if (imageView.YY_height > self.scrollView.YY_height) {
        imageView.YY_y = 0;
        self.scrollView.contentSize = CGSizeMake(0, imageView.YY_height);
    } else {
        imageView.YY_centerY = self.scrollView.YY_height * 0.5;
    }
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.item.image1]];
}

- (IBAction)saveButtonClick:(UIButton *)sender {
}

- (IBAction)backButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma makr - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
