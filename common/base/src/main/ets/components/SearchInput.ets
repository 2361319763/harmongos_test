import { SymbolGlyphModifier } from "@kit.ArkUI"
import { BaseConstants } from "../constants/BaseConstants"
/**
 * 搜索框组件
 */
@Component
export struct SearchInput {
  // 搜索框占位符
  @Prop plText: Resource = $r('app.string.search_text')
  // 组件圆角
  @Prop compRadius: number = BaseConstants.BORDER_RADIUS
  // 组件背景色
  @Prop backColor: ResourceColor = $r('app.color.back_color')
  // 占位符颜色
  @Prop plColor: ResourceColor = $r('app.color.input_pl')
  // 组件高度
  @Prop compHeight: number = 40
  // 是否开启自动完成
  @Prop autoComplete: boolean = false
  // 自动完成延时
  @Prop autoCompleteTime: number = 500
  @Link inputValue: string
  private controller: SearchController = new SearchController()

  build() {
    Row() {
      Search({ value: $$this.inputValue, placeholder: this.plText, controller: this.controller })
        .searchIcon(new SymbolGlyphModifier($r('sys.symbol.magnifyingglass'))
          .fontColor([$r('app.color.gl888')]).fontSize(18))
        .width(BaseConstants.FULL_WIDTH)
        .height(this.compHeight)
        .backgroundColor(this.backColor)
        .placeholderColor(this.plColor)
        .placeholderFont({ size: 15, weight: 400 })
        .textFont({ size: 15, weight: 400 })
        .margin(0)
        .borderRadius(this.compRadius)
    }
  }
}