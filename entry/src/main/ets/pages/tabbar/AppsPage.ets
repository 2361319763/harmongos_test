import { BaseConstants, SearchInput, NoticeBar, NoticeBarModel, AppsModule } from "jbase"
import { MyAppMock, AllAppMock } from "../../mock/AppDataMock"
import { AppsManageParams } from "../apps/AppsManage"
// 工作台页面
@Component
export struct AppsPage {
    @State notifications: Array<NoticeBarModel> = [
      { title: '本周六要上班', id: 'id1', code: 'code1' },
      { title: '会议安排在下午两点', id: 'id2', code: 'code2' },
      { title: '项目截止日期延长一周', id: 'id3', code: 'code3' }
    ]
    @State myAppIndex: number | null = null
    @State allAppIndex: number | null = null
    @Consume('pageInfos') pageStack: NavPathStack;

    // 搜索确认事件
    onSearchConfirm: (value: string) => void = (value: string) => {
      console.info('onSearchConfirm: ' + value)
    }

    // 通知公共点击事件
    onNoticeClick: (item: NoticeBarModel, index: number)
      => void = (item: NoticeBarModel, index: number) => {
      console.info('onNoticeClick: ' + item.title + ', index:' + index)
    }

    // 编辑应用
    onEditApps: () => void = () => {
      // let parentStack = this.navPathStack.getParent()
      // parentStack?.pushPath({ name: 'appsManage' })
      console.info('onEditApps：点击编辑应用')
    }

    // 添加应用
    onAddApps: () => void = () => {
      const pageParams: AppsManageParams = { name: 'appsManage', param: { type: 'add' } }
      this.pageStack?.pushPath(pageParams)
    }

    build() {
      Navigation() {
        Scroll() {
          Column() {
            Row() {
              // 搜索框
              SearchInput({ backColor: $r('app.color.white'), autoComplete: true, onSearchSubmit: this.onSearchConfirm })
            }.modulePadding()
            // 工作台内容
            Column() {
              Image($r('app.media.banner')).width(BaseConstants.FULL_WIDTH)
                .height('auto').borderRadius({ topLeft: BaseConstants.BORDER_RADIUS, topRight: BaseConstants.BORDER_RADIUS })
              Row() {
                // 通知栏
                NoticeBar({ noticeData: this.notifications, onNoticeClick: this.onNoticeClick })
              }
              .itemPadding().backgroundColor($r('app.color.white'))
              .borderRadius({ bottomLeft: BaseConstants.BORDER_RADIUS, bottomRight: BaseConstants.BORDER_RADIUS })
            }.modulePadding()
            // 常用应用
            Column() {
              AppsModule({ moduleTitle: $r('app.string.common_app'), appsData: MyAppMock, showEditBtn: true,
                  showAddBtn: true, onEditClick: this.onEditApps, onAddClick: this.onAddApps })
            }.modulePadding()
            // 全部应用
            Column() {
              AppsModule({ moduleTitle: $r('app.string.all_app'), appsData: AllAppMock })
            }.modulePadding()
            .margin({ bottom: 65 })
          }.width(BaseConstants.FULL_WIDTH)
        }.scrollBar(BarState.Off)
      }
      .title($r('app.string.apps'), {
        backgroundColor: $r('app.color.white')
      })
      .titleMode(NavigationTitleMode.Mini)
      .hideBackButton(true)
      .backgroundColor($r('app.color.back_color'))
    }

    @Styles modulePadding() {
      .padding({ top: BaseConstants.MODULE_PADDING, left: BaseConstants.MODULE_PADDING, right: BaseConstants.MODULE_PADDING })
    }

    @Styles itemPadding() {
      .padding({ top: BaseConstants.MODULE_PADDING, bottom: BaseConstants.MODULE_PADDING, left: 18, right: 18 })
    }
}