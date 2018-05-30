//
//  COLCamera.h
//  parking
//
//  Created by Robert Xu on 2017/6/2.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void (^ResultBlock)(BOOL success,NSString *errorMessage);

@protocol COLCameraDelegate <NSObject>

- (void)cameraReturnImage:(UIImage *)image;

@end

@interface COLCamera : NSObject

//是否支持相机
+ (BOOL)isSupportCamera;
//是否支持相册
+ (BOOL)isSupportPhotoLibrary;
//是否支持图库
+ (BOOL)isSupportSavedPhotosAlbum;

+ (COLCamera *)instanceWithDelegate:(UIViewController<COLCameraDelegate> *)delegate;

- (void)openCameraWithResult:(ResultBlock)result;

- (void)openPhotoLibraryWithResult:(ResultBlock)result;

- (void)openSavedPhotosAlbumWithResult:(ResultBlock)result;

@end
