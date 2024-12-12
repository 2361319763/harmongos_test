import { HomePage } from './tabbar/HomePage';
import { AppsPage } from './tabbar/AppsPage';
import { BaseConstants } from 'jbase';
@Entry
@Component
struct Index {
  private controller: TabsController = new TabsController()
  @State pageIndex: number = 0;
  @State navPathStack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.navPathStack) {
      Tabs({ barPosition: BarPosition.End, index: this.pageIndex, controller: this.controller }) {
        // 首页
        TabContent(){
          HomePage()
        }
        .width(BaseConstants.FULL_WIDTH)
        .tabBar(BottomTabBarStyle.of(this.pageIndex == 0 ?
          $r('app.media.msg_select') : $r('app.media.msg'), $r('app.string.Message')).labelStyle({
          selectedColor: $r('app.color.main_color'),
          unselectedColor: $r('app.color.pl_text_color')
        }))
        // 工作台
        TabContent(){
          AppsPage()
        }
        .width(BaseConstants.FULL_WIDTH)
        .tabBar(BottomTabBarStyle.of(this.pageIndex == 1 ?
          $r('app.media.app_select') : $r('app.media.app'), $r('app.string.Apps')).labelStyle({
          selectedColor: $r('app.color.main_color'),
          unselectedColor: $r('app.color.pl_text_color')
        }))
        // 联系人
        TabContent(){
          Text('联系人')
        }
        .width(BaseConstants.FULL_WIDTH)
        .tabBar(BottomTabBarStyle.of(this.pageIndex == 2 ?
          $r('app.media.contact_select') : $r('app.media.contact'), $r('app.string.Contacts')).labelStyle({
          selectedColor: $r('app.color.main_color'),
          unselectedColor: $r('app.color.pl_text_color')
        }))
        // 我的
        TabContent(){
          Text('我的')
        }
        .width(BaseConstants.FULL_WIDTH)
        .tabBar(BottomTabBarStyle.of(this.pageIndex == 3 ?
          $r('app.media.my_select') : $r('app.media.my'), $r('app.string.My')).labelStyle({
          selectedColor: $r('app.color.main_color'),
          unselectedColor: $r('app.color.pl_text_color')
        }))
      }
      .barOverlap(true)
      .animationDuration(300)
      .onChange((index: number) => {
        this.pageIndex = index
      })
    }
    .height(BaseConstants.FULL_HEIGHT)
    .hideTitleBar(true)
    .titleMode(NavigationTitleMode.Mini)
  }

}