import { PromptAction } from '@kit.ArkUI';

@Builder
export function DialogPageBuilder(name: string, param: Object) {
  DialogPage()
}

@Component
struct DialogPage {
  private promptAction: PromptAction = this.getUIContext().getPromptAction();
  private fruits: TextCascadePickerRangeContent[] = [
    {
      text: '辽宁省',
      children: [
        { text: '沈阳市', children: [{ text: '沈河区' }, { text: '和平区' }, { text: '浑南区' }] },
        { text: '大连市', children: [{ text: '中山区' }, { text: '金州区' }, { text: '长海县' }] }
      ]
    },
    {
      text: '吉林省',
      children: [
        { text: '长春市', children: [{ text: '南关区' }, { text: '宽城区' }, { text: '朝阳区' }] },
        { text: '四平市', children: [{ text: '铁西区' }, { text: '铁东区' }, { text: '梨树县' }] }
      ]
    },
    {
      text: '黑龙江省',
      children: [
        { text: '哈尔滨市', children: [{ text: '道里区' }, { text: '道外区' }, { text: '南岗区' }] },
        { text: '牡丹江市', children: [{ text: '东安区' }, { text: '西安区' }, { text: '爱民区' }] }
      ]
    }
  ];
  private select : number  = 0;
  @State selectTime: Date = new Date('2025-12-15');


  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 10 }) {
          Button('对话弹窗(showDialog)')
            .onClick(() => {
              this.promptAction.showDialog({
                title: '对话弹窗',
                message: 'Message Info',
                buttons: [
                  {
                    text: '取消',
                    color: '#000000'
                  },
                  {
                    text: '确定',
                    color: '#000000'
                  }
                ]
              }, (err, data) => {
                if (err) {
                  console.error('showDialog err: ' + err);
                  return;
                }
                console.info('showDialog success callback, click button: ' + data.index);
              });
            })

          Button('日历选择器弹窗 (CalendarPickerDialog)')
            .onClick(() => {
              CalendarPickerDialog.show({
                selected: this.selectTime,
                acceptButtonStyle: {
                  fontColor: '#2787d9',
                  fontSize: '16fp',
                  backgroundColor: '#f7f7f7',
                  borderRadius: 10
                },
                cancelButtonStyle: {
                  fontColor: Color.Red,
                  fontSize: '16fp',
                  backgroundColor: '#f7f7f7',
                  borderRadius: 10
                },
                onAccept: (date: Date) => {
                  // 当弹出框再次弹出时显示选中的是上一次确定的日期
                  console.info('CalendarPickerDialog：onAccept:' + date);
                }
              })
            })

          Button('日期滑动选择器弹窗 (DatePickerDialog)')
            .onClick(() => {
              this.getUIContext().showDatePickerDialog({
                start: new Date("2000-1-1"),
                end: new Date("2100-12-31"),
                selected: this.selectTime,
                lunarSwitch: true,
                showTime: true,
                onDateAccept: (value: Date) => {
                  console.info("DatePickerDialog:onAccept()" + JSON.stringify(value));
                },
              });
            })

          Button('时间滑动选择器弹窗 (TimePickerDialog)')
            .onClick(()=> {
              this.getUIContext().showTimePickerDialog({
                selected: this.selectTime,
                textStyle: { color: '#2787d9', font: { size: '14fp', weight: FontWeight.Normal } },
                selectedTextStyle: { color: '#004aaf', font: { size: '18fp', weight: FontWeight.Regular } },
                acceptButtonStyle: {
                  fontColor: '#2787d9',
                  fontSize: '16fp',
                  backgroundColor: '#f7f7f7',
                  borderRadius: 10
                },
                cancelButtonStyle: {
                  fontColor: Color.Red,
                  fontSize: '16fp',
                  backgroundColor: '#f7f7f7',
                  borderRadius: 10
                },
                onAccept: (value) => {
                  console.info('TimePickerDialog:onAccept' + JSON.stringify(value))
                }
              });
            })

          Button('文本滑动选择器弹窗 (TextPickerDialog)')
            .onClick((event: ClickEvent) => {
              this.getUIContext().showTextPickerDialog({
                range: this.fruits,
                selected: this.select,
                onAccept: (value: TextPickerResult) => {
                  this.select = value.index as number
                  console.info('TextPickerDialog:onAccept'+ JSON.stringify(value))
                }
              });
            })

          Button('列表选择弹窗 (ActionSheet)')
            .onClick(()=>{
              this.getUIContext().showActionSheet({
                title: 'ActionSheet title',
                message: 'message',
                autoCancel: false,
                width: 300,
                height: 300,
                cornerRadius: 20,
                borderWidth: 1,
                borderStyle: BorderStyle.Solid,
                borderColor: Color.Blue,
                backgroundColor: Color.White,
                transition: TransitionEffect.asymmetric(TransitionEffect.OPACITY
                  .animation({ duration: 3000, curve: Curve.Sharp })
                  .combine(TransitionEffect.scale({ x: 1.5, y: 1.5 }).animation({ duration: 500, curve: Curve.Sharp })),
                  TransitionEffect.OPACITY.animation({ duration: 100, curve: Curve.Smooth })
                    .combine(TransitionEffect.scale({ x: 0.5, y: 0.5 }).animation({ duration: 100, curve: Curve.Smooth }))),
                confirm: {
                  value: 'Confirm button',
                  action: () => {
                    console.info('Get Alert Dialog handled');
                  }
                },
                alignment: DialogAlignment.Center,
                sheets: [
                  {
                    title: 'apples',
                    action: () => {
                      console.info('apples');
                    }
                  },
                  {
                    title: 'bananas',
                    action: () => {
                      console.info('bananas');
                    }
                  },
                  {
                    title: 'pears',
                    action: () => {
                      console.info('pears');
                    }
                  }
                ]
              });
            })

          Button('警告弹窗 (AlertDialog)')
            .onClick(() => {
              this.getUIContext().showAlertDialog(
                {
                  title: 'title',
                  message: 'text',
                  autoCancel: true,
                  alignment: DialogAlignment.Center,
                  offset: { dx: 0, dy: -20 },
                  gridCount: 3,
                  transition: TransitionEffect.asymmetric(TransitionEffect.OPACITY
                    .animation({ duration: 3000, curve: Curve.Sharp })
                    .combine(TransitionEffect.scale({ x: 1.5, y: 1.5 }).animation({ duration: 500, curve: Curve.Sharp })),
                    TransitionEffect.OPACITY.animation({ duration: 100, curve: Curve.Smooth })
                      .combine(TransitionEffect.scale({ x: 0.5, y: 0.5 })
                        .animation({ duration: 100, curve: Curve.Smooth }))),
                  buttons: [{
                    value: 'cancel',
                    action: () => {
                      console.info('Callback when the first button is clicked');
                    }
                  },
                  {
                    enabled: true,
                    defaultFocus: true,
                    style: DialogButtonStyle.HIGHLIGHT,
                    value: 'ok',
                    action: () => {
                      console.info('Callback when the second button is clicked');
                    }
                  }],
                }
              );
            })
        }
        .justifyContent(FlexAlign.Center)
      }
    }.title('弹窗')
  }
}