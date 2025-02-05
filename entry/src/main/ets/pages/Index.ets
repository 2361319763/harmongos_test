import { BaseConstants } from 'jbase';
import { HomePage } from './tabbar/HomePage';
import { AppsPage } from './tabbar/AppsPage';
import { ContactPage } from './tabbar/ContactPage';
import { MyPage } from './tabbar/MyPage'

@Entry
@Component
struct Index {
  private controller: TabsController = new TabsController()
  @State pageIndex: number = 0;
  @Provide('pageInfos') pageStack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageStack) {
      Tabs({ barPosition: BarPosition.End, index: this.pageIndex, controller: this.controller }) {
        // 首页
        TabContent(){ HomePage() }
        .width(BaseConstants.FULL_WIDTH)
        .tabBar(BottomTabBarStyle.of(this.pageIndex == 0 ?
          $r('app.media.msg_select') : $r('app.media.msg'), $r('app.string.message')).labelStyle({
          selectedColor: $r('app.color.main_color'),
          unselectedColor: $r('app.color.gl_888')
        }))
        // 工作台
        TabContent() { AppsPage() }
        .width(BaseConstants.FULL_WIDTH)
        .tabBar(BottomTabBarStyle.of(this.pageIndex == 1 ?
          $r('app.media.app_select') : $r('app.media.app'), $r('app.string.apps')).labelStyle({
          selectedColor: $r('app.color.main_color'),
          unselectedColor: $r('app.color.gl_888')
        }))

        // 联系人
        TabContent(){ ContactPage() }
        .width(BaseConstants.FULL_WIDTH)
        .tabBar(BottomTabBarStyle.of(this.pageIndex == 2 ?
          $r('app.media.contact_select') : $r('app.media.contact'), $r('app.string.contacts')).labelStyle({
          selectedColor: $r('app.color.main_color'),
          unselectedColor: $r('app.color.gl_888')
        }))
        // 我的
        TabContent(){ MyPage() }
        .width(BaseConstants.FULL_WIDTH)
        .tabBar(BottomTabBarStyle.of(this.pageIndex == 3 ?
          $r('app.media.my_select') : $r('app.media.my'), $r('app.string.my')).labelStyle({
          selectedColor: $r('app.color.main_color'),
          unselectedColor: $r('app.color.gl_888')
        }))
      }
      .barOverlap(true)
      .animationDuration(300)
      .onTabBarClick((index: number) => this.pageIndex = index)
      .onChange((index: number) => this.pageIndex = index)
    }
    .height(BaseConstants.FULL_HEIGHT)
    .hideTitleBar(true)
    .titleMode(NavigationTitleMode.Mini)
  }

}