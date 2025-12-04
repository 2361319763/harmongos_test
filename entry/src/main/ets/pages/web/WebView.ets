import { webview } from '@kit.ArkWeb';
import { BaseConstants } from 'base';
import { FullLoading } from 'base';
import { AppConfig } from '../../config/Index';

class Harmony {
  handleMessage(msg: string){
    console.log(msg)
  }
}

@Builder
export function WebViewPageBuilder(name: string, src: string) {
  WebViewPage({src: src})
}

@Component
export struct WebViewPage {
  controller: webview.WebviewController = new webview.WebviewController();
  @Prop src: string | Resource;
  @State userAgent: string = '';
  @State harmony: Harmony = new Harmony()
  @State isLoading: boolean = true

  aboutToAppear(): void {
    webview.once('webInited', () => {
      try {
        this.userAgent = this.controller.getUserAgent();
      } catch (error) {
        console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
      }
    })
  }

  build() {
    Navigation() {
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
            let userAgent = this.controller.getUserAgent() + AppConfig.customUserAgent;
            this.controller.setCustomUserAgent(userAgent);
          } catch (error) {
            console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
          }
        })
        .onPageBegin((event) => {
          // 网页开始加载时触发该回调
          this.isLoading = true
        })
        .onPageEnd((event) => {
          // 网页加载完成时触发该回调
          this.isLoading = false
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
    .padding({bottom:48})
  }

}