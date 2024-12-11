import { NoticeBarModel } from "../types/AllTypes"

@Component
export struct NoticeBar {
  // 通知标题
  @Prop noticeTitle: Resource = $r('app.string.notice_title')
  // 通知数据
  @Prop noticeData: Array<NoticeBarModel> = []
  // 自动播放
  @Prop autoPlay: boolean = true
  // 图标大小
  @Prop iconSize: number = 17
  // 文本大小
  @Prop textSize: number = 15

  // 通知点击事件
  onNoticeClick?: (item: NoticeBarModel, index: number) => void

  build() {
    Flex({ justifyContent: FlexAlign.Start }) {
      SymbolGlyph($r('sys.symbol.bell_fill'))
        .fontColor([$r('app.color.notice_color')])
        .fontSize(this.iconSize)
        .margin({ right: 5 })
        .width('auto')
      Swiper() {
        ForEach(this.noticeData, (item: NoticeBarModel, index) => {
          Row() {
            Text(this.noticeTitle).fontSize(this.textSize).margin({ right: 4 })
            Text(item.title).fontSize(this.textSize).fontColor($r('app.color.gl888'))
          }
          .justifyContent(FlexAlign.Start)
          .onClick(() => {
            if (this.onNoticeClick) {
              this.onNoticeClick(item, index)
            }
          })
        })
      }
      .autoPlay(this.autoPlay)
      .indicator(false)
      .vertical(true)
      .flexGrow(1)
    }
  }
}
