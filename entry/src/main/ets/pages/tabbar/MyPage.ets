import { BaseConstants } from "jbase"

@Component
export struct MyPage {
  @State private navPathStack: NavPathStack = new NavPathStack()
  @State rootPath: string = ''

  build() {
    Navigation(this.navPathStack) {
      Column() {
        // 头部区域
        Row() {
          Image($r('app.media.avatar12')).width(70).height(70).borderRadius(BaseConstants.BORDER_RADIUS)
          Column() {
            Text('小杰').fontSize(18).fontColor($r('app.color.black')).margin({ left: 14 })
            Text('13529061734').fontSize(15).fontColor($r('app.color.gl_888')).margin({ left: 14, top: 8 })
          }.flexGrow(1).alignItems(HorizontalAlign.Start)
          Row() {
            SymbolGlyph($r('sys.symbol.qrcode')).fontColor([$r('app.color.gl_888')]).fontSize(24)
            SymbolGlyph($r('sys.symbol.chevron_right')).fontColor([$r('app.color.gl_888')])
              .fontSize(24).margin({ left: 5 })
          }
        }.itemStyle()
        // 我的收藏
        Row() {
          SymbolGlyph($r('sys.symbol.star')).fontColor([$r('app.color.main_color')]).fontSize(22)
          Text('我的收藏').fontSize(15).fontColor($r('app.color.black')).margin({ left: 10 }).flexGrow(1)
          SymbolGlyph($r('sys.symbol.chevron_right')).fontColor([$r('app.color.gl_888')]).fontSize(24)
        }.itemStyle().margin({ top: 14 })
        // 其它一些
        Column() {
          Row() {
            SymbolGlyph($r('sys.symbol.info_circle')).fontColor([$r('app.color.main_color')]).fontSize(22)
            Text('关于我们').fontSize(15).fontColor($r('app.color.black')).margin({ left: 10 }).flexGrow(1)
            SymbolGlyph($r('sys.symbol.chevron_right')).fontColor([$r('app.color.gl_888')]).fontSize(24)
          }.itemStyle()
          Divider().margin({ left: 45 }).color($r('app.color.border_e9'))
          Row() {
            SymbolGlyph($r('sys.symbol.square_and_pencil')).fontColor([$r('app.color.main_color')]).fontSize(22)
            Text('意见反馈').fontSize(15).fontColor($r('app.color.black')).margin({ left: 10 }).flexGrow(1)
            SymbolGlyph($r('sys.symbol.chevron_right')).fontColor([$r('app.color.gl_888')]).fontSize(24)
          }.itemStyle()
          Divider().margin({ left: 45 }).color($r('app.color.border_e9'))
          Row() {
            SymbolGlyph($r('sys.symbol.questionmark_circle')).fontColor([$r('app.color.main_color')]).fontSize(22)
            Text('帮助中心').fontSize(15).fontColor($r('app.color.black')).margin({ left: 10 }).flexGrow(1)
            SymbolGlyph($r('sys.symbol.chevron_right')).fontColor([$r('app.color.gl_888')]).fontSize(24)
          }.itemStyle()
          Divider().margin({ left: 45 }).color($r('app.color.border_e9'))
          Row() {
            SymbolGlyph($r('sys.symbol.arrow_up_circle')).fontColor([$r('app.color.main_color')]).fontSize(22)
            Text('版本检查').fontSize(15).fontColor($r('app.color.black')).margin({ left: 10 }).flexGrow(1)
            SymbolGlyph($r('sys.symbol.chevron_right')).fontColor([$r('app.color.gl_888')]).fontSize(24)
          }.itemStyle()
          Divider().margin({ left: 45 }).color($r('app.color.border_e9'))
          Row() {
            SymbolGlyph($r('sys.symbol.share')).fontColor([$r('app.color.main_color')]).fontSize(22)
            Text('分享给朋友').fontSize(15).fontColor($r('app.color.black')).margin({ left: 10 }).flexGrow(1)
            SymbolGlyph($r('sys.symbol.chevron_right')).fontColor([$r('app.color.gl_888')]).fontSize(24)
          }.itemStyle()
        }.listStyle().margin({ top: 14 })
        // 设置
        Row() {
          SymbolGlyph($r('sys.symbol.gearshape')).fontColor([$r('app.color.main_color')]).fontSize(22)
          Text('设置').fontSize(15).fontColor($r('app.color.black')).margin({ left: 10 }).flexGrow(1)
          SymbolGlyph($r('sys.symbol.chevron_right')).fontColor([$r('app.color.gl_888')]).fontSize(24)
        }.itemStyle().margin({ top: 14 })
      }
      .width(BaseConstants.FULL_WIDTH)
      .padding(BaseConstants.MODULE_PADDING)
    }.title($r('app.string.my'), { backgroundColor: $r('app.color.white') })
    .titleMode(NavigationTitleMode.Mini).hideBackButton(true).backgroundColor($r('app.color.back_color'))
  }

  @Styles iconStyle() {

  }

  @Styles itemStyle() {
    .width(BaseConstants.FULL_WIDTH)
    .backgroundColor($r('app.color.white'))
    .borderRadius(BaseConstants.BORDER_RADIUS)
    .padding({ top: BaseConstants.MODULE_PADDING, bottom: BaseConstants.MODULE_PADDING, left: 16, right: 16 })
    .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.9 })
  }

  @Styles listStyle() {
    .width(BaseConstants.FULL_WIDTH)
    .backgroundColor($r('app.color.white'))
    .borderRadius(BaseConstants.BORDER_RADIUS)
  }

}