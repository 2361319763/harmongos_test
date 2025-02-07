import { BaseConstants, MainButton, CoreUtils, UserConstants, ContextUtils, FullLoading } from 'jbase'
import { getCodeImg, login, LoginParams } from '../api/Login'
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
  // 验证码图片
  @State codeImg: string = ''
  @State codeValue: string = ''
  @State loginAgree: boolean = false
  @State pageLoading: boolean = false
  // 是否开启验证码
  @State captchaEnabled: boolean = true
  @State uuid: string = ''

  aboutToAppear(): void {
    this.loadCodeImg()
  }

  // 加载图片验证码
  loadCodeImg(): void {
    this.pageLoading = true
    getCodeImg().then((res) => {
      this.codeImg = 'data:image/gif;base64,' + res['img']
      this.captchaEnabled = res['captchaEnabled']
      this.uuid = res['uuid']
    }).finally(() => this.pageLoading = false)
  }

  // 登录按钮点击事件
  loginBtnClick(): void {
    if (!this.username) {
      return CoreUtils.toast($r('app.string.pls_user'))
    }
    if (!this.password) {
      return CoreUtils.toast($r('app.string.pls_pass'))
    }
    if (this.captchaEnabled && !this.codeValue) {
      return CoreUtils.toast($r('app.string.pls_ver_code'))
    }
    if (!this.loginAgree) {
      return CoreUtils.toast($r('app.string.pls_read_tips'))
    }
    this.pageLoading = true
    login({
      username: this.username,
      password: this.password,
      code: this.codeValue,
      uuid: this.uuid
    } as LoginParams).then((res) => {
      ContextUtils.setToken(res['token'])
      CoreUtils.toast($r('app.string.login_success'))
      // 跳转首页
      CoreUtils.toIndex()
    }).finally(() => this.pageLoading = false)
  }

  build() {
    Column() {
      Image($r('app.media.background')).width('100%').height(180).position({ top: -10 })
      Image(AppConfig.loginLogo).width(80).height(80)
      Text(AppConfig.loginTitle).fontSize(26).fontWeight(FontWeight.Bold).margin({ top: 24, bottom: 40 })
      // 全屏加载组件
      FullLoading({ loading: this.pageLoading })

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

      if (this.captchaEnabled) {
        Row() {
          // 验证码输入框
          TextInput({ placeholder: $r('app.string.pls_ver_code'), text: this.codeValue })
            .type(InputType.Number)
            .cancelButton({ style: CancelButtonStyle.INPUT })
            .onChange((value: string) => {
              this.codeValue = value
            }).inputStyle().fontSize(16).width(200)
          Image(this.codeImg).width(90).height(48).margin({ bottom: 18 })
            .borderRadius(BaseConstants.BORDER_RADIUS)
            .onClick(() => this.loadCodeImg())
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .width(300)
      }

      // 登录按钮
      MainButton({ btnText: $r('app.string.login_text'), btnWidth: 300,
        onButtonClick: () => this.loginBtnClick() }).margin({ top: 24, bottom: 4 })

      // Text($r('app.string.no_user_tips'))
      //   .fontSize(15)
      //   .fontColor($r('app.color.main_color'))
      //   .width(BaseConstants.FULL_WIDTH)
      //   .textAlign(TextAlign.Center)
      //   .margin({ top: 24 })

      Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Start, wrap: FlexWrap.Wrap }) {
        Radio({ value: 'Radio1', group: 'radioGroup', indicatorType:RadioIndicatorType.TICK
        }).checked(this.loginAgree).height(18).width(18)
        Text($r('app.string.pls_read_agree')).fontSize(14).fontColor($r('app.color.gl_888'))
        Text($r('app.string.privacy_policy')).fontSize(14).fontColor($r('app.color.main_color'))
          .onClick((event) => {
            return false
          })
        Text($r('app.string.and')).fontSize(14).fontColor($r('app.color.gl_888'))
        Text($r('app.string.user_agreement')).fontSize(14).fontColor($r('app.color.main_color'))
          .onClick((event) => {
            return false
          })
      }
      .padding({ top: 10, bottom: 10 })
      .width(300)
      .onClick(() => {
        this.loginAgree = !this.loginAgree
      })

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