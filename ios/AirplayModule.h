#import <React/RCTEventEmitter.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import "RNAirplayModuleSpec.h"

@interface AirplayModule : RCTEventEmitter <NativeAirplayModuleSpec>
#else
#import <React/RCTBridgeModule.h>

@interface AirplayModule : RCTEventEmitter <RCTBridgeModule>
#endif

@end