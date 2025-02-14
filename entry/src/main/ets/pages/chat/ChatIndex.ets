import { BaseConstants, MainButton, PageTitleBuilder } from "jbase"
import { inputMethod } from '@kit.IMEKit'
// 消息数据模型
class ChatMessage {
  id: string
  content: string
  isUser: boolean

  constructor(id: string, content: string, isUser: boolean) {
    this.id = id
    this.content = content
    this.isUser = isUser
  }
}

@Builder
export function ChatIndexBuilder(name: string, param: Object) {
  ChatIndex()
}

// 聊天页面
@Component
export struct ChatIndex {
  @State private messages: ChatMessage[] = []
  @State private inputText: string = ''
  @Builder CustomKeyboardBuilder(){}
  // 发送消息
  sendMessage() {
    if (this.inputText.trim() === '') return
    
    // 添加用户消息
    this.messages.push(new ChatMessage(
      Date.now().toString(),
      this.inputText,
      true
    ))
    
    // 清空输入框
    this.inputText = ''
    
    // 模拟AI回复
    setTimeout(() => {
      this.messages.push(new ChatMessage(
        Date.now().toString(),
        '你好!很高兴见到你,有什么我可以帮忙的吗?你好!很高兴见到你,有什么我可以帮忙的吗?',
        false
      ))
    }, 1000)
  }

  @Builder
  MessageItem(message: ChatMessage) {
    Row() {
      if (message.isUser) {
        Blank()
        Column() {
          Text(message.content)
            .fontSize(16)
            .backgroundColor($r('app.color.main_color'))
            .fontColor('#ffffff')
            .padding(BaseConstants.MODULE_PADDING)
            .borderRadius(BaseConstants.BORDER_RADIUS)
            .margin({ bottom: 4 })
        }
        .alignItems(HorizontalAlign.End)
      } else {
        Image($r('app.media.avatar12'))
          .width(40)
          .height(40)
          .borderRadius(BaseConstants.BORDER_RADIUS)
          .margin({ right: 12 })
          
        Column() {
          Text(message.content)
            .fontSize(16)
            .backgroundColor($r('app.color.back_color'))
            .padding({  left: 18, right: 18, top: 14, bottom: 14 })
            .borderRadius(BaseConstants.BORDER_RADIUS)
            .margin({ bottom: 4, right: 46 })
            .wordBreak(WordBreak.BREAK_ALL)
            .lineHeight(24)
        }
        Blank()
      }
    }
    .width(BaseConstants.FULL_WIDTH)
    .padding({ left: BaseConstants.MODULE_PADDING,
      right: BaseConstants.MODULE_PADDING, top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Top)
  }

  build() {
    NavDestination() {
      Column() {
        Scroll() {
          // 消息列表
          List({ space: 8 }) {
            ForEach(this.messages, (message: ChatMessage) => {
              ListItem() {
                this.MessageItem(message)
              }
            })
          }
          .width(BaseConstants.FULL_WIDTH)
          .height(BaseConstants.FULL_HEIGHT)
        }.layoutWeight(1).onClick(() => {
          inputMethod.getController().hideTextInput()
        })
        // 输入区域
        Flex({ alignItems: ItemAlign.Center }) {
          Column() {
            SymbolGlyph($r('sys.symbol.mic_circle')).fontSize(38).fontColor([$r('app.color.black')])
          }
          .padding({ right: 12 })
          Column() {
            TextArea({ placeholder: '请输入消息', text: this.inputText })
              .enterKeyType(EnterKeyType.NEW_LINE)
              .borderRadius(0)
              .fontSize(16)
              .lineHeight(24)
              .maxLength(500)
              .backgroundColor($r('app.color.back_color'))
              .padding({ left: 0, right: 0 })
              .heightAdaptivePolicy(TextHeightAdaptivePolicy.LAYOUT_CONSTRAINT_FIRST)
              .onChange((value: string) => {
                this.inputText = value
              })
          }
          .backgroundColor($r('app.color.back_color'))
          .borderRadius(BaseConstants.BORDER_RADIUS)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .margin({ left: 12, right: 12 })
          Column() {
            Button({ type: ButtonType.Circle, stateEffect: true }) {
              SymbolGlyph($r('sys.symbol.paperplane_right_fill')).fontSize(20).fontColor(['#ffffff'])
            }.height(42).width(42)
            .onClick(() => {
              inputMethod.getController().hideTextInput()
              this.sendMessage()
            })
          }
          .padding({ left: 6 })
        }
        .width(BaseConstants.FULL_WIDTH)
        .padding(BaseConstants.MODULE_PADDING + 2)
      }
      .width(BaseConstants.FULL_WIDTH)
      .height(BaseConstants.FULL_HEIGHT)
    }
    .title(PageTitleBuilder($r('app.string.new_chat')))
  }
}