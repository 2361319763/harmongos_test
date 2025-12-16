const  FONT_SIZE: number = 28;
const PADDING: number = 50;

@Builder
export function GesturePageBuilder(name: string, param: Object) {
  GesturePage()
}

@Component
struct GesturePage {
  @State value: string = "";

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text(this.value)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
          Text('双击手势检测')
            .fontSize(FONT_SIZE)
            .padding(PADDING)
            .backgroundColor(Color.Brown)
            .fontColor(Color.White)
            .gesture(
              // 双击手势
              TapGesture({ count: 2 })
                .onAction((event: GestureEvent | undefined) => {
                  if (event) {
                    this.value = "双击手势检测🆗";
                  }
                }),
            )

          Text('长按手势检测')
            .fontSize(FONT_SIZE)
            .padding(PADDING)
            .backgroundColor(Color.Brown)
            .fontColor(Color.White)
            .gesture(
              // 双击手势
              LongPressGesture()
                .onAction((event: GestureEvent | undefined) => {
                  if (event) {
                    this.value = "长按手势检测🆗";
                  }
                }),
            )


          Text('滑动手势检测')
            .fontSize(FONT_SIZE)
            .padding(PADDING)
            .backgroundColor(Color.Brown)
            .fontColor(Color.White)
            .gesture(
              PanGesture()
                .onActionStart(() => {
                  console.info("Pan start");
                })
                .onActionUpdate((event: GestureEvent) => {
                  // 单指滑动
                  if (event.source === SourceType.TouchScreen) {
                    this.value = "滑动手势检测🆗";
                  }
                }))


          Text('捏合手势检测')
            .fontSize(FONT_SIZE)
            .padding(PADDING)
            .backgroundColor(Color.Brown)
            .fontColor(Color.White)
            .gesture(

              PinchGesture({ fingers: 2 })
                .onActionUpdate((event: GestureEvent | undefined) => {
                  if (event) {
                    this.value = "捏合手势检测🆗"
                  }
                })

            )

          Text('旋转手势检测')
            .fontSize(FONT_SIZE)
            .padding(PADDING)
            .backgroundColor(Color.Brown)
            .fontColor(Color.White)
            .gesture(

              RotationGesture()
                .onActionUpdate((event: GestureEvent | undefined) => {
                  if (event) {
                    this.value = "旋转手势检测🆗"
                  }
                })

            )


        }
        .justifyContent(FlexAlign.Center)

      }
      .height("100%")
      .width("100%")
    }
    .title('手势事件', {
    })
  }
}