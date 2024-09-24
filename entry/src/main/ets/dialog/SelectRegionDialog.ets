
import { AppUtil } from '../utils/AppUtil';

@CustomDialog
export default struct SelectRegionDialog {
    controller: CustomDialogController

    map: Map<string, string[]> = new Map<string, string[]>();//省市数据

    @State selectProvince:string=''//选择的省份
    selectCity:string=''//选中的城市

    confirm!: (province:string,city:string) => void //确定按钮点击回调

    aboutToAppear(): void {
        this.initData();
    }

    build() {
        Column(){
            Row(){
                Button("取消").onClick(event=>{
                    this.controller.close();
                })
                Blank().layoutWeight(1)
                Button("确定").onClick(event=>{
                    this.confirm(this.selectProvince,this.selectCity);
                    this.controller.close();
                })
            }.margin({
                left:15,right:15,top:30
            })

            Row(){
                TextPicker({ range: this.getProvinceStrList(), value: this.selectProvince })
                    .onChange((value: string|string[], index: number| number[]) => {
                        this.selectProvince = Array.isArray(value) ? value[0] : value;

                        //省份改变，默认选择第一个城市
                        let cityList=this.map.get(this.selectProvince);
                        if (cityList != null && cityList?.length>0){
                            this.selectCity = cityList[0];
                        }
                    }).width('50%')
                    .canLoop(false)//是否循环
                    .textStyle({
                    color:'#888888'
                }).selectedTextStyle({
                    color:$r('app.color.title_color')
                })

                TextPicker({ range: this.getCityStrList(), value: this.selectCity })
                    .onChange((value: string|string[], index: number| number[]) => {
                        this.selectCity = Array.isArray(value) ? value[0] : value;
                    }).width('50%').canLoop(false).textStyle({
                    color:'#888888'
                }).selectedTextStyle({
                    color:$r('app.color.title_color')
                })
            }.margin({
                top:30,bottom:30
            })
        }
    }

    initData(){
        let result=AppUtil.getRawFileContent(this,'pc.json');
        let jsonObj: Record<string, Object> = JSON.parse(result);
        let newMap: Map<string, object> = new Map<string, object>(Object.entries(jsonObj));

        newMap.forEach((value, key) => {
            let valueData = value as string[];
            this.map.set(key,valueData);
        })
    }

    getProvinceStrList(){
        let keysArray: string[] = Array.from(this.map.keys());
        return keysArray;
    }

    getCityStrList(){
        let cityList=this.map.get(this.selectProvince);
        return cityList;
    }
}