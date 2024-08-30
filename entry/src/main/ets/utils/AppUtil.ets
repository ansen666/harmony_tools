import { pasteboard } from '@kit.BasicServicesKit';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { promptAction } from '@kit.ArkUI';
import { systemShare } from '@kit.ShareKit';
import { common, Want, wantConstant } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { uniformTypeDescriptor as utd } from '@kit.ArkData';
import fileuri from '@ohos.file.fileuri';

export class AppUtil{
    static getString(component: Object,resource: ResourceStr){
        if (typeof resource === 'string') {//如果是字符串类型，直接返回
            return resource;
        }
        return getContext(component).resourceManager.getStringSync(resource);
    }

    //复制字符串
    static copy(content: string){
        let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN,content);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        systemPasteboard.setDataSync(pasteData)
    }

    /**
     * md5 加密
     * @param source
     * @returns
     */
    static md5(content: string){
        // 创建一个MD5哈希对象
        let md5 = cryptoFramework.createMd('MD5');
        md5.updateSync({
            data: AppUtil.stringToUint8Array(content)
        })
        let out=md5.digestSync()
        let str = AppUtil.uint8ArrayToHexString(out.data);
        return str
    }

    /**
     * uint8Array 转换为 hex字符串
     * @param uint8Array
     * @returns
     */
    private static uint8ArrayToHexString(uint8Array: Uint8Array): string {
        return Array.from(uint8Array).map(byte => byte.toString(16).padStart(2, '0')).join('');
    }

    private static stringToUint8Array(str: string): Uint8Array {
        const utf8 = unescape(encodeURIComponent(str));
        const arr = new Uint8Array(utf8.length);
        for (let i = 0; i < utf8.length; i++) {
            arr[i] = utf8.charCodeAt(i);
        }
        return arr;
    }

    static showToast(message:string | Resource){
        promptAction.showToast({message:message})
    }

    //分享文本给系统
    static shareText(content: string){
        // 构造ShareData，需配置一条有效数据信息
        let data: systemShare.SharedData = new systemShare.SharedData({
            utd: utd.UniformDataType.PLAIN_TEXT,
            content: content
        });

        // 构建ShareController
        let controller: systemShare.ShareController = new systemShare.ShareController(data);
        // 获取UIAbility上下文对象
        let context: common.UIAbilityContext = getContext() as common.UIAbilityContext;
        hilog.error(0, 'ansen', "开始分享");
        // 进行分享面板显示
        controller.show(context, {
            previewMode: systemShare.SharePreviewMode.DETAIL,
            selectionMode: systemShare.SelectionMode.SINGLE
        });
    }

    static shareFile(filePath:string){
        // 将沙箱路径转换为uri
        let uri = fileuri.getUriFromPath(filePath);
        let want:Want = {
            // 配置被分享文件的读写权限，例如对被分享应用进行读写授权
            flags: wantConstant.Flags.FLAG_AUTH_WRITE_URI_PERMISSION | wantConstant.Flags.FLAG_AUTH_READ_URI_PERMISSION,
            // 配置分享应用的隐式拉起规则
            action: 'ohos.want.action.sendData',
            uri: uri,
            type: '*/*'
        }
        let context = getContext() as common.UIAbilityContext;
        context.startAbility(want) .then(() => {
            console.info('Invoke getCurrentBundleStats succeeded.');
        })
            .catch(() => {
                // console.error(`Invoke startAbility failed, code is ${err.code}, message is ${err.message}`);
            });
    }
}