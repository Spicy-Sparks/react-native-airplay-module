import { NativeModules, NativeEventEmitter, Platform } from 'react-native';

const AirplayModule = NativeModules.AirplayModule;

const AirPlayListener = new NativeEventEmitter(AirplayModule);

const startScan = function () {
  if (Platform.OS !== 'ios' || !AirplayModule) return;
  return AirplayModule.startScan();
};

const disconnect = function () {
  if (Platform.OS !== 'ios' || !AirplayModule) return;
  return AirplayModule.disconnect();
};

const openMenu = function () {
  if (Platform.OS !== 'ios' || !AirplayModule) return;
  return AirplayModule.openMenu();
};

export default {
  AirPlayListener,
  startScan,
  disconnect,
  openMenu,
};
