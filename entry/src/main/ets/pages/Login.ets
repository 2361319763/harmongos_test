import { BaseConstants, setJoaData, toIndex, UserConstants } from 'jbase'

@Entry
@Component
struct Main {

  @State username: string = ''
  @State password: string = ''
  @State passwordState: boolean = false

  build() {
    Column() {
      Image($r('app.media.background')).width('100%').height(180).position({ top: 0 })
      Image($r('app.media.logo')).width(80).height(80)
      Text('欢迎登录JOA').fontSize(26).fontWeight(FontWeight.Bold).margin({ top: 24, bottom: 40 })
      TextInput({ placeholder: '请输入用户名', text: this.username })
        .cancelButton({ style: CancelButtonStyle.INPUT })
        .onChange((value: string) => {
          this.username = value
        })
        .inputStyle()
        .fontSize(16)
      TextInput({ placeholder: '请输入密码', text: this.password })
        .type(InputType.Password)
        .showPasswordIcon(true)
        .cancelButton({ style: CancelButtonStyle.INPUT })
        .onChange((value: string) => {
          this.password = value
        })
        .showPassword(this.passwordState)
        .onSecurityStateChange(((isShowPassword: boolean) => {
          // 更新密码显示状态
          this.passwordState = isShowPassword
        }))
        .inputStyle()
        .fontSize(16)
      Button('登 录')
        .onClick(() => {
          setJoaData(UserConstants.TOKEN_KEY, 'admin')
          toIndex()
        })
        .fontSize(16)
        .margin({ top: 24, bottom: 24, left: 60, right: 60 })
        .height(45)
        .width(300)
        .backgroundColor($r('app.color.main_color'))
        .borderRadius(BaseConstants.BORDER_RADIUS)

      Text('没有账号？立即注册')
        .fontSize(15)
        .fontColor($r('app.color.main_color'))
        .width(BaseConstants.FULL_WIDTH)
        .textAlign(TextAlign.Center)
        .margin({ top: 24 })

      // 底部版权
      Text('版权所有 © 2025 476743842@qq.com')
        .fontSize(12)
        .fontColor($r('app.color.gl_999'))
        .width(BaseConstants.FULL_WIDTH)
        .textAlign(TextAlign.Center)
        .position({ bottom: 24 })

    }
    .backgroundColor($r('app.color.white'))
    .width(BaseConstants.FULL_WIDTH)
    .height(BaseConstants.FULL_HEIGHT)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }

  @Styles inputStyle() {
    .margin({ bottom: 18 })
    .width(300)
    .backgroundColor($r('app.color.back_color'))
    .borderRadius(BaseConstants.BORDER_RADIUS)
    .padding({ left: 20, right: 20, top: 14, bottom: 14 })
  }
}