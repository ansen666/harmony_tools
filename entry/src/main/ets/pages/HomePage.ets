import { router } from '@kit.ArkUI'
import { Pages } from '../utils/AppConstant'

@Component
export struct HomePage {
    build() {
        Column({space:10}) {
            Button("弹窗").onClick(event=>{
                router.pushUrl({url: Pages.DialogPage}, router.RouterMode.Single)
            })

            Button("选择图片/视频").onClick(event=>{
                router.pushUrl({url: Pages.SelectMediaPage}, router.RouterMode.Single)
            })

            Button("头像裁剪圆形遮罩").onClick(event=>{
                router.pushUrl({url: Pages.CropAvatarPage}, router.RouterMode.Single)
            })
        }
        .height('100%')
        .width('100%')
        .justifyContent(FlexAlign.Center)
    }
}