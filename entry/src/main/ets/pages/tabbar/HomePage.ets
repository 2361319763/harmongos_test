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
        }
        .title($r('app.string.Message'), {
            backgroundColor: $r('app.color.white'),
            backgroundBlurStyle: BlurStyle.Thin
        })
        .titleMode(NavigationTitleMode.Mini)
        .hideBackButton(true)
        .backgroundColor($r('app.color.back_color'))
    }
}