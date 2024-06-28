import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import AirPlay from 'react-native-airplay-module';

export default function App() {
  React.useEffect(() => {
    AirPlay.startScan();

    AirPlay.AirPlayListener.addListener('deviceConnected', ({ devices }) => {
      console.log(devices);
    });

    return () => {
      AirPlay.disconnect();
    };
  }, []);

  const openMenu = () => {
    AirPlay.openMenu();
  };

  return (
    <View style={styles.container}>
      <Text onPress={openMenu}>Open AirPlay</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
