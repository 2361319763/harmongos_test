import { BaseConstants } from "../../common/BaseConstants"

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
        .title('首页')
        .titleMode(NavigationTitleMode.Mini)
        .hideBackButton(true)
        .backgroundColor($r('sys.color.white'))
    }
}