//
//  iPhoneAudioAppDelegate.h
//  iPhoneAudio
//
//  Created by JJ WEI on 11-05-06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iPhoneAudioViewController;

@interface iPhoneAudioAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet iPhoneAudioViewController *viewController;

@end
