//
//  COLCamera.m
//  parking
//
//  Created by Robert Xu on 2017/6/2.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLCamera.h"

@interface COLCamera () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *picker;
@property (weak, nonatomic) UIViewController<COLCameraDelegate> *delegate;

@end

@implementation COLCamera

/* CLass Method */
//是否支持相机
+ (BOOL)isSupportCamera {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
//是否支持相册
+ (BOOL)isSupportPhotoLibrary {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}
//是否支持图库
+ (BOOL)isSupportSavedPhotosAlbum {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}

+ (COLCamera *)instanceWithDelegate:(UIViewController<COLCameraDelegate> *)delegate {
    COLCamera *camera = [[COLCamera alloc] initWithDelegate:delegate];
    return camera;
}

- (COLCamera *)initWithDelegate:(UIViewController<COLCameraDelegate> *)delegate {
    if (self = [super init]) {
        _picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
        _picker.allowsEditing = YES;
        _delegate = delegate;
    }
    return self;
}

- (void)openCameraWithResult:(ResultBlock)result {
    _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    if([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusRestricted || [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusDenied){
        NSString *errorMessage = @"应用相机权限受限,请在设置中启用";
        result(NO, errorMessage);
        return;
    }
    
    if (self.delegate) {
        result(YES, @"");
        [self.delegate presentViewController:_picker animated:YES completion:nil];
    }
}

- (void)openPhotoLibraryWithResult:(ResultBlock)result {
    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if (self.delegate) {
        result(YES, @"");
        [self.delegate presentViewController:_picker animated:YES completion:nil];
    }
}

- (void)openSavedPhotosAlbumWithResult:(ResultBlock)result {
    _picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if (self.delegate) {
        result(YES, @"");
        [self.delegate presentViewController:_picker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [_picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cameraReturnImage:)]) {
        [self.delegate cameraReturnImage:image];
    }
}

@end
