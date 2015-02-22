//
//  CameraViewController.m
//  CameraWithAVFoundation
//
//  Created by Gabriel Alvarado on 4/16/14.
//  Copyright (c) 2014 Gabriel Alvarado. All rights reserved.
//

#import "CameraViewController.h"
#import "CameraSessionView.h"

@interface CameraViewController () <CACameraSessionDelegate>

@property (nonatomic, strong) CameraSessionView *cameraView;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (IBAction)launchCamera:(id)sender {
    
    //Set white status bar
    [self setNeedsStatusBarAppearanceUpdate];
    
    //If previous intance of a '_cameraView' object exists, remove it's preview layer
    if (_cameraView) [_cameraView removeFromSuperview];
    _cameraView = nil;
    
    //Instantiate the camera view & assign its frame
    _cameraView = [[CameraSessionView alloc] initWithFrame:self.view.frame];
    
    if (_cameraView) {
        
        //Set the delegate for the camera view
        _cameraView.delegate = self;
        
        //____________________________Example Customization____________________________
        //[cameraView setTopBarColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha: 0.64]];
        //[cameraView hideFlashButton]; //On iPad flash is not present, hence it wont appear.
        //[cameraView hideCameraToogleButton];
        //[cameraView hideDismissButton];
        
        //[self.view insertSubview:cameraView atIndex:0];
        [self.view addSubview:_cameraView];
    }
    
}

-(void)didCaptureImage:(UIImage *)image {
    NSLog(@"CAPTURED IMAGE");
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [self.cameraView removeFromSuperview];
}

-(void)didCaptureImageWithData:(NSData *)imageData {
    NSLog(@"CAPTURED IMAGE DATA");
    //UIImage *image = [[UIImage alloc] initWithData:imageData];
    //UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    //[self.cameraView removeFromSuperview];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    //Show error alert if image could not be saved
    if (error) [[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
