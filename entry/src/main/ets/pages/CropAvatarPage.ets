import { picker } from '@kit.CoreFileKit';
import { CropAvatarView, CropModel } from '../component/CropAvatarView';
import { image } from '@kit.ImageKit';
import { HdNav } from '../common/HdNav';

/**
 * 参考博客：https://developer.huawei.com/consumer/cn/blog/topic/03160245819168283
 */
@Entry
@Component
export struct CropAvatarPage {
    @State pm: PixelMap | undefined = undefined;
    @State private model: CropModel = new CropModel();

    build() {
        Column() {
            HdNav({
                title:"裁剪圆形头像"
            })

            CropAvatarView({
                model: this.model,
            }).layoutWeight(1).width('100%')

            Row({space:20}){
                Button('选择图片').onClick(()=>{
                    this.openPicker()
                })

                Button('测试剪裁').onClick(async () => {
                    try {
                        this.pm = await this.model.crop(image.PixelMapFormat.RGBA_8888);
                    } catch (e) {
                        console.info(`e:${JSON.stringify(e)}`)
                    }
                })
            }.margin({
                top:10,bottom:10
            })
            Image(this.pm).width('300lpx').height('300lpx').borderRadius('150lpx')
        }
        .height('100%')
        .width('100%')
    }

    // 弹出图片选择器方法
    async openPicker() {
        try {
            // 设置图片选择器选项
            const photoSelectOptions = new picker.PhotoSelectOptions();
            // 限制只能选择一张图片
            photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
            photoSelectOptions.maxSelectNumber = 1;
            // 创建并实例化图片选择器
            const photoViewPicker = new picker.PhotoViewPicker();
            // 选择图片并获取图片URI
            let uris: picker.PhotoSelectResult = await photoViewPicker.select(photoSelectOptions);
            if (!uris || uris.photoUris.length === 0) return;
            // 获取选中图片的第一张URI
            let uri: string = uris.photoUris[0];
            this.model.setImage(uri)
                .setFrameWidth(1000)
                .setFrameRatio(1);
        } catch (e) {
            console.error('openPicker', JSON.stringify(e));
        }
    }
}