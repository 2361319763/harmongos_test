import { BaseConstants, SearchInput } from "jbase"
// 工作台页面
@Component
export struct AppsPage {
    @State inputValue: string = ''

    build() {
      Navigation() {
        Flex({ direction: FlexDirection.Column }) {
          Row() {
            SearchInput({ inputValue: $inputValue, backColor: $r('app.color.white') })
          }
          .padding({
            top: BaseConstants.MODULE_PADDING,
            left: BaseConstants.MODULE_PADDING,
            right: BaseConstants.MODULE_PADDING
          })
          // 工作台内容
          Row() {
            Image($r('app.media.banner'))
              .width(BaseConstants.FULL_WIDTH)
              .height('auto')
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