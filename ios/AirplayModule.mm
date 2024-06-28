#import "AirplayModule.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVKit/AVKit.h>

@implementation AirplayModule
@synthesize bridge = _bridge;

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(startScan) {
    [[NSNotificationCenter defaultCenter]
    addObserver:self
    selector: @selector(routeChanged:)
    name:AVAudioSessionRouteChangeNotification
    object:[AVAudioSession sharedInstance]];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self sendInformations];
    });
}

RCT_EXPORT_METHOD(disconnect) {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

RCT_EXPORT_METHOD(openMenu)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    AVRoutePickerView *routePickerView = [[AVRoutePickerView alloc] init];
    for (UIView *subview in routePickerView.subviews) {
      if ([subview isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)subview;
        [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        break;
      }
    }
  });
}

- (void)routeChanged:(NSNotification *)sender {
    [self sendInformations];
}

- (void)sendInformations {
    AVAudioSessionRouteDescription *currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    NSString *deviceName;
    NSString *portType;
    BOOL isAirPlayPlaying = NO;
    BOOL isMirroring = NO;
    BOOL isHeadphones = NO;
    NSMutableArray *devices = [NSMutableArray array];
    for (AVAudioSessionPortDescription * output in currentRoute.outputs) {
        isHeadphones = NO;
        if([output.portType isEqualToString:AVAudioSessionPortAirPlay]) {
            isAirPlayPlaying = YES;
        }
        else if ([output.portType isEqualToString:AVAudioSessionPortBluetoothA2DP]) {
            isAirPlayPlaying = YES;
            isHeadphones = YES;
        }
        deviceName = output.portName;
        portType = output.portType;
        NSDictionary *device = @{
          @"deviceName": deviceName,
          @"portType" : portType,
          @"isHeadphones": @(isHeadphones)
        };
        [devices addObject: device];
    }
    if (isAirPlayPlaying) {
        isMirroring = ([[UIScreen screens] count] >= 2);
    }
    [self sendEventWithName:@"deviceConnected" body:@{
      @"devices": devices,
      @"connected": @(isAirPlayPlaying),
      @"mirroring": @(isMirroring),
    }];
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"deviceConnected"];
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

@end
