
// 首页
@Component
export struct HomePage {
    @Consume('pageInfos') pageStack: NavPathStack;

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
                        Text('To Web')
                    }
                }
            }
            .listDirection(Axis.Vertical)
        }
        .hideBackButton(true)
        .backgroundColor($r('app.color.back_color'))
    }
}