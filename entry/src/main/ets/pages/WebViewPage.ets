
import webView from '@ohos.web.webview'
import { router } from '@kit.ArkUI';
import { HdNav } from '../common/HdNav';
import { logger } from '../utils/Logger';

@Entry
@Component
struct WebViewPage {
    @State  url:string = "";
    @State title:string|undefined = "";

    controller: webView.WebviewController = new webView.WebviewController()

    aboutToAppear(): void {
        let  params = router.getParams() as Record<string,Object>
        this.url=params["url"] as string;
        // this.title=params["title"] as Resource;
        logger.info("传递过来的url："+this.url)
    }

    build() {
        Column() {
            HdNav({
                title:this.title
            })

            Web({ src: this.url, controller: this.controller })
                .javaScriptAccess(true)
                .onTitleReceive((event) => {
                    this.title = event?.title;
            }).layoutWeight(1).onLoadIntercept(event=>{
                let url = event.data.getRequestUrl();
                console.log('可以在这里拦截请求 url:' + event.data.getRequestUrl());
                return false;
            })

        }.justifyContent(FlexAlign.Start)
    }
}

class testClass {
    constructor() {
    }

    test(): string {
        return "ArkUI Web Component";
    }

    toString(): void {
        console.log('Web Component toString');
    }
}