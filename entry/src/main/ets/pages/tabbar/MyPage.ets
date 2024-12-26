import { BaseConstants, CellList, CellListItemModel } from "jbase"

@Component
export struct MyPage {
  @State private navPathStack: NavPathStack = new NavPathStack()
  @State textColor: Resource | null = $r('app.color.black')
  @State iconColor: Resource | null = $r('app.color.main_color')
  @StorageProp('currentColorMode') @Watch('onColorModeChange') currentMode: number = 0;

  onColorModeChange(changedPropertyName: string) {
    this.textColor = $r('app.color.black')
    this.iconColor = $r('app.color.main_color')
  }

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
        CellList({ itemData: [
          { text: $r('app.string.my_favorites'),  iconName: $r('sys.symbol.star') }
        ], textColor: this.textColor, iconColor: this.iconColor }).margin({ top: 14 })
        // 其它一些
        CellList({ itemData: [
          { id: 'about', text: $r('app.string.my_about_us'), iconName: $r('sys.symbol.info_circle') },
          { id: 'feedback', text: $r('app.string.my_feedback'), iconName: $r('sys.symbol.square_and_pencil') },
          { id: 'help', text: $r('app.string.my_help_center'), iconName: $r('sys.symbol.questionmark_circle') },
          { id: 'version', text: $r('app.string.my_version'), iconName: $r('sys.symbol.arrow_up_circle') },
          { id: 'share', text: $r('app.string.my_share'), iconName: $r('sys.symbol.share') },
        ], textColor: this.textColor, iconColor: this.iconColor}).margin({ top: 14 })
        // 设置
        CellList({ itemData: [
          { text: $r('app.string.my_settings'),  iconName: $r('sys.symbol.gearshape') }
        ], textColor: this.textColor, iconColor: this.iconColor, onItemClick: (item: CellListItemModel, index: number) => {
          let parentStack = this.navPathStack.getParent()
          parentStack?.pushPathByName('darkSetting', null)
        }}).margin({ top: 14 })
        // 退出登录
        Row() {
          Text($r('app.string.my_logout')).fontSize(16).fontColor($r('app.color.red_color'))
        }.itemStyle().margin({ top: 18 }).justifyContent(FlexAlign.Center)
        .onClick(() => {
          AlertDialog.show(
            {
              title: $r('app.string.tips'),
              message: $r('app.string.my_logout_tips'),
              cornerRadius: BaseConstants.BORDER_RADIUS,
              primaryButton: {
                value: $r('app.string.nobtn'),
                action: () => {
                }
              },
              secondaryButton: {
                value: $r('app.string.yesbtn'),
                action: () => {

                }
              }
            }
          )
        })
      }
      .width(BaseConstants.FULL_WIDTH)
      .padding(BaseConstants.MODULE_PADDING)
    }.title($r('app.string.my'), { backgroundColor: $r('app.color.white') })
    .titleMode(NavigationTitleMode.Mini).hideBackButton(true).backgroundColor($r('app.color.back_color'))
  }

  @Styles itemStyle() {
    .width(BaseConstants.FULL_WIDTH)
    .backgroundColor($r('app.color.white'))
    .borderRadius(BaseConstants.BORDER_RADIUS)
    .padding({ top: BaseConstants.MODULE_PADDING, bottom: BaseConstants.MODULE_PADDING, left: 16, right: 16 })
    .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.9 })
  }

}