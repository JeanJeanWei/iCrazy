//
//  AudioController.h
//  iPhoneAudio


#import <Foundation/Foundation.h>

#import <AudioToolbox/AudioToolbox.h>
#import "CAStreamBasicDescription.h"


@interface AudioController : NSObject {
    
    // Audio Graph Members
	AUGraph   mGraph;
	AudioUnit mMixer;
    
	// Audio Stream Descriptions
	CAStreamBasicDescription outputCASBD;	
    
	// Sine Wave Phase marker
	double sinPhase;
    float ffff;
    
}
@property (nonatomic, assign) float ffff;
- (void)initializeAUGraph;
- (void)startAUGraph;
- (void)stopAUGraph;


@end
