import { util } from '@kit.ArkTS'
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { HdNav } from '../common/HdNav';

/**
 * 选择图片/视频
 * @author Ansen
 * @create time 2024-09-07
 */
@Entry
@Component
struct SelectMediaPage {
    static readonly MAX_ALBUM_NUM=8;
    @State list:string[]=[]

    build() {
        Column(){
            HdNav({
                title:"选择图片/视频"
            })

            Flex({ wrap: FlexWrap.Wrap }){ // 子组件多行布局
                ForEach(this.list, (item:string,index) => {
                    ListItem() {
                        Stack({alignContent:Alignment.TopEnd}){
                            Image(item).width('100%').height(90).onClick(event=>{
                                this.onAlbumClick(index);
                            })
                            Image($r('app.media.icon_delete_image')).width(25).height(25).padding(5).onClick(event=>{
                                this.onDeleteAlbumImage(item,index);
                            })
                        }.width('23.5%').height(90).margin({
                            left:2,right:2,top:2,bottom:2
                        })
                    }
                }, (item:string) => util.generateRandomUUID(true))

                if (this.list.length < SelectMediaPage.MAX_ALBUM_NUM){
                    Image($r('app.media.icon_album_add')).width(90).height(90).onClick(event=>{
                        this.onSelectAlbum();
                    })
                }
            }.margin({
                top:15,bottom:15
            }).width('100%').backgroundColor($r('app.color.white'))
            .padding({
                left:10,right:10,top:5,bottom:5
            })
        }
    }

    onSelectAlbum(){
        // let preselectedUris : Array<string> = []
        // for(let album of this.list){
        //     preselectedUris.push(album.imageUrl);
        // }

        //此处获取的phAccessHelper实例为全局对象，后续使用到phAccessHelper的地方默认为使用此处获取的对象，如未添加此段代码报phAccessHelper未定义的错误请自行添加
        const photoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
        photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE; // 过滤选择媒体文件类型为IMAGE
        photoSelectOptions.maxSelectNumber = SelectMediaPage.MAX_ALBUM_NUM - this.list.length; // 选择媒体文件的最大数目
        photoSelectOptions.preselectedUris = this.list;
        // photoSelectOptions.isOriginalSupported = true;
        const photoViewPicker = new photoAccessHelper.PhotoViewPicker();
        photoViewPicker.select(photoSelectOptions).then((photoSelectResult: photoAccessHelper.PhotoSelectResult) => {
            let uris = photoSelectResult.photoUris;
            for(let uri of uris){
                this.list.push(uri);
            }
        })
    }

    onAlbumClick(index:number){

    }

    onDeleteAlbumImage(item:string,index:number){
        this.list.splice(index,1);
    }
}