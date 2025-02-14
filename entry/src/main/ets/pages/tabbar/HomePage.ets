import { BaseConstants } from "jbase"
import { CustomContentDialog, SymbolGlyphModifier } from "@kit.ArkUI"
import { ChatSession } from '../chat/ChatType'
import { SessionItem } from '../chat/SessionItem'

// 首页
@Component
export struct HomePage {
    @Consume('pageInfos') pageStack: NavPathStack;
    @State sessions: ChatSession[] = [
        new ChatSession('1', '你好，你是谁？', '2025-02-15 01:42'),
        new ChatSession('2', '帮我生成一个测试的页面', '2025-02-15 01:42'),
        new ChatSession('3', '你会干嘛？', '2025-02-15 01:42'),
    ]
    @State editingTitle: string = ''
    @State editStartIcon: SymbolGlyphModifier = new SymbolGlyphModifier($r('sys.symbol.square_and_pencil')).fontSize(18)
    @State deleteIcon: SymbolGlyphModifier = new SymbolGlyphModifier($r('sys.symbol.trash')).fontSize(18).fontColor([$r('app.color.red_color')])
    @State addChatIcon: SymbolGlyphModifier = new SymbolGlyphModifier($r('sys.symbol.message')).fontSize(18).fontColor([$r('app.color.black')])

    @Builder
    TextInputContent(text: string,placeholder: Resource | string | undefined,
        onChange: EditableTextOnChangeCallback) {
        Column() {
            TextInput({ placeholder: placeholder, text: text })
                .width(BaseConstants.FULL_WIDTH)
                .height(40)
                .cancelButton({ style: CancelButtonStyle.INPUT })
                .borderRadius(BaseConstants.BORDER_RADIUS)
                .onChange(onChange)
        }
        .width(BaseConstants.FULL_WIDTH)
        .padding({ top: 10, bottom: 10 })
    }
    inputDialogController: CustomDialogController = new CustomDialogController({
        cornerRadius: BaseConstants.BORDER_RADIUS,
        builder: CustomContentDialog({
            contentBuilder: () => {
                this.TextInputContent('你好啊', '请输入标题', (value: string) => {});
            },
            buttons: [
                {
                    value: $r('app.string.cancel'),
                    buttonStyle: ButtonStyleMode.TEXTUAL,
                    action: () => {
                        console.info('Callback when the button is clicked')
                    }
                },
                {
                    value: $r('app.string.confirm'),
                    buttonStyle: ButtonStyleMode.TEXTUAL,
                }
            ],
        }),
    });
    // 删除会话
    deleteSession(session: ChatSession) {
        let index = this.sessions.findIndex(item => item.id === session.id)
        if (index !== -1) {
            this.sessions.splice(index, 1)
        }
    }

    // 编辑会话标题
    editSessionTitle(session: ChatSession, newTitle: string) {
        let index = this.sessions.findIndex(item => item.id === session.id)
        if (index !== -1) {
            this.sessions[index].title = newTitle
        }
    }


    @Builder
    ContextMenu(session: ChatSession) {
        Menu() {
            MenuItem({
                symbolStartIcon: this.editStartIcon,
                content: $r('app.string.edit_title')
            })
            .onClick(() => {
                this.inputDialogController.open()
            })

            MenuItem({
                symbolStartIcon: this.deleteIcon,
                content: $r('app.string.delete')
            }).contentFontColor($r('app.color.red_color'))
            .onClick(() => {
                AlertDialog.show({
                    title: $r('app.string.tips'),
                    message: $r('app.string.confirm_delete_chat'),
                    cornerRadius: BaseConstants.BORDER_RADIUS,
                    height: 170,
                    primaryButton: {
                        value: $r('app.string.cancel'),
                        action: () => {}
                    },
                    secondaryButton: {
                        value: $r('app.string.confirm'),
                        action: () => {
                            this.deleteSession(session)
                        }
                    }
                })
            })
        }
    }

    build() {
        Navigation() {
            Scroll() {
                List() {
                    ForEach(this.sessions, (session: ChatSession) => {
                        ListItem() {
                            SessionItem(session)
                        }
                        .margin({ top: 12 })
                        .bindContextMenu(this.ContextMenu(session), ResponseType.LongPress)
                        .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 })
                        .onClick(() => {
                            // 点击进入聊天详情
                            console.info('Click chat:', session.title)
                        })
                    })
                }
                .width(BaseConstants.FULL_WIDTH)
                .height(BaseConstants.FULL_HEIGHT)
                .padding({ left: 12, right: 12 })
                .listDirection(Axis.Vertical)
            }
        }
        .title($r('app.string.message'), {
            backgroundColor: $r('app.color.white')
        })
        .menus([
            {
                value: '',
                symbolIcon: this.addChatIcon ,
                action: () => {
                    console.info('Click add')
                    this.pageStack?.pushPathByName('chatIndex', null)
                }
            }
        ])
        .titleMode(NavigationTitleMode.Mini)
        .hideBackButton(true)
        .backgroundColor($r('app.color.back_color'))
    }

    aboutToDisappear() {
    }
}