
import { ComponentContent} from '@kit.ArkUI';

export class GlobalDialog {
    static contentNode:ComponentContent<GlobalDialogParam>;

    //显示弹窗
    static show(context: UIContext,dialogParam: GlobalDialogParam){
        //ComponentContent对象有三个参数
        //参数1:UI 上下文
        //参数2：使用 wrapBuilder 包装 buildGlobalDialogComponent 函数，这个函数用于构建对话框的实际内容
        //参数3:传递给对话框的参数，包含内容文本和按钮的回调函数
        GlobalDialog.contentNode = new ComponentContent(context, wrapBuilder(buildGlobalDialogComponent), dialogParam);

        const promptAction = context.getPromptAction()//通过 context 获取 promptAction，用于操作对话框显示

        //显示弹窗
        promptAction.openCustomDialog(GlobalDialog.contentNode,{
            alignment: DialogAlignment.Center,//对话框在屏幕中央显示
            autoCancel: false,//点击弹窗外区域是否取消弹窗
        });
    }

    //关闭弹窗
    static close(context: UIContext){
        const promptAction = context.getPromptAction()
        promptAction.closeCustomDialog(GlobalDialog.contentNode)
    }
}

@Builder function buildGlobalDialogComponent(param: GlobalDialogParam){
    Column() {
        Text(param.content).fontSize(17).fontColor("#181818").lineHeight(24).margin({
            bottom:29,top:29,left:31,right:31
        })

        Divider().color("#D8D8D8").height(0.5)
        RowSplit() {
            Text("取消").fontSize(17).fontColor("#181818").fontWeight(FontWeight.Bold).onClick(event=>{
                param.onCancel();
            }).textAlign(TextAlign.Center).padding({
                top:15,bottom:15
            }).width('50%')

            Text("确定").fontSize(17).fontColor($r('app.color.mainColor')).fontWeight(FontWeight.Bold).onClick(event=>{
                param.onConfirm();
            }).textAlign(TextAlign.Center).padding({
                top:15,bottom:15
            }).width('50%')
        }
    }.backgroundColor($r('app.color.white')).width('80%').borderRadius(12)
}

interface GlobalDialogParam {
    content:string;//弹窗显示内容
    onConfirm: () => void //确认按钮的回调函数
    onCancel: () => void // 取消按钮的回调函数
}







