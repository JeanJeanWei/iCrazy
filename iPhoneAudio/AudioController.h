//
//  AudioController.h
//  iPhoneAudio
//
//  Created by JJ WEI on 11-05-06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AudioToolbox/AudioToolbox.h>
#import "CAStreamBasicDescription.h"
//float freq;
@interface AudioController : NSObject {
    
    // Audio Graph Members
	AUGraph   mGraph;
	AudioUnit mMixer;
    
	// Audio Stream Descriptions
	CAStreamBasicDescription outputCASBD;	
    
	// Sine Wave Phase marker
	double sinPhase;
    float f;
//    float freq;
}

@property (nonatomic, assign) float f;
//@property (nonatomic, assign) float freq;
- (void)initializeAUGraph;
- (void)startAUGraph;
- (void)stopAUGraph;
- (void)changeFreq;
@end
