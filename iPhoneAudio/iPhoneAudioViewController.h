//
//  iPhoneAudioViewController.h
//  iPhoneAudio
//
//  Created by JJ WEI on 11-05-06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioController.h"
#import <CoreMotion/CoreMotion.h>


@interface iPhoneAudioViewController : UIViewController <UIAccelerometerDelegate>{
    int gyro;
    int isOn;
    int isFired;
    int isInit;
    
    IBOutlet AudioController *audioController;
    CMMotionManager *motionManager;
    CMAttitude *referenceAttitude;
    
    UIAccelerometer *accel;
    
    IBOutlet UIButton *shakeMe;
    IBOutlet UIButton *fire0;
    UIImage *img;
    IBOutlet UIView *v1;
    IBOutlet UIImageView *bg0;
    
    IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, retain) IBOutlet UIButton *shakeMe;
@property (nonatomic, retain) IBOutlet UIButton *fire0;
@property(nonatomic, retain) IBOutlet UIImage *img;
@property (nonatomic, retain) IBOutlet UIView *v1;
@property (nonatomic, retain) IBOutlet UIImageView *bg0;

@property (readonly, nonatomic) AudioController *audioController;
@property (retain, nonatomic)  UIAccelerometer *accel;
-(void) gyroRotateOutput;
-(void) iGyro;
-(void) stopPressed;
-(void) startPressed;

-(IBAction) fireTriggered;
-(IBAction) moreApps;
-(IBAction) infoPressed;
-(IBAction) backPressed;



@end
