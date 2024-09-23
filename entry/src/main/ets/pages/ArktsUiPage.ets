import { CodeInputView } from '../component/CodeInputView'

@Component
export struct ArktsUiPage {
    @State codeKids: Array<string> = new Array(4).fill('');

    build() {
        Column() {
            Text("验证码输入框")
            CodeInputView({
                codeKids:this.codeKids,
                inputResultCallback:this.inputResultCallback.bind(this)
            }).margin({
                top:10
            }).width('90%').height(50)
        }
        .height('100%')
        .width('100%')
        .justifyContent(FlexAlign.Center);
    }

    inputResultCallback(result:string){
        console.log("result:"+result)
    }
}