//
//  GameViewController.m
//  opencv-game-test
//
//  Created by User on 2020/02/21.
//  Copyright © 2020 User. All rights reserved.
//
#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#import <opencv2/core.hpp>
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
    
    cv::CascadeClassifier _cascade;
    double _scaleFactor;
    int _minNeighbors;
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
    
    // 特徴分類機を作成
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* resourceDirectoryPath = [bundle bundlePath];
    NSString* path = [resourceDirectoryPath stringByAppendingString: @"/haarcascade_eye.xml"];
    std::string filename = [path UTF8String];
    _cascade.load(filename);
    _scaleFactor = 1.1;
    _minNeighbors = 3;

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
    // グレースケール化
    cv::Mat image_copy;
    cvtColor(image, image_copy, cv::COLOR_BGR2BGRA);
    // invert image
    bitwise_not(image_copy, image_copy);
    //Convert BGR to BGRA (three channel to four channel)
    cv::Mat bgr;
    cvtColor(image_copy, bgr, cv::COLOR_BGR2BGRA);
    cvtColor(bgr, image, cv::COLOR_BGR2BGRA);
#endif
    
    // 「目」を検出する
    cv::Mat img;
    cvtColor(image, img, cv::COLOR_BGR2BGRA);
    std::vector<double> weights;
    std::vector<int> levels;
    std::vector<cv::Rect> detections;
    cv::Size min;
    cv::Size max;
    _cascade.detectMultiScale(img,             // image
                              detections,      // objects
                              levels,          // reject levels
                              weights,         // level weights
                              _scaleFactor,    // scale factor
                              _minNeighbors,   // min neighbors
                              0,               // flags
                              min,             // min size
                              max,             // max size
                              true);           // output reject levels
    
    // 「目」の位置に矩形を描画する
    for (auto object : detections) {
        cv::rectangle(img, object, cv::Scalar(255, 255, 255));
    }
    cvtColor(img, image, cv::COLOR_BGR2BGRA);
}
#endif

@end
