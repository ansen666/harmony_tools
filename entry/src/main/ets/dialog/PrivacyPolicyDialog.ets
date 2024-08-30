import { router } from '@kit.ArkUI'
import { AppConstant, Pages } from '../utils/AppConstant'
import { logger } from '../utils/Logger'

@CustomDialog
export default struct PrivacyPolicyDialogBackUp{
    controller: CustomDialogController

    cancel!: () => void
    confirm!: () => void

    build() {
        Column() {
            Text($r('app.string.simple_user_policy')).fontSize(18).fontColor($r('app.color.title_color')).margin({ top: 30, bottom: 19 })

            Scroll(){
                Text(){
                    Span($r('app.string.privacy_policy_start'))
                    Span($r('app.string.user_agreement_two')).fontColor($r('app.color.mainColor')).onClick(() => {
                        this.openWebUrl("/useragreement.html");
                    })
                    Span($r('app.string.and'))
                    Span($r('app.string.privacy_policy_two')).fontColor($r('app.color.mainColor')).onClick(() => {
                        this.openWebUrl("/privacypolicy.html");
                    })
                    Span($r('app.string.simple_privacy_policy'))
                }.fontSize(16).fontColor($r('app.color.body_color')).margin({
                    left:25,
                    right:25
                })
            }.height(120)

            Column(){
                Button($r('app.string.disagree_privacy_policy')).onClick(() => {
                    this.controller.close();
                    this.cancel();
                }).fontColor($r('app.color.other_color')).fontSize(15).backgroundColor(Color.Transparent)

                Button($r('app.string.agree_privacy_policy')).onClick(() => {
                    this.controller.close();
                    this.confirm();
                }).fontColor($r('app.color.white')).fontSize(17)
                    .linearGradient({
                        direction: GradientDirection.Right, colors:[[$r('app.color.start_main_color'),0.0],[$r('app.color.end_main_color'),1.0]]
                    }).width('80%').margin({
                    top:15,bottom:21
                }).borderRadius(24)
            }
        }
    }

    openWebUrl(urlSuffix:string){
        let url= AppConstant.URL+urlSuffix;
        logger.info("url:"+url)
        router.pushUrl({
            url: Pages.WebViewPage,
            params:{
                data1: 'message',
                url: url,  // 传递的 URL 参数
            }
        }, router.RouterMode.Single)
    }


}