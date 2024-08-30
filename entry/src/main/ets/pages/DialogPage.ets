import PrivacyPolicyDialog from '../dialog/PrivacyPolicyDialog';
import { AppUtil } from '../utils/AppUtil';
import LoadingDialog from '../dialog/LoadingDialog';

@Entry
@Component
struct DialogPage {
    //参考:https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V2/ts-methods-custom-dialog-box-0000001477981237-V2
    privacyPolicyDialog: CustomDialogController = new CustomDialogController({
      builder: PrivacyPolicyDialog({
        cancel:this.onCancel.bind(this),
        confirm:this.onAgree.bind(this)
      }),
      alignment: DialogAlignment.Default,  // 可设置dialog的对齐方式，设定显示在底部或中间等，默认为底部显示
      cornerRadius:13,
      autoCancel:false
    })

    loadingDialog: CustomDialogController = new CustomDialogController({
        builder: LoadingDialog(),
        cornerRadius: 10,
        width: 110,
        autoCancel: true // 点击其他区域是否能取消
    });

    build() {
        Column({space:20}){
            Button("警告弹窗").onClick(event=>{
                this.showAlertDialog();
            })

            Button("自定义弹窗").onClick(event=>{
                this.privacyPolicyDialog.open();
            })

            Button("加载中弹窗").onClick(event=>{
                this.loadingDialog.open();
            })
        }.height('100%')
        .width('100%')
        .justifyContent(FlexAlign.Center)
    }

    //参考:https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V2/ts-methods-alert-dialog-box-0000001478341185-V2
    showAlertDialog(){
        AlertDialog.show({
            title:"弹窗标题",
            message:"这是弹窗内容",
            autoCancel:true,//点击遮障层时，是否关闭弹窗。默认值：true
            alignment: DialogAlignment.Center,//弹窗在竖直方向上的对齐方式。默认值：DialogAlignment.Default
            primaryButton: {
                value: "取消",
                fontColor: '#181818',
                action: () => {
                    AppUtil.showToast("点击了取消按钮");
                }
            },
            secondaryButton: {
                value: "确定",
                fontColor: $r('app.color.mainColor'),
                action: () => {
                    AppUtil.showToast("点击了确定按钮");
                }
            },
            cornerRadius:12,//弹窗边框弧度
            width:'80%', //弹窗宽度
            cancel:()=>{
                AppUtil.showToast("点击遮障层关闭dialog时的回调");
            }
        })
    }

    onCancel():void {
        AppUtil.showToast("拒绝隐私政策");
    }

    onAgree():void {//同意隐私政策
        AppUtil.showToast("同意隐私政策");
    }
}