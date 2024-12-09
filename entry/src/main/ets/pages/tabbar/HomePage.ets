import { BaseConstants } from "jbase"

// 首页
@Component
export struct HomePage {
    build() {
        Navigation() {
            Flex({ direction: FlexDirection.Column }) {
                Text('Home Page')
            }
            .width(BaseConstants.FULL_WIDTH)
            .height(BaseConstants.FULL_HEIGHT)
            .backgroundColor($r('app.color.back_color'))
        }
        .title($r('app.string.Message'))
        .titleMode(NavigationTitleMode.Mini)
        .hideBackButton(true)
        .backgroundColor($r('sys.color.white'))
    }
}