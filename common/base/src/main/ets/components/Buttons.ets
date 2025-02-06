import { BaseConstants } from "../constants/BaseConstants"

/**
 * 主题色按钮的Button
 */
@Component
export struct MainButton {
  @Prop btnText: Resource | string
  @Prop fontSize: number = 16
  @Prop btnHeight: number = 45
  @Prop btnWidth: number | string = '100%'
  // 按钮点击事件
  onButtonClick?: (event: ClickEvent) => void
  build() {
    Button(this.btnText, { type: ButtonType.Normal, stateEffect: true })
      .onClick((event) => {
        if (this.onButtonClick) {
          this.onButtonClick(event)
        }
      })
      .fontSize(this.fontSize)
      .height(this.btnHeight)
      .width(this.btnWidth)
      .borderRadius(BaseConstants.BORDER_RADIUS)
      .backgroundColor($r('app.color.main_color'))
  }
}