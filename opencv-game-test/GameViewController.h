//
//  GameViewController.h
//  opencv-game-test
//
//  Created by User on 2020/02/21.
//  Copyright © 2020 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import "Renderer.h"

// Our iOS view controller
@interface GameViewController : UIViewController <CvVideoCameraDelegate>

@end
