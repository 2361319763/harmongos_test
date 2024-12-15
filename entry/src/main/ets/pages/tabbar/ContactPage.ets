import { Alphabets, BaseConstants, ContactsDataModel } from "jbase"
import { ContactsListData } from "../../mock/ContactsDataMock";
import { ContactsItem } from "../comps/ContactsItem";

// 工作台页面
@Component
export struct ContactPage {
  @State navPathStack: NavPathStack = new NavPathStack()
  @State selectedIndex: number = 0;
  @State private currentIndex: number = 0;
  @State itemHeight: number = 60;
  private listScroller: Scroller = new Scroller();

  findContactsItemIndex(index: number): number {
    if (index < 0) return 0;
    const currentIndex = ContactsListData.findIndex(item => item.en_name[0].toUpperCase() === Alphabets[index])
    if (currentIndex === -1) {
      return this.findContactsItemIndex(index - 1)
    } else {
      return currentIndex;
    }
  }
  // 列表分组标题
  @Builder itemTitle() {
    Row() {
      Text($r('app.string.ct_title'))
        .fontSize(15).fontColor($r('app.color.gl_888'))
    }
    .backgroundColor($r('app.color.back_color'))
    .width(BaseConstants.FULL_WIDTH)
    .padding({ left: 10, right: 10, top: BaseConstants.MODULE_PADDING, bottom: BaseConstants.MODULE_PADDING })
  }
  build() {
    Navigation(this.navPathStack) {
      Flex({ direction: FlexDirection.Column }) {
        Stack({ alignContent: Alignment.End }) {
          List({ scroller: this.listScroller }) {
            // 顶部的分组
            ListItemGroup() {
              ListItem() {
                ContactsItem({ name: $r('app.string.ct_xj'), icon: $r('sys.symbol.children'), backColor: '#FA9C3B', isSys: true })
              }.listItemStyle()
              .borderRadius({ topLeft: BaseConstants.BORDER_RADIUS, topRight: BaseConstants.BORDER_RADIUS })
              .padding({ top: 6 })
              ListItem() {
                ContactsItem({ name: $r('app.string.ct_group'), icon: $r('sys.symbol.message_on_message_fill'), backColor: '#0EC15F', isSys: true })
              }.listItemStyle()
              ListItem() {
                ContactsItem({ name: $r('app.string.ct_org'), icon: $r('sys.symbol.person_2_fill'),
                  backColor: '#1486EE', isSys: true, showBorder: false })
              }.listItemStyle()
              .borderRadius({ bottomLeft: BaseConstants.BORDER_RADIUS, bottomRight: BaseConstants.BORDER_RADIUS })
              .padding({ bottom: 6 })
            }
            .borderRadius(BaseConstants.BORDER_RADIUS)
            .backgroundColor($r('app.color.white'))
            // 联系人分组，这里没有完善，可以自行改造，增加 A B C D 这种，按这种分组，索引查找时才有效
            ListItemGroup({ header: this.itemTitle() }) {
              ForEach(ContactsListData, (item: ContactsDataModel, index: number) => {
                if (index === 0) {
                  ListItem() {
                    ContactsItem({ name: item.name, icon: item.icon })
                  }.listItemStyle().padding({ top: 6 })
                  .borderRadius({ topLeft: BaseConstants.BORDER_RADIUS, topRight: BaseConstants.BORDER_RADIUS })
                } else if (index === ContactsListData.length - 1) {
                  ListItem() {
                    ContactsItem({ name: item.name, icon: item.icon, showBorder: false })
                  }.listItemStyle().padding({ bottom: 6 })
                  .borderRadius({ bottomLeft: BaseConstants.BORDER_RADIUS, bottomRight: BaseConstants.BORDER_RADIUS })
                } else {
                  ListItem() {
                    ContactsItem({ name: item.name, icon: item.icon })
                  }.listItemStyle()
                }
              })
            }
          }
          .padding(BaseConstants.MODULE_PADDING)
          .scrollBar(BarState.Off)
          .edgeEffect(EdgeEffect.None)
          .margin({ bottom: 50 })
          .onScrollIndex((index: number) => {
            console.log('scrollIndex: ' + index)
            this.selectedIndex = index
          })
          // 索引器
          AlphabetIndexer({ arrayValue: Alphabets, selected: 0 })
            .onSelect((index: number) => {
              const currentIndex = this.findContactsItemIndex(index)
              this.listScroller.scrollToIndex(index, true)
            }).margin({ right: '16vp' }).color(Color.Black)
            .font({ size: '12pf', weight: 500, })
            .selected(this.selectedIndex)
        }
      }.height(BaseConstants.FULL_HEIGHT).width(BaseConstants.FULL_WIDTH)
    }
    .title($r('app.string.contacts'), { backgroundColor: $r('app.color.white') })
    .titleMode(NavigationTitleMode.Mini).hideBackButton(true).backgroundColor($r('app.color.back_color'))
  }

  @Styles listItemStyle() {
    .backgroundColor(Color.White)
  }
}