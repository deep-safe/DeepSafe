import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.deepsafe.app',
  appName: 'DeepSafe',
  webDir: 'out',
  plugins: {
    LocalNotifications: {
      smallIcon: "ic_stat_icon_config_sample",
      iconColor: "#06b6d4",
      sound: "beep.wav",
    },
  },
};

export default config;
