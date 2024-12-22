import { BaseConstants } from "../constants/BaseConstants"

@Component
export struct CellListItem {
  // 是否显示图标
  @Prop showIcon: boolean = true
  // 图标颜色
  @Link iconColor: Resource | null
  // 图标名称
  @Prop iconName: Resource | null
  // 图标大小
  @Prop iconSize: number = 22
  // 文本内容
  @Prop text: string | Resource
  // 文本大小
  @Prop textSize: number = 16
  // 文本颜色
  @Link textColor: Resource | null
  // 显示右侧箭头
  @Prop showArrow: boolean = true

  build() {
    Row() {
      if (this.showIcon) {
        SymbolGlyph(this.iconName).fontColor([this.iconColor]).fontSize(this.iconSize).margin({ right: 10 })
      }
      Text(this.text).fontSize(this.textSize).fontColor(this.textColor).flexGrow(1)
      if (this.showArrow) {
        SymbolGlyph($r('sys.symbol.chevron_right')).fontColor([$r('app.color.gl_888')]).fontSize(24)
      }
    }.itemStyle().width(BaseConstants.FULL_WIDTH)
  }

  @Styles itemStyle() {
    .width(BaseConstants.FULL_WIDTH)
    .backgroundColor($r('app.color.white'))
    .borderRadius(BaseConstants.BORDER_RADIUS)
    .padding({ top: BaseConstants.MODULE_PADDING, bottom: BaseConstants.MODULE_PADDING, left: 16, right: 16 })
    .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.9 })
  }
}

export interface CellListItemModel {
  id?: string,
  showIcon?: boolean
  iconName?: Resource | null
  iconSize?: number
  text: string | Resource
  textSize?: number
  showArrow?: boolean
}

@Component
export struct CellList {
  @Prop itemData: CellListItemModel[]
  @Link textColor: Resource | null
  @Link iconColor: Resource | null
  // 列表点击事件
  onItemClick?: (item: CellListItemModel, index: number) => void
  build() {
    Column() {
      if (this.itemData.length > 0) {
        ForEach(this.itemData, (item: CellListItemModel, index: number) => {
          CellListItem({
            showIcon: item.showIcon,
            iconName: item.iconName,
            iconSize: item.iconSize,
            text: item.text,
            textSize: item.textSize,
            showArrow: item.showArrow,
            textColor: this.textColor,
            iconColor: this.iconColor
          }).onClick(() => {
            this.onItemClick && this.onItemClick(item, index)
          })
          if (index != this.itemData.length - 1) {
            Divider().margin({ left: 45 }).color($r('app.color.border_e9'))
          }
        })
      }
    }
    .width(BaseConstants.FULL_WIDTH)
    .backgroundColor($r('app.color.white'))
    .borderRadius(BaseConstants.BORDER_RADIUS)
  }

}

