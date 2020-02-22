//
//  GameViewController.m
//  opencv-game-test
//
//  Created by User on 2020/02/21.
//  Copyright © 2020 User. All rights reserved.
//
#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc.hpp>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/imgproc/types_c.h>
#import <opencv2/videoio/cap_ios.h>
#endif

#import "GameViewController.h"
#import "Renderer.h"

@implementation GameViewController
{
    MTKView *_view;

    Renderer *_renderer;
    
    CvVideoCamera* _videoCamera;
    
    UIImage* _videoImage;
    UIImageView* _videoImageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _view = (MTKView *)self.view;
#if 0
    // 通常の画像を表示する
    UIImage *image = [UIImage imageNamed:@"image.png"];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setCenter:CGPointMake(image.size.width/2, image.size.height/2)];
    [_view addSubview:imageView];
    
    // OpenCVでグレースケール化して表示する
    cv::Mat srcMat;
    UIImageToMat(image, srcMat);
    cv::Mat grayMat;
    cv::cvtColor(srcMat, grayMat, CV_BGR2GRAY);
    UIImage* grayImage = MatToUIImage(grayMat);
    UIImageView* grayImageView = [[UIImageView alloc] initWithImage:grayImage];
    [grayImageView setCenter:CGPointMake(grayImage.size.width/2, grayImage.size.height*1.5)];
    [_view addSubview:grayImageView];
#endif

    // カメラ画像転送用のビューを作る
    _videoImage = [UIImage imageNamed:@"video_frame.png"];
    _videoImageView = [[UIImageView alloc] initWithImage:_videoImage];
    [_videoImageView setCenter:CGPointMake(_videoImage.size.width/2, _videoImage.size.height/2)];
    [_view addSubview:_videoImageView];
    
    // ビデオカメラを追加
    _videoCamera = [[CvVideoCamera alloc] initWithParentView:_videoImageView];
    _videoCamera.delegate = self;
    _videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    _videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    _videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    _videoCamera.defaultFPS = 30;
    _videoCamera.grayscaleMode = NO;
    [_videoCamera start];
    
//    _view.device = MTLCreateSystemDefaultDevice();
//    _view.backgroundColor = UIColor.blackColor;
//
//    if(!_view.device)
//    {
//        NSLog(@"Metal is not supported on this device");
//        self.view = [[UIView alloc] initWithFrame:self.view.frame];
//        return;
//    }
//
//    _renderer = [[Renderer alloc] initWithMetalKitView:_view];
//
//    [_renderer mtkView:_view drawableSizeWillChange:_view.bounds.size];
//
//    _view.delegate = _renderer;
}

#ifdef __cplusplus
- (void)processImage:(cv::Mat&)image;
{
    // Do some OpenCV stuff with the image
#if 0
    cv::Mat image_copy;
    cvtColor(image, image_copy, cv::COLOR_BGR2BGRA);
    // invert image
    bitwise_not(image_copy, image_copy);
    //Convert BGR to BGRA (three channel to four channel)
    cv::Mat bgr;
    cvtColor(image_copy, bgr, cv::COLOR_BGR2BGRA);
    cvtColor(bgr, image, cv::COLOR_BGR2BGRA);
#endif
}
#endif

@end
