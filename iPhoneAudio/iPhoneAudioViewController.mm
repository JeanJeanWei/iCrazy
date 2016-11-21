//
//  iPhoneAudioViewController.m
//  iPhoneAudio
//
//  Created by JJ WEI on 11-05-06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "iPhoneAudioViewController.h"

@implementation iPhoneAudioViewController
@synthesize audioController;
@synthesize accel;
@synthesize fire0, img, v1, shakeMe, bg0;


#pragma mark -
#pragma switch views more apps, info, and sound effects

-(IBAction) moreApps {
    NSString *iTunesLink = @"itms-apps://itunes.com/icewhale";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    
}

-(IBAction) infoPressed {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    
    [v1 removeFromSuperview];
    //  [self.view addSubview:v4];
    
    [UIView commitAnimations]; 
    //   [scrollView setScrollEnabled:YES];
    //  [scrollView setContentSize:CGSizeMake(480, 900)];
}

-(IBAction) backPressed {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    
    // [v4 removeFromSuperview];
    [self.view addSubview:v1];
    
    [UIView commitAnimations]; 
}


-(void) gyroRotateOutput {
    motionManager = [[CMMotionManager alloc] init]; 
    
    if (motionManager.gyroAvailable) {
   //     NSLog(@"gyroAvailable");
        //   motionManager.gyroUpdateInterval = 1.0/60.0;
        
        motionManager.gyroUpdateInterval = 5.0/60.0;
 
        [motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
                                   withHandler: ^(CMGyroData *gyroData, NSError *error)
         {
            // CMRotationRate rotate = gyroData.rotationRate;
             [self iGyro];
             
         /*    
             NSLog(@"rotation rate = [%f, %f, %f]", rotate.x, rotate.y, rotate.z);
             
             double x = (sqrt(sqrt(pow(rotate.x,2))*10))*80;
             double y = (sqrt(sqrt(pow(rotate.y,2))*10))*80;;
             double z = (sqrt(sqrt(pow(rotate.z,2))*10))*80;;
             double t = x+y+z;
           //  NSLog(@"++++t =  [%f]", t);
             audioController.f = t;
             
             [audioController changeFreq]; */
             // 
             // self.audioController = nil;
           //  [audioController stopAUGraph]; 
           //  [audioController initializeAUGraph];
           //  [audioController startAUGraph]; 

         }];
        
    } else {
  //      NSLog(@"No gyroscope on device.");
        gyro = 1;
        [motionManager release];
        accel = [UIAccelerometer sharedAccelerometer];
        accel.delegate = self;
        accel.updateInterval = 5.0f/60.0f;
    }
 
}

-(void) iGyro {
    motionManager.gyroUpdateInterval = 5.0/60.0;
    
    [motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
                               withHandler: ^(CMGyroData *gyroData, NSError *error)
     {
         CMRotationRate rotate = gyroData.rotationRate;
         
         
   //      NSLog(@"rotation rate = [%f, %f, %f]", rotate.x, rotate.y, rotate.z);
         
         double x = (sqrt(sqrt(pow(rotate.x,2))*10))*80;
         double y = (sqrt(sqrt(pow(rotate.y,2))*10))*80;;
         double z = (sqrt(sqrt(pow(rotate.z,2))*10))*80;;
         double t = x+y+z;
      //     NSLog(@"Gyro++++t =  [%f]", t);
         if (t>550) {
             audioController.f = t;
             if (isOn == 0) {
                 isOn = 1;
                 [audioController initializeAUGraph];
                 [audioController startAUGraph]; 
             } 
             [audioController changeFreq];
         } else {
             isOn = 0;
             [audioController stopAUGraph];
    //         NSLog(@"t<550 Gyro++++t =  [%f]", t);
         }

         
       //  audioController.f = t;
         
       //  [audioController changeFreq];
     }
     ];
}

- (void)accelerometer:(UIAccelerometer *)acel 
        didAccelerate:(UIAcceleration *)acceleration {
    
    double x = (sqrt(sqrt(pow(acceleration.x,2))*30))*80;
    double y = (sqrt(sqrt(pow(acceleration.y,2))*30))*80;
    double z = (sqrt(sqrt(pow(acceleration.z,2))*30))*80;
    double t = x+y+z;
    if (t>750) {
        audioController.f = t;
        if (isOn == 0) {
            isOn = 1;
            [audioController initializeAUGraph];
            [audioController startAUGraph]; 
        } 
        [audioController changeFreq];
    } else {
        isOn = 0;
        [audioController stopAUGraph];
    }
 //     NSLog(@"++++f =  [%f]", audioController.f);
 //   NSLog(@"Mx: %g, My: %g, Mz:%g", acceleration.x, acceleration.y, acceleration.z);
    
}

     
-(void) stopPressed {
    if (gyro == 1) {
        accel.delegate = nil;
        
    } else {
        [motionManager stopGyroUpdates];
        
    }
    isOn = 0;
    [audioController stopAUGraph];
}

-(void) startPressed{
    if (isInit == 0) {
        [self gyroRotateOutput];
    } else {
        if (gyro == 1) {
            accel.delegate = self;
        } else {
            //[motionManager startGyroUpdates];
            [self iGyro];
        }
    }
}

-(IBAction) fireTriggered {
    if (isFired == 0) {
        isFired = 1;
        [shakeMe setAlpha:1];
       // NSString *b =[[NSString alloc] initWithFormat:@"%@", @"aaa"];
        img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"stop" ofType:@"png" inDirectory:nil]];
        [fire0 setImage:img forState:UIControlStateNormal];
   //     [b release];
        [img release];
        
        img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg2" ofType:@"png" inDirectory:nil]];
        bg0.image = img;
        [img release];
        
        [self startPressed];
    } else {
        isFired = 0;
        [shakeMe setAlpha:0];
        img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"start" ofType:@"png" inDirectory:nil]];
        [fire0 setImage:img forState:UIControlStateNormal];
        [img release];

        img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BG1" ofType:@"png" inDirectory:nil]];
        bg0.image = img;
        [img release];
        
        [self stopPressed];
    }
}

- (void)dealloc
{
    [bg0 release];
    [shakeMe release];
    [fire0 release];
    [img release];
    [v1 release];
    
    accel.delegate = nil;
    [accel release];
    
    [audioController stopAUGraph];
    [audioController release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, 750)];
    [self.view addSubview:v1];
  //  NSLog(@"Int gyro%i",gyro);
//    NSLog(@"IntisFired%i",isFired);
    isFired = 1;
    [self fireTriggered];
    
//   NSLog(@"View didload");

    [super viewDidLoad];
}


- (void)viewDidUnload
{
    self.bg0 = nil;
    self.shakeMe = nil;
    self.v1 = nil;
    self.accel = nil;
    self.fire0 = nil;
    self.img = nil;
    [super viewDidUnload];
       // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
