import { router } from '@kit.ArkUI'
import { Pages } from '../utils/AppConstant'

@Entry
@Component
struct Index {
    aboutToAppear(): void {

    }

    build() {
        Column() {
            Button("弹窗").onClick(event=>{
                router.pushUrl({url: Pages.DialogPage}, router.RouterMode.Single)
            })
        }
        .height('100%')
        .width('100%')
        .justifyContent(FlexAlign.Center)
    }
}