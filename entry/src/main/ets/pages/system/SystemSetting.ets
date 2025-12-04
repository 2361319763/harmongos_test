import { BaseConstants, CellList, CellListItemModel, PageTitleBuilder, StringUtils } from "base"

@Builder
export function SystemSettingBuilder(name: string, param: Object) {
  SystemSetting()
}

@Component
export struct SystemSetting {
  @State textColor: Resource | null = $r('app.color.black')
  @State iconColor: Resource | null = $r('app.color.main_color')
  @State private navPathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Column() {
        // 账号管理
        CellList({ itemData: [
          { text: $r('app.string.user_manage'),  iconName: null },
        ], textColor: this.textColor, iconColor: this.iconColor,
          onItemClick: (item: CellListItemModel, index: number) => {
          }}).margin({ top: 14 })
        // 主题以及字体
        CellList({ itemData: [
          { text: $r('app.string.dark_mode'),  iconName: null },
          { text: $r('app.string.lang_setting'),  iconName: null }
        ], textColor: this.textColor, iconColor: this.iconColor,
          onItemClick: (item: CellListItemModel, index: number) => {
            switch (index) {
              case 0:
                this.navPathStack?.pushPathByName('darkSetting', null)
                break
              case 1:
                this.navPathStack?.pushPathByName('langSetting', null)
                break
            }
        }}).margin({ top: 14 })
        // 安全设置和密码修改
        CellList({ itemData: [
          { text: $r('app.string.security_settings'),  iconName: null },
          { text: $r('app.string.change_pass'),  iconName: null }
        ], textColor: this.textColor, iconColor: this.iconColor,
          onItemClick: (item: CellListItemModel, index: number) => {
            switch (index) {
              case 0:
                this.navPathStack?.pushPathByName('securitySettings', null)
                break
              case 1:
                this.navPathStack?.pushPathByName('updatePassword', null)
                break
            }
          }}).margin({ top: 14 })
      }
      .width(BaseConstants.FULL_WIDTH)
      .padding({ left: BaseConstants.MODULE_PADDING, right: BaseConstants.MODULE_PADDING })
    }
    .title(PageTitleBuilder($r('app.string.setting_title')))
    .backgroundColor($r('app.color.back_color'))
    .onReady((context: NavDestinationContext) => {
      this.navPathStack = context.pathStack
    })
  }
}