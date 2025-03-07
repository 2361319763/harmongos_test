import { BaseConstants, MainButton, PageTitleBuilder } from "jbase"
import { inputMethod } from '@kit.IMEKit'
import { AppConfig } from '../../config/Index'
import { http } from '@kit.NetworkKit'
import CustomEventSource from './EventSource'

interface SSEData {
  type: string
  content: string
}

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

class Header {
  public contentType: string
  public accept: string

  constructor(contentType: string, accept: string) {
    this.contentType = contentType
    this.accept = accept
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
  private eventSource: CustomEventSource | null = null
  private scroller: Scroller = new Scroller()
  
  @Builder CustomKeyboardBuilder(){}

  aboutToCreate() {
  }

  aboutToDisappear() {
    if (this.eventSource) {
      this.eventSource.close()
    }
  }

  // 发送消息
  sendMessage() {
    if (this.inputText.trim() === '') return
    
    // 添加用户消息
    this.messages = [
      ...this.messages,
      new ChatMessage(
        Date.now().toString(),
        this.inputText,
        true
      )
    ]
    
    const userInput = this.inputText
    // 清空输入框
    this.inputText = ''
    
    // 创建新的AI消息
    const aiMessageId = Date.now().toString()
    this.messages = [
      ...this.messages,
      new ChatMessage(aiMessageId, '', false)
    ]

    // 滚动到底部
    this.scrollToBottom()
    
    // 关闭之前的连接
    if (this.eventSource) {
      this.eventSource.close()
    }

    // 创建SSE连接
    this.eventSource = new CustomEventSource(AppConfig.aiRootUrl + '/chat', {
      method: http.RequestMethod.POST,
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ query: userInput })
    })

    // 监听消息
    this.eventSource.onMessage = (event) => {
      try {
        const data: SSEData = JSON.parse(event.data)
        if (data.type === 'content') {
          this.updateAiMessage(aiMessageId, data.content)
          // 每次更新后滚动到底部
          this.scrollToBottom()
        }
      } catch (e) {
        console.error('Failed to parse SSE data:', e.message)
      }
    }

    // 监听错误
    this.eventSource.onError = (error: Error) => {
      console.error('SSE Error:', error.message)
      this.updateAiMessage(aiMessageId, '抱歉，连接出错了')
      this.eventSource?.close()
    }
  }
  
  // 更新AI消息内容
  private updateAiMessage(messageId: string, content: string) {
    const index = this.messages.findIndex(msg => msg.id === messageId)
    if (index !== -1) {
      const currentMessage = this.messages[index]
      // 创建新的消息对象，但保持其他消息不变
      this.messages = this.messages.map((msg, i) => 
        i === index ? new ChatMessage(
          currentMessage.id,
          currentMessage.content + content,
          currentMessage.isUser
        ) : msg
      )
    }
  }

  // 滚动到底部
  private scrollToBottom() {
    setTimeout(() => {
      this.scroller.scrollEdge(Edge.Bottom);
    }, 10)
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
          .objectFit(ImageFit.Cover)
          .markAnchor({ x: 0, y: 0 })
          .position({ x: 0, y: 0 })
          
        Column() {
          Text(message.content)
            .fontSize(16)
            .backgroundColor($r('app.color.back_color'))
            .padding({ left: 18, right: 18, top: 14, bottom: 14 })
            .borderRadius(BaseConstants.BORDER_RADIUS)
            .margin({ bottom: 4, right: 46, left: 52 })
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
        Scroll(this.scroller) {
          // 消息列表
          List({ scroller: this.scroller, space: 8 }) {
            ForEach(this.messages, (message: ChatMessage) => {
              ListItem() {
                this.MessageItem(message)
              }
            })
          }
          .width(BaseConstants.FULL_WIDTH)
          .height(BaseConstants.FULL_HEIGHT)
        }
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .layoutWeight(1)
        .onClick(() => {
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