import { router } from '@kit.ArkUI'

@Component
export struct HdNav {
  @StorageProp('topHeight')
  topHeight: number = 0
  @Prop
  title: string|Resource = ''
  @Prop
  hasBorder: boolean = false

  @Prop showLeftIcon:boolean=true;

  @Prop leftIcon: ResourceStr = $r('app.media.icon_title_back')
  @Prop rightIcon: ResourceStr = $r('sys.media.ohos_ic_public_more')

  @BuilderParam titleBuilder: () => void

  @BuilderParam rightBuilder: () => void

  @Builder
  defaultMenu() {

  }

  build() {
    RelativeContainer() {
      if (this.showLeftIcon){
        Image(this.leftIcon)
          .size({ width: 34, height: 36 })
          .onClick(() => router.back())
          .padding({
            left:15,right:10,bottom:10,top:10
          }).alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center }
        })
      }

      Row() {
        if (this.title) {
          Text(this.title)
            .fontWeight(600)
            .textAlign(TextAlign.Center)
            .fontSize(18)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        } else if (this.titleBuilder) {
          this.titleBuilder()
        }
      }.alignRules({
        middle: { anchor: '__container__', align: HorizontalAlign.Center },
        center: { anchor: '__container__', align: VerticalAlign.Center }
      })

      if (this.rightBuilder) {
        Stack(){
          this.rightBuilder()
        }.padding(15).alignRules({
          right: { anchor: '__container__', align: HorizontalAlign.End },
          center: { anchor: '__container__', align: VerticalAlign.Center }
        })
      }
    }
    .height(56 + this.topHeight)
    .width('100%')
    .border({
      width: { bottom: this.hasBorder ? 0.5 : 0 },
      color: '#f3f4f5'
    }).backgroundColor($r('app.color.white'))
  }
}