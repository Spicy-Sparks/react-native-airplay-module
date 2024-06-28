# react-native-mediastore

React Native Google One Tip Signin

## Installation

```sh
npm install react-native-airplay-module
```

```sh
yarn add react-native-airplay-module
```

## Usage

```js
import AirPlay from 'react-native-airplay-module'

useEffect(() => {
   AirPlay.startScan()

   AirPlay.AirPlayListener.addListener('deviceConnected', ({ devices }) => {
      console.log(devices)
   })

   return () => {
      AirPlay.disconnect()
   }
}, [])

const openMenu = () => {
   AirPlay.openMenu()
}

```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
