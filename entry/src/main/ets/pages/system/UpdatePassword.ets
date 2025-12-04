import { BaseConstants, MainButton, PageTitleBuilder } from "base"

@Builder
export function UpdatePasswordBuilder(name: string, param: Object) {
  UpdatePassword()
}

// 密码修改页面
@Component
export struct UpdatePassword {
  @State private navPathStack: NavPathStack = new NavPathStack()
  @State oldPassword: string = ''
  @State newPassword: string = ''
  @State confirmPassword: string = ''
  @State oldPasswordShow: boolean = false
  @State newPasswordShow: boolean = false
  @State confirmPasswordShow: boolean = false

  @Builder LabelText(name: string | Resource) {
    Text(name)
      .fontSize(16)
      .fontColor($r('app.color.black'))
      .width(110)
      .padding({ right: 10 })
  }

  build() {
    NavDestination() {
      Column() {
        Column() {
          Flex({ alignItems: ItemAlign.Center }) {
            // 旧密码
            this.LabelText($r('app.string.old_pass'))
            TextInput({
              placeholder: $r('app.string.pls_old_pass'),
              text: this.oldPassword
            })
              .type(this.oldPasswordShow ? InputType.Normal : InputType.Password)
              .showPasswordIcon(true)
              .onChange((value: string) => {
                this.oldPassword = value
              })
              .showPassword(this.oldPasswordShow)
              .onSecurityStateChange((isShowPassword: boolean) => {
                this.oldPasswordShow = isShowPassword
              })
              .inputStyle().fontSize(16)
              .height(48).flexGrow(1)
          }.margin({ bottom: 20 })

          // 新密码
          Flex({ alignItems: ItemAlign.Center }) {
            this.LabelText($r('app.string.new_pass'))
            TextInput({
              placeholder: $r('app.string.pls_new_pass'),
              text: this.newPassword
            })
              .type(this.newPasswordShow ? InputType.Normal : InputType.Password)
              .showPasswordIcon(true)
              .onChange((value: string) => {
                this.newPassword = value
              })
              .showPassword(this.newPasswordShow)
              .onSecurityStateChange((isShowPassword: boolean) => {
                this.newPasswordShow = isShowPassword
              })
              .inputStyle().fontSize(16)
              .height(48).flexGrow(1)
          }.margin({ bottom: 20 })

          // 确认密码
          Flex({ alignItems: ItemAlign.Center }) {
            this.LabelText($r('app.string.confirm_pass'))
            TextInput({
              placeholder: $r('app.string.pls_confirm_pass'),
              text: this.confirmPassword
            })
              .type(this.confirmPasswordShow ? InputType.Normal : InputType.Password)
              .showPasswordIcon(true)
              .onChange((value: string) => {
                this.confirmPassword = value
              })
              .showPassword(this.confirmPasswordShow)
              .onSecurityStateChange((isShowPassword: boolean) => {
                this.confirmPasswordShow = isShowPassword
              })
              .inputStyle().fontSize(16)
              .height(48).flexGrow(1)
          }.margin({ bottom: 20 })

          // 密码规则提示
          Column() {
            Text($r('app.string.pass_tips'))
              .fontSize(14)
              .fontColor($r('app.color.gl_999'))
              .margin({ bottom: 4 })
            Text($r('app.string.pass_rule1'))
              .fontSize(14)
              .fontColor($r('app.color.gl_999'))
              .margin({ bottom: 4 })
            Text($r('app.string.pass_rule2'))
              .fontSize(14)
              .fontColor($r('app.color.gl_999'))
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .margin({ top: 10 })
        }
        .padding(BaseConstants.MODULE_PADDING + 10)
        .borderRadius(BaseConstants.BORDER_RADIUS)
        .backgroundColor($r('app.color.white'))
        .width(BaseConstants.FULL_WIDTH)

        // 确认修改按钮
        MainButton({ 
          btnText: $r('app.string.confirm_change'),
          btnWidth: BaseConstants.FULL_WIDTH,
          onButtonClick: () => {
            // TODO: 实现密码修改逻辑
          }
        }).margin({ top: 20 })
      }
      .padding({ top: 16, left: 20, right: 20 })
      .width(BaseConstants.FULL_WIDTH)
    }
    .title(PageTitleBuilder($r('app.string.change_pass')))
    .backgroundColor($r('app.color.back_color'))
  }

  @Styles inputStyle() {
    .backgroundColor($r('app.color.back_color'))
    .borderRadius(BaseConstants.BORDER_RADIUS)
    .padding({ left: 16, right: 16 })
  }
}