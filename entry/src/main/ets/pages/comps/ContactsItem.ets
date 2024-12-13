import { BaseConstants } from 'jbase';

@Component
export struct ContactsItem {
  private name?: Resource | string
  private icon?: Resource
  private isSys: boolean = false
  private backColor?: string
  private showBorder?: boolean = true
  @State iconSize: number = 40

  build() {
    Column() {
      Row() {
        Column() {
          if (!this.isSys) {
            Image(this.icon).height(this.iconSize).width(this.iconSize)
              .borderRadius(BaseConstants.BORDER_RADIUS)
          } else {
            Row() {
              SymbolGlyph(this.icon).fontColor([$r('app.color.white')]).fontSize(24)
            }
            .justifyContent(FlexAlign.Center)
            .height(this.iconSize)
            .width(this.iconSize)
            .backgroundColor(this.backColor)
            .borderRadius(BaseConstants.BORDER_RADIUS)
          }
        }.margin({ left: 14, right: 12 })
        Column() {
          Text(this.name)
            .fontSize(16)
            .fontWeight(500)
            .lineHeight(22)
        }
      }
      .width(BaseConstants.FULL_WIDTH)
      .padding({ top: 8, bottom: 8 })
      if (this.showBorder) {
        Divider().color('#e9e9e9')
          .margin({ left: 60 })
          .height(1)
      }
    }
  }
}