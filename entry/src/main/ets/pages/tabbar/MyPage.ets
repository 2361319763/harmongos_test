@Component
export struct MyPage {
  @State private navPathStack: NavPathStack = new NavPathStack()
  @State rootPath: string = ''

  build() {
    Navigation(this.navPathStack) {

    }.title($r('app.string.my'), { backgroundColor: $r('app.color.white') })
    .titleMode(NavigationTitleMode.Mini).hideBackButton(true).backgroundColor($r('app.color.back_color'))
  }
}