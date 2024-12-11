import { BaseConstants, SearchInput, NoticeBar, NoticeBarModel, AppItemModel, StringUtils } from "jbase"
import { MyAppMock, AllAppMock } from "../../mock/AppDataMock"

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

    // 搜索确认事件
    onSearchConfirm: (value: string) => void = (value: string) => {
      console.info('onSearchConfirm: ' + value)
    }

    // 通知公共点击事件
    onNoticeClick: (item: NoticeBarModel, index: number)
      => void = (item: NoticeBarModel, index: number) => {
      console.info('onNoticeClick: ' + item.title + ', index:' + index)
    }

    @Builder navTitle() {
      Row() {
        Text($r('app.string.Apps')).fontSize(24)
          .fontColor($r('app.color.black'))
          .fontWeight(600)
          .backgroundColor($r('app.color.white'))
      }
      .backgroundColor($r('app.color.white'))
      .width(BaseConstants.FULL_WIDTH)
      .height(BaseConstants.FULL_HEIGHT)
      .padding({ left: 18 })
    }

    build() {
      Navigation() {
        Scroll() {
          Column() {
            Row() {
              // 搜索框
              SearchInput({
                backColor: $r('app.color.white'),
                autoComplete: true,
                onSearchSubmit: this.onSearchConfirm
              })
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
              Column() {
                // 应用模块标题
                Flex({ justifyContent: FlexAlign.SpaceBetween }) {
                  Text($r('app.string.common_app')).fontSize(18).fontColor($r('app.color.black')).fontWeight(500)
                  Text(`\ue6ef ${StringUtils.getResStr($r('app.string.edit_app'), this)}`).fontSize(14)
                    .fontColor($r('app.color.gl888')).fontFamily('iconfont')
                }.itemPadding()

                Grid() {
                  ForEach(MyAppMock, (item: AppItemModel, index: number) => {
                    GridItem() {
                      Column() {
                        Image(item.imageUrl).width(55).height(55).borderRadius(BaseConstants.BORDER_RADIUS)
                        Text(item.appName).fontSize(14).fontColor($r('app.color.gl888')).margin({ top: 8 })
                      }
                    }.onClick(() => {
                      this.myAppIndex = index
                    }).clickEffect({level:ClickEffectLevel.HEAVY, scale: 0.5})
                  })
                }.columnsTemplate('1fr 1fr 1fr 1fr').padding({ top: 6, bottom: 16, left: 6, right: 6 }).rowsGap(15)
              }
              .width(BaseConstants.FULL_WIDTH)
              .backgroundColor($r('app.color.white'))
              .borderRadius(BaseConstants.BORDER_RADIUS)
            }.modulePadding()
            // 全部应用
            Column() {
              Column() {
                // 应用模块标题
                Flex({ justifyContent: FlexAlign.Start }) {
                  Text($r('app.string.all_app')).fontSize(18).fontColor($r('app.color.black')).fontWeight(500)
                }.itemPadding()
                Grid() {
                  ForEach(AllAppMock, (item: AppItemModel, index: number) => {
                    GridItem() {
                      Column() {
                        Image(item.imageUrl).width(55).height(55).borderRadius(BaseConstants.BORDER_RADIUS)
                        Text(item.appName).fontSize(14).fontColor($r('app.color.gl888')).margin({ top: 8 })
                      }
                    }.clickEffect({level:ClickEffectLevel.HEAVY, scale: 0.5})
                  })
                }.columnsTemplate('1fr 1fr 1fr 1fr').padding({ top: 6, bottom: 16, left: 6, right: 6 }).rowsGap(15)
              }
              .width(BaseConstants.FULL_WIDTH)
              .backgroundColor($r('app.color.white'))
              .borderRadius(BaseConstants.BORDER_RADIUS)
            }.modulePadding()
            .margin({ bottom: 30 })
          }.width(BaseConstants.FULL_WIDTH)
        }.scrollBar(BarState.Off)
      }
      .title(this.navTitle())
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