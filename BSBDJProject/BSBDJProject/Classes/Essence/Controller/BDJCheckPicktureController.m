//
//  BDJCheckPicktureController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/7/2.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJCheckPicktureController.h"
#import <FLAnimatedImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <Photos/Photos.h>
#import "BDJEssenceTopicItem.h"

@interface BDJCheckPicktureController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) FLAnimatedImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation BDJCheckPicktureController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpImageView];
    [SVProgressHUD setMaximumDismissTimeInterval:2.0];
    
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
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.item.image1] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.saveButton.enabled = YES;
    }];
}

- (IBAction)saveButtonClick:(UIButton *)sender {
    
    //保存图片到相机胶卷
    NSError *error = nil;
    __block NSString *assetID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    
    //取得照片对象
    PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil].firstObject;
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        return;
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        //获得自定义相册
        PHAssetCollection *collection = [self getTheCollection];
        //将图片与自定义相册关联起来
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
            [request insertAssets:@[asset] atIndexes:[NSIndexSet indexSetWithIndex:0]];
        } error:nil];
    }
}

- (IBAction)backButtonClick:(UIButton *)sender {
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:NO completion:nil];
}


#pragma makr - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (PHAssetCollection *)getTheCollection {
    //查找是否已有与项目名同名的自定义相册
    NSString *collectionTitle = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    PHFetchResult *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        if([collection.localizedTitle isEqualToString:collectionTitle]) {
            return collection;
        }
    }
    //没有找到自定义相册
    __block NSString *collectionID = nil;
    //创建一个与项目名同名的相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        collectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:collectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    //根据唯一标识符获得刚才创建的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionID] options:nil].firstObject;
}

@end
