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
    
    
    //实现点击返回
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backButtonClick:)]];
    self.scrollView.delegate = self;
    CGFloat currentScale = self.scrollView.YY_width /self.item.width;
    if (currentScale < 1) {
        self.scrollView.maximumZoomScale = 1/currentScale;
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
#pragma mark - IBAction
- (IBAction)saveButtonClick:(UIButton *)sender {
    //检查相册权限,若未请求过，则请求权限
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusDenied) {
            [SVProgressHUD setMaximumDismissTimeInterval:5.0];
            [SVProgressHUD showErrorWithStatus:@"无法访问您的相册，请在\"设置\"-\"隐私\"中开启权限后再试"];
        } else if (status == PHAuthorizationStatusAuthorized) {
            [self savePhotoToAlbum];
        } else if (status == PHAuthorizationStatusRestricted) {
            [SVProgressHUD setMaximumDismissTimeInterval:3.0];
            [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
        }
    }];
    
    
}

- (IBAction)backButtonClick:(UIButton *)sender {
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:NO completion:nil];
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

#pragma mark - 处理图片保存功能

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

/**
 保存图片到相册
 */
- (void)savePhotoToAlbum {
    //保存图片到相机胶卷
    NSError *error = nil;
    __block NSString *assetID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    
    if (error) {
        [SVProgressHUD setMaximumDismissTimeInterval:2.0];
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        return;
    } else {
        [SVProgressHUD setMaximumDismissTimeInterval:1.0];
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        //获得自定义相册
        PHAssetCollection *collection = [self getTheCollection];
        //取得照片对象
        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
        //将图片与自定义相册关联起来
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
            [request insertAssets:assets atIndexes:[NSIndexSet indexSetWithIndex:0]];
        } error:nil];
    }
}

@end
