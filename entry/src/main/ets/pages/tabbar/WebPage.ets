import { WebViewPage } from '../web/WebView';

class Harmony {
  handleMessage(msg: string){
    console.log(msg)
  }
}

@Component
export struct WebPage {
  build() {
    Navigation() {
      WebViewPage({
        src: $rawfile("html/test.html")
      })
    }
    .padding({bottom:48})
  }
}
