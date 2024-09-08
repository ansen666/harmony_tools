

import { AppUtil } from '../utils/AppUtil'

@Component
export default struct PrivacyPolicyDialogTwo{
    cancel!: () => void
    confirm!: () => void

    build() {
        Stack(){
            Column() {
                Text($r('app.string.simple_user_policy')).fontSize(18).fontColor($r('app.color.title_color')).margin({ top: 30, bottom: 19 })

                Scroll(){
                    Text(){
                        Span($r('app.string.privacy_policy_start'))
                        Span($r('app.string.user_agreement_two')).fontColor($r('app.color.mainColor')).onClick(() => {
                            AppUtil.openWebUrl("/useragreement.html");
                        })
                        Span($r('app.string.and'))
                        Span($r('app.string.privacy_policy_two')).fontColor($r('app.color.mainColor')).onClick(() => {
                            AppUtil.openWebUrl("/privacypolicy.html");
                        })
                        Span($r('app.string.simple_privacy_policy'))
                    }.fontSize(16).fontColor($r('app.color.body_color')).margin({
                        left:25,
                        right:25
                    })
                }.height(120)

                Column(){
                    Button($r('app.string.disagree_privacy_policy')).onClick(() => {
                        this.cancel();
                    }).fontColor($r('app.color.other_color')).fontSize(15).backgroundColor(Color.Transparent)

                    Button($r('app.string.agree_privacy_policy')).onClick(() => {
                        this.confirm();
                    }).fontColor($r('app.color.white')).fontSize(17)
                        .linearGradient({
                            direction: GradientDirection.Right, colors:[[$r('app.color.start_main_color'),0.0],[$r('app.color.end_main_color'),1.0]]
                        }).width('80%').margin({
                        top:15,bottom:21
                    }).borderRadius(24)
                }
            }.backgroundColor($r('app.color.white')).borderRadius(13).width('80%')
        }.width('100%')
        .height('100%').backgroundColor("#4D000000")//黑色背景 透明度约为 30%
    }
}