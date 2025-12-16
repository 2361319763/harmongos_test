import { webview } from '@kit.ArkWeb';
import { BaseConstants, StringUtils } from 'base';
import { FullLoading } from 'base';
import { AppConfig } from '../../config/Index';
import { display } from '@kit.ArkUI';
import { picker } from '@kit.CoreFileKit';

type ParamType = string | Resource

@Builder
export function WebViewPageBuilder(name: string, param: ParamType) {
  WebViewPage({src: param})
}

class Harmony {
  private controller: webview.WebviewController;
  constructor(controller: WebviewController) {
    this.controller = controller
  }
  /// JS调用ArkTS 同步方法数组,包含同步方法的方法名.
  static methodList:string[] = [
    'WebCallApp',
    'handleMessage'
  ]
  static asyncMethodList:string[] = [
    'WebTestAsync',
    'WebTest',
  ]

  WebCallApp(value: string) {

  }
  handleMessage(msg: string){
    console.log(msg)
  }
  async WebTestAsync(value: string):Promise<string>{
    return '测试 - 异步'
  }
  WebTest(value: string): Promise<string> { // 测试 - promise
    return new Promise((resolve, reject) => {
      try {
        resolve('[Callback]:你好')
      } catch (e) {
        reject('[Callback]:异常')
      }
    })
  }
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
    try {
      this.screenWidth = px2vp(display.getDefaultDisplaySync().width)
      display.on('change', () => {
        this.screenWidth = px2vp(display.getDefaultDisplaySync().width)
      })
    } catch (error) {
      console.error(`ErrorCode: ${error.code},  Message: ${error.message}`)
    }
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
  private harmony: Harmony = new Harmony(this.controller);
  private proxyName:string = 'Harmony';
  @Prop src: ParamType;
  @State isLoading: boolean = true;
  @State barHidden: boolean = false;
  @State title: string = '';


  @Builder
  CustomNavTitle(text: string, rightBuilder?: CustomBuilder) {
    NavTitle({ text, rightBuilder })
  }

  aboutToAppear(): void {
    // 获取src携带的参数
    if (typeof this.src === 'string') {
      const barHidden = StringUtils.getQueryParam(this.src, "barHidden");
      this.barHidden = barHidden === 'true';
    }
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
        .backgroundColor(Color.White)
        .multiWindowAccess(true)
        .javaScriptAccess(true)// 访问本地资源文件
        .imageAccess(true)// 权限状态开启
        .onlineImageAccess(true)// 权限状态开启
        .fileAccess(true)// 权限状态开启
        .domStorageAccess(true)// 数据存储权限
        .mediaPlayGestureAccess(true)// 媒体权限
        .mixedMode(MixedMode.All)// https 加载
        .layoutMode(WebLayoutMode.FIT_CONTENT)// 自适应布局
        .verticalScrollBarAccess(true)// 滚动条
        .horizontalScrollBarAccess(false)// 滚动条
        .cacheMode(CacheMode.Default)// 缓存
        .zoomAccess(false)// 禁止手势缩放
        .geolocationAccess(true)// 定位权限
        .javaScriptProxy({
          object: this.harmony,
          name: this.proxyName,
          // 交互对象中所涵盖的方法,支持多个.JS调用鸿蒙App端的方法,最终方法会在交互对象定义的方法中触发
          methodList: Harmony.methodList,
          // 参与注册的应用侧JavaScript对象的异步方法。但是异步方法无法获取返回值。
          asyncMethodList: Harmony.asyncMethodList,
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
          this.isLoading = true;
        })
        .onPageEnd((event) => {
          // 网页加载完成时触发该回调
          this.isLoading = false;
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
        .onProgressChange((event) => {
          // 网页加载进度变化时触发该回调
          if (event && event.newProgress > 10) {
            this.isLoading = false;
          }
        })
        .onAlert((event) => { // 提示框处理相关
          AlertDialog.show({
            title: '温馨提示',
            message: event?.message,
            confirm: {
              value: '确认',
              action: () => {
                event?.result.handleConfirm()
              }
            },
            cancel: () => {
              event?.result.handleCancel()
            }
          })
          return true;
        })
        .onConfirm((event) => { // 提示框处理相关
          AlertDialog.show({
            title: '温馨提示',
            message: event?.message,
            confirm: {
              value: '确认',
              action: () => {
                event?.result.handleConfirm()
              }
            },
            cancel: () => {
              event?.result.handleCancel()
            }
          })
          return true
        })
        .onShowFileSelector((event) => { // 文件选择处理
          console.log('MyFileUploader onShowFileSelector invoked');
          const documentSelectOptions = new picker.PhotoSelectOptions();
          let uri: string | null = null;
          const documentViewPicker = new picker.PhotoViewPicker();
          documentViewPicker.select(documentSelectOptions).then((documentSelectResult) => {
            uri = documentSelectResult[0];
            console.info('documentViewPicker.select to file succeed and uri is:' + uri);
            if (event) {
              event.result.handleFileList([uri]);
            }
          }).catch((err: BusinessError) => {
            console.error(`Invoke documentViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
          })
          return true
        })
        .onLoadIntercept((event) => {
          const url = event.data.getRequestUrl();
          if (event.data.isRedirect()) {
            console.log('[重定向]');
          }
          return false
        })
        .onErrorReceive((event) => {
          // 网页加载遇到错误时触发该回调. 无网下会触发该回调
          this.isLoading = false;
          if (event) {
            console.info('getErrorInfo:' + event.error.getErrorInfo());
            console.info('getErrorCode:' + event.error.getErrorCode());
            console.info('url:' + event.request.getRequestUrl());
            console.info('isMainFrame:' + event.request.isMainFrame());
            console.info('isRedirect:' + event.request.isRedirect());
            console.info('isRequestGesture:' + event.request.isRequestGesture());
            console.info('getRequestHeader_headerKey:' + event.request.getRequestHeader().toString());
            let result = event.request.getRequestHeader();
            console.info('The request header result size is ' + result.length);
            for (let i of result) {
              console.info('The request header key is : ' + i.headerKey + ', value is : ' + i.headerValue);
            }
          }
        })
        .onHttpErrorReceive((event) => {
          // 网页加载资源遇到的HTTP错误（响应码>=400)时触发该回调
          if (event) {
            console.info('url:' + event.request.getRequestUrl());
            console.info('isMainFrame:' + event.request.isMainFrame());
            console.info('isRedirect:' + event.request.isRedirect());
            console.info('isRequestGesture:' + event.request.isRequestGesture());
            console.info('getResponseData:' + event.response.getResponseData());
            console.info('getResponseEncoding:' + event.response.getResponseEncoding());
            console.info('getResponseMimeType:' + event.response.getResponseMimeType());
            console.info('getResponseCode:' + event.response.getResponseCode());
            console.info('getReasonMessage:' + event.response.getReasonMessage());
            let result = event.request.getRequestHeader();
            console.info('The request header result size is ' + result.length);
            for (let i of result) {
              console.info('The request header key is : ' + i.headerKey + ' , value is : ' + i.headerValue);
            }
            let resph = event.response.getResponseHeader();
            console.info('The response header result size is ' + resph.length);
            for (let i of resph) {
              console.info('The response header key is : ' + i.headerKey + ' , value is : ' + i.headerValue);
            }
          }
        })
    }
    .hideTitleBar(this.barHidden)
    .title(this.CustomNavTitle(this.title))
    .onBackPressed(() => {
      if (this.controller.accessBackward()) {
        this.controller.backward();
        return true;
      } else {
        const popDestinationInfo = this.pageInfos.pop();
        return true;
      }
    })
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack;
    })
  }
}