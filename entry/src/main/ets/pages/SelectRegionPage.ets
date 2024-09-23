import { HdNav } from '../common/HdNav'
import SelectRegionDialog from '../dialog/SelectRegionDialog'

/**
 * 省市区三级联动
 * 数据来源:https://github.com/modood/Administrative-divisions-of-China/tree/master
 * @author Ansen
 * @create time 2024-09-07
 */
@Entry
@Component
struct SelectRegionPage {
    @State selectProvince:string=""
    @State selectCity:string=""

    selectRegionDialog: CustomDialogController = new CustomDialogController({
        builder: SelectRegionDialog({
            selectProvince:this.selectProvince,
            selectCity:this.selectCity,
            confirm:this.onConfirm.bind(this)
        }),
        alignment: DialogAlignment.Bottom,  // 可设置dialog的对齐方式，设定显示在底部或中间等，默认为底部显示
        cornerRadius:{
          topLeft:13,topRight:13,bottomLeft:0,bottomRight:0
        },
        autoCancel:false,
        width:'100%'
    })

    build() {
        Column(){
            HdNav({
                title:"省市区三级联动"
            })

            Text(this.selectProvince+this.selectCity).fontColor($r('app.color.title_color')).fontSize(24).margin({
                top:150
            })

            Button("选择省市区").onClick(event=>{
                this.onSelectRegion();
            }).margin({
                top:20
            })
        }
    }

    onSelectRegion(){
        this.selectRegionDialog.open();
    }

    onConfirm(province:string,city:string){
        this.selectProvince = province;
        this.selectCity = city;
    }
}