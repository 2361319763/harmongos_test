import { BaseConstants, MainButton, CoreUtils, UserConstants } from 'jbase'
import { getCodeImg } from '../api/Login'
import { AppConfig } from '../config/Index'

/**
 * 登录页面
 */
@Entry
@Component
struct Main {

  @State username: string = ''
  @State password: string = ''
  @State passwordState: boolean = false

  build() {
    Column() {
      Image($r('app.media.background')).width('100%').height(180).position({ top: 0 })
      Image(AppConfig.loginLogo).width(80).height(80)
      Text(AppConfig.loginTitle).fontSize(26).fontWeight(FontWeight.Bold).margin({ top: 24, bottom: 40 })

      // 账号输入框
      TextInput({ placeholder: $r('app.string.pls_user'), text: this.username })
        .cancelButton({ style: CancelButtonStyle.INPUT })
        .onChange((value: string) => {
          this.username = value
        })
        .inputStyle()
        .fontSize(16)

      // 密码输入框
      TextInput({ placeholder: $r('app.string.pls_pass'), text: this.password })
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

      // 登录按钮
      MainButton({ btnText: $r('app.string.login_text'), btnWidth: 300, onButtonClick: () => {
        // setJoaData(UserConstants.TOKEN_KEY, 'admin')
        // toIndex()
        getCodeImg().then((res) => {
          console.log(res['img']);
        })
      }}).margin({ top: 24, bottom: 24 })

      Text($r('app.string.no_user_tips'))
        .fontSize(15)
        .fontColor($r('app.color.main_color'))
        .width(BaseConstants.FULL_WIDTH)
        .textAlign(TextAlign.Center)
        .margin({ top: 24 })

      // 底部版权
      Text(AppConfig.copyRight)
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