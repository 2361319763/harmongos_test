import { CellList, CellListItemModel } from 'base'
// 首页
@Component
export struct HomePage {
    @Consume('pageInfos') pageStack: NavPathStack;
    @State textColor: Resource | null = $r('app.color.black')
    @State iconColor: Resource | null = $r('app.color.main_color')

    @Builder
    itemHead(title: string) {
        Text(title)
            .width('100%')
            .fontSize(20)
            .textAlign(TextAlign.Center)
            .padding(10)
    }

    build() {
        Navigation() {
            List() {
                ListItemGroup({
                    header: this.itemHead('Test')
                }) {
                    ListItem(){
                        CellList({
                            itemData: [
                                { id: '1',text: 'TO Web' }
                            ],
                            textColor: this.textColor, iconColor: this.iconColor, onItemClick: (item: CellListItemModel, index: number) => {
                                switch (item.id) {
                                    case '1':
                                        let src = 'https://www.baidu.com?barHidden=true'
                                        this.pageStack?.pushPathByName('webViewPage', src)
                                        break
                                }
                            }
                        }).margin({ bottom: 14, left: 14, right: 14 })
                    }
                }
            }
            .listDirection(Axis.Vertical)
        }
        .hideBackButton(true)
        .backgroundColor($r('app.color.back_color'))
    }
}