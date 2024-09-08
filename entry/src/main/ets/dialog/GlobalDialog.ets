
import { ComponentContent} from '@kit.ArkUI';

export class GlobalDialog {
    static contentNode:ComponentContent<GlobalDialogParam>;

    static show(context: UIContext,dialogParam: GlobalDialogParam){
        const contentNode = new ComponentContent(context, wrapBuilder(buildGlobalDialogComponent), dialogParam);
        GlobalDialog.contentNode = contentNode;
        const promptAction = context.getPromptAction()//获取context的promptAction
        promptAction.openCustomDialog(contentNode,{
            alignment: DialogAlignment.Center,
            autoCancel: false,//点击弹窗外区域是否取消弹窗
        });
    }

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
    content:string;
    onConfirm: () => void
    onCancel: () => void
    openWebUrl:(urlSuffix:string) => void
}







