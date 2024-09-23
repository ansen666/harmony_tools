@Preview
@Component
export struct CodeInputView {
    @State viewSize: number = 4

    inputResultCallback!: (result:string) => void

    @Link codeKids: Array<string> //创建一个包含4个空字符串的数组，用于存储输入的数字
    @State showCaret: boolean = true
    private inputKey = "code_input"

    aboutToAppear() {
        if (this.codeKids == null) {
            this.codeKids = new Array(this.viewSize).fill('');
        }
    }

    build() {
        Stack() {
            if (this.codeKids != null) {
                Row({ space: 10 }) {
                    ForEach(this.codeKids, (item: string, index: number) => {
                        Text(item)
                            .backgroundColor("#CCFFFFFF")
                            .height("100%")
                            .layoutWeight(1)
                            .fontSize(25)
                            .textAlign(TextAlign.Center)
                            .align(Alignment.Center)
                            .borderRadius(15)
                            .focusable(false)
                            .defaultFocus(false)
                            .focusOnTouch(false)
                            .onClick(() => {
                                focusControl.requestFocus(this.inputKey)
                            })
                    }, (item: string) => item)
                }.height("100%").width("100%")

                TextInput()
                    .maxLength(this.viewSize)
                    .fontSize(25)
                    .borderRadius(15)
                    .type(InputType.Number)
                    .key(this.inputKey)
                    .onChange((value) => {
                        let a = value.split('')
                        this.codeKids.forEach((value, index) => {
                            this.codeKids[index] = a[index] || ''
                        })
                        if (a.length >= this.viewSize) {
                            this.inputResultCallback(value)
                        }
                        this.showCaret = (a.length == 0)
                    })
                    .copyOption(CopyOptions.None)
                    .caretColor(this.showCaret ? Color.Black : Color.Transparent)
                    .fontColor(Color.Transparent)
                    .backgroundColor(Color.Transparent)
                        //TODO 系统问题，如果背景色是透明的也没用，非透明可以
                        // .stateStyles({ pressed: {.backgroundColor("跟背景一样的颜色（纯透明会黑色闪一下）")}})
                    .height("100%")
                    .width("100%")
            }
        }.height(80).backgroundColor(Color.Gray)
    }
}
