import { HomePage } from './tabbar/HomePage';
import { AppsPage } from './tabbar/AppsPage';
import { BaseConstants } from 'jbase';
@Entry
@Component
struct Index {
  private controller: TabsController = new TabsController()
  @State pageIndex: number = 0;

  build() {
    RelativeContainer() {
      Tabs({ barPosition: BarPosition.End, index: this.pageIndex, controller: this.controller }) {
        // 首页
        TabContent(){
          HomePage()
        }
        .width(BaseConstants.FULL_WIDTH)
        .tabBar(BottomTabBarStyle.of(this.pageIndex == 0 ?
          $r('app.media.msg_select') : $r('app.media.msg'), '消息').labelStyle({
          selectedColor: $r('app.color.main_color'),
          unselectedColor: $r('app.color.pl_text_color')
        }))
        // 工作台
        TabContent(){
          AppsPage()
        }
        .width(BaseConstants.FULL_WIDTH)
        .tabBar(BottomTabBarStyle.of(this.pageIndex == 1 ?
          $r('app.media.app_select') : $r('app.media.app'), '工作台').labelStyle({
          selectedColor: $r('app.color.main_color'),
          unselectedColor: $r('app.color.pl_text_color')
        }))
      }
      .animationDuration(300)
      .onChange((index: number) => {
        this.pageIndex = index
      })

    }
  }

}