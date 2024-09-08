
import { TabBarItem } from '../model/TabBarItem'
import { logger } from '../utils/Logger'
import { ArktsUiPage } from './ArktsUiPage'
import { HomePage } from './HomePage'

@Entry
@Component
struct Main {
    @State activeIndex: number = 0
    @State isLandscape: boolean = false

    tabBarItems: TabBarItem[] = [
    {
        icon: $r('app.media.icon_birthday_normal'),
        selectIcon: $r('app.media.icon_birthday_select'),
        title: $r('app.string.home')
    },
    {
        icon: $r('app.media.icon_discover_normal'),
        selectIcon: $r('app.media.icon_discover_select'),
        title: $r('app.string.arkts_ui')
    }
    // ,
    // {
    //     icon: $r('app.media.icon_person_normal'),
    //     selectIcon: $r('app.media.icon_person_select'),
    //     title: $r('app.string.person')
    // }
]

    aboutToAppear(): void {
        logger.isDebug=true;//debug模式
    }

    build() {
        Tabs({
            index: this.activeIndex
        }) {
            ForEach(this.tabBarItems,(item: TabBarItem, index: number) => {
                TabContent() {
                    if (index === 0) HomePage()
                    else if (index === 1) ArktsUiPage()
                }
                .tabBar(this.TabBarBuilder(item, index))
                .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
            })
        }
        .divider({ strokeWidth: $r('app.float.border_width'), color: $r('app.color.splite_color') })
        .vertical(this.isLandscape)
        .barPosition(this.isLandscape ? BarPosition.Start : BarPosition.End)
        .onTabBarClick((index) => {
            this.activeIndex = index
        })
        .barHeight(this.isLandscape ? $r('app.float.tab_bar_item_height_lg') : $r('app.float.tab_bar_item_height_sm'))
        .scrollable(false)
    }


    @Builder
    TabBarBuilder(item: TabBarItem, index: number) {
        Column({ space: 4.5 }) {
            Image(this.activeIndex === index ? item.selectIcon : item.icon)
                .width(18)
            Text(item.title)
                .fontSize(12)
                .fontColor(this.activeIndex === index ? $r('app.color.mainColor') : $r('app.color.body_color'))
                .animation({ duration: 300 })
        }
    }
}