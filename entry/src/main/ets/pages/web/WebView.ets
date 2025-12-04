import { webview } from '@kit.ArkWeb';
import { BaseConstants } from 'base';
import { FullLoading } from 'base';
import { AppConfig } from '../../config/Index';
import { display } from '@kit.ArkUI';

class Harmony {
  handleMessage(msg: string){
    console.log(msg)
  }
}

type ParamType = string | Resource

@Builder
export function WebViewPageBuilder(name: string, param: ParamType) {
  WebViewPage({src: param})
}

@Component
struct NavTitle {
  /**
   * 展示文字
   */
  @Prop text: string = ''
  /**
   * 操作的builder
   */
  @BuilderParam rightBuilder?: CustomBuilder
  @State private screenWidth: number = 0

  aboutToAppear(): void {
    this.screenWidth = px2vp(display.getDefaultDisplaySync().width)
    display.on('change', () => {
      this.screenWidth = px2vp(display.getDefaultDisplaySync().width)
    })
  }

  build() {
    Row() {
      Row() {
        Text(this.text)
          .width(this.screenWidth - 112)
          .fontSize(16)
          .fontColor('#404040')
          .textAlign(TextAlign.Center)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .ellipsisMode(EllipsisMode.END)
          .wordBreak(WordBreak.BREAK_ALL)
      }
      .width(this.screenWidth - 112)
      .height(56)
      .justifyContent(FlexAlign.Center)

      if (typeof this.rightBuilder === 'function') {
        this.rightBuilder()
      }
    }
  }
}

@Component
export struct WebViewPage {
  pageInfos: NavPathStack = new NavPathStack();
  controller: webview.WebviewController = new webview.WebviewController();
  @Prop src: ParamType;
  @State harmony: Harmony = new Harmony()
  @State isLoading: boolean = true
  @State title: string = ''


  @Builder
  CustomNavTitle(text: string, rightBuilder?: CustomBuilder) {
    NavTitle({ text, rightBuilder })
  }

  aboutToAppear(): void {
    console.log(`${this.src}`)
  }

  build() {
    NavDestination() {
      FullLoading({
        loading: this.isLoading
      })
      Web({ src: this.src, controller: this.controller })
        .width(BaseConstants.FULL_WIDTH)
        .height(BaseConstants.FULL_HEIGHT)
        .layoutWeight(1)
        .domStorageAccess(true)
        .fileAccess(true)
        .imageAccess(true)
        .onlineImageAccess(true)
        .javaScriptAccess(true)
        .javaScriptProxy({
          object: this.harmony,
          name: 'Harmony',
          methodList: ['handleMessage'],
          controller: this.controller
        })
        .onControllerAttached(() => {
          try {
            const userAgent = this.controller.getUserAgent();
            this.controller.setCustomUserAgent(userAgent + AppConfig.customUserAgent);
          } catch (error) {
            console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
          }
        })
        .onTitleReceive((event) => {
          if (event) {
            this.title = event.title;
          }
        })
        .onPageBegin((event) => {
          // 网页开始加载时触发该回调
          this.isLoading = true
        })
        .onPageEnd((event) => {
          // 网页加载完成时触发该回调
          this.isLoading = false
          try {
            this.controller.runJavaScript(
              'setEditorContent("测试方法")', // 直接使用字符串
              (error, result) => {
                if (!error) {
                  console.info('设置成功');
                } else {
                  console.error('设置失败:', error);
                }
              }
            )
          } catch (error) {
            console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
          }
        })
        .onErrorReceive((event) => {
          // 网页加载遇到错误时触发该回调. 无网下会触发该回调
          console.error('页面加载错误: ' + event?.error?.getErrorInfo())
          this.isLoading = false
        })
      // .onHttpErrorReceive((event) => {
      //   // 网页加载资源遇到的HTTP错误（响应码>=400)时触发该回调
      // })
      // .onProgressChange((event) => {
      //   // 网页加载进度变化时触发该回调
      // })
    }
    .title(this.CustomNavTitle(this.title))
    .onBackPressed(() => {
      if (this.controller.accessBackward()) {
        this.controller.backward()
        return true
      } else {
        const popDestinationInfo = this.pageInfos.pop();
        return true;
      }
    }).onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack;
    })
  }

  onBackPress(): boolean | void {

  }
}