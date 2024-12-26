import { common } from '@kit.AbilityKit';
import { setDarkColorMode, setLightColorMode, setAutoColorMode, BaseConstants } from 'jbase';

@Builder
export function DarkSettingBuilder(name: string, param: Object) {
  DarkModeSetting()
}

@Component
export struct DarkModeSetting {
  @StorageProp('enableDarkMode') enableDarkMode: boolean = false;
  @StorageProp('isFollowSystemSetting') isFollowSystemSetting: boolean = true;
  @StorageProp('currentColorMode') currentColorMode: number = 0;
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;

  aboutToDisappear(): void {
    AppStorage.setOrCreate('enableDarkMode', this.enableDarkMode);
    AppStorage.setOrCreate('isFollowSystemSetting', this.isFollowSystemSetting);
  }

  build() {
    NavDestination() {
      Column() {
        Text('跟随系统设置开启后根据系统设置同步切换深/浅模式')
          .fontColor($r('app.color.gl_999'))
          .fontSize(14)
          .fontWeight(400)
          .lineHeight(30)
          .margin({ bottom: 16, top: 8 })
          .width('100%')
          .textAlign(TextAlign.Start)
        Row() {
          Text('跟随系统设置')
            .fontColor($r('app.color.black'))
            .fontSize(16)
            .fontWeight(500)
            .lineHeight(22)
          Toggle({ type: ToggleType.Switch, isOn: this.isFollowSystemSetting })
            .onChange((isOn: boolean) => {
              if (isOn) {
                this.isFollowSystemSetting = true;
                this.enableDarkMode = false;
                setAutoColorMode(this.context);
              } else {
                this.isFollowSystemSetting = false;
                if (this.enableDarkMode) {
                  setDarkColorMode(this.context);
                } else {
                  setLightColorMode(this.context);
                }
              }
            })
        }
        .width('100%')
        .height(56)
        .backgroundColor($r('app.color.white'))
        .margin({ bottom: 12 })
        .padding({ left: 14, right: 14 })
        .justifyContent(FlexAlign.SpaceBetween)
        .borderRadius(BaseConstants.BORDER_RADIUS)

        Row() {
          Text('深色模式')
            .fontColor($r('app.color.black'))
            .fontSize(16)
            .fontWeight(500)
            .lineHeight(22)
          Toggle({ type: ToggleType.Switch, isOn: this.enableDarkMode })
            .onChange((isOn: boolean) => {
              this.enableDarkMode = isOn;
              if (isOn) {
                this.isFollowSystemSetting = false;
                setDarkColorMode(this.context);
              } else if (!this.isFollowSystemSetting) {
                setLightColorMode(this.context);
              }
            })
        }
        .width('100%')
        .height(56)
        .backgroundColor($r('app.color.white'))
        .padding({ left: 14, right: 14 })
        .justifyContent(FlexAlign.SpaceBetween)
        .borderRadius(BaseConstants.BORDER_RADIUS)
      }
      .padding({ left: 16, right: 16 })
    }
    .title('主题设置')
    .backgroundColor($r('app.color.back_color'))
  }
}