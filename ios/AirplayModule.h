
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNAirplayModuleSpec.h"

@interface AirplayModule : NSObject <NativeAirplayModuleSpec>
#else
#import <React/RCTBridgeModule.h>

@interface AirplayModule : NSObject <RCTBridgeModule>
#endif

@end
