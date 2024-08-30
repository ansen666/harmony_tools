
@CustomDialog
export default struct LoadingDialog {
    controller: CustomDialogController

    private loadingText: string|Resource = "加载中..."
    @State angle:number = 10

    aboutToAppear(){
        setTimeout(()=>{
            this.angle = 1440 // 设定一个大的旋转角度，确保动画执行
        },100)
    }

    build() {
        Column(){
            Image($r('app.media.icon_loading_3'))
                .width(70)
                .height(70)
                .rotate({angle:this.angle})
                .animation({
                    duration: 5000,
                    curve: Curve.Linear,
                    delay: 0,
                    iterations: -1, // 设置-1表示动画无限循环
                    playMode: PlayMode.Normal
                })


            Text(this.loadingText).fontSize(14).fontColor(0xffffff).margin({top:10})
        }.backgroundColor(0x88000000).borderRadius(10).padding({
            left:20,right:20,top:10,bottom:10
        })
    }
}