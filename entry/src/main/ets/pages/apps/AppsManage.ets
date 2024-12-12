import { AppItemModel, BaseConstants, StringUtils } from "jbase"
import { AllAppMock } from "../../mock/AppDataMock"

interface typeParams {
  type: string;
}

export interface AppsManageParams {
  name: string;
  param: typeParams
}

@Builder
export function AppsManageBuilder(name: string, param: typeParams) {
  AppsManage({ param: param })
}

@Component
export struct AppsManage {
  @State param: typeParams | null = null
  build() {
    NavDestination() {
      Scroll() {
        Column() {
          List({ space: 0, initialIndex: 0 }) {
            ForEach(AllAppMock, (item: AppItemModel, index: number) => {
              ListItem() {
                Row() {
                  Row() {
                    Image(item.imageUrl).width(40).height(40).borderRadius(BaseConstants.BORDER_RADIUS)
                    Text(item.appName).fontSize(16).fontColor($r('app.color.black')).fontWeight(500).margin({ left: 10 })
                  }
                  Button('添加').height(34).backgroundColor($r('app.color.white')).fontColor($r('app.color.black')).fontSize(14)
                    .borderRadius(BaseConstants.BORDER_RADIUS).border({ width: 1, color: $r('app.color.back_eee') })
                    .width(80)
                }
                .width(BaseConstants.FULL_WIDTH)
                .padding({ left: 14, right: 14, top: 8, bottom: 8 })
                .justifyContent(FlexAlign.SpaceBetween)
              }
            })
          }
          .padding({ top: 8, bottom: 8 })
          .backgroundColor($r('app.color.white'))
          .borderRadius(BaseConstants.BORDER_RADIUS)
          .divider(new DividerTmp(1, 60, 0, $r('app.color.back_eee')))
        }
        .width(BaseConstants.FULL_WIDTH)
        .padding(BaseConstants.MODULE_PADDING)
      }
    }
    .title(this.param && this.param.type === 'add' ? StringUtils.getResStr($r('app.string.add_app'), this) : '',
      { backgroundColor: $r('app.color.white') })
    .backgroundColor($r('app.color.back_color'))
  }
}