import { BaseConstants, SearchInput } from "jbase"
// 工作台页面
@Component
export struct AppsPage {
    @State inputValue: string = ''
    @State notifications: Array<string> = [
      '本周六要上班',
      '会议安排在下午两点',
      '项目截止日期延长一周'
    ]
    build() {
      Navigation() {
        Flex({ direction: FlexDirection.Column }) {
          Row() {
            SearchInput({ inputValue: this.inputValue, backColor: $r('app.color.white') })
          }
          .padding({
            top: BaseConstants.MODULE_PADDING,
            left: BaseConstants.MODULE_PADDING,
            right: BaseConstants.MODULE_PADDING
          })
          // 工作台内容
          Column () {
            Image($r('app.media.banner'))
              .width(BaseConstants.FULL_WIDTH)
              .height('auto')
              .borderRadius({
                topLeft: BaseConstants.BORDER_RADIUS,
                topRight: BaseConstants.BORDER_RADIUS
              })
            Flex({ justifyContent: FlexAlign.Start }) {
              SymbolGlyph($r('sys.symbol.bell_fill'))
                .fontColor([$r('app.color.notice_color')])
                .fontSize(16)
                .margin({ right: 5 })
                .width('auto')
              Swiper() {
                ForEach(this.notifications, (item: string, index) => {
                  Row() {
                    Text("通知").fontSize(14).margin({ right: 4 })
                    Text(item).fontSize(14).fontColor($r('app.color.pl_text_color'))
                  }
                  .justifyContent(FlexAlign.Start)
                })
              }
              .autoPlay(true)
              .indicator(false)
              .vertical(true)
              .flexGrow(1)
            }
            .padding({ top: 18, bottom: 14, left: 10, right: 10 })
            .backgroundColor($r('app.color.white'))
            .borderRadius({
              bottomLeft: BaseConstants.BORDER_RADIUS,
              bottomRight: BaseConstants.BORDER_RADIUS
            })
          }
          .padding(BaseConstants.MODULE_PADDING)
        }
        .width(BaseConstants.FULL_WIDTH)
        .height(BaseConstants.FULL_HEIGHT)
        .backgroundColor($r('app.color.back_color'))
      }
      .title($r('app.string.Apps'))
      .titleMode(NavigationTitleMode.Mini)
      .hideBackButton(true)
      .backgroundColor($r('sys.color.white'))

    }
}