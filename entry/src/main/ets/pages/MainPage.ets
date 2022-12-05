import Home from '../view/Home'

@Entry
@Component
struct MainPage {
  private tabController: TabsController = new TabsController()
  @State currentPage:number = 0

  build() {
    Tabs({
      barPosition: BarPosition.End,
      controller: this.tabController
    }) {
      //首页
      TabContent() {
        this.tabTitles($r('app.string.mainPage_tabTitles_home'))
        Home()
      }
      .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') })
      .backgroundColor($r('app.color.mainPage_backgroundColor'))
      .tabBar(this.tabBar($r("app.string.mainPage_tabTitles_home"), 0,$r('app.media.home_normal'), $r('app.media.home_selected')))

      //我的
      TabContent() {
        this.tabTitles($r('app.string.mainPage_tabTitles_mine'))
      }
      .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') })
      .backgroundColor($r('app.color.mainPage_backgroundColor'))
      .tabBar(this.tabBar($r("app.string.mainPage_tabTitles_mine"), 1,$r('app.media.mine_normal'), $r('app.media.mine_selected')))
    }
    .vertical(false)

  }

  @Builder tabBar(title: string | Resource, targetIndex: number, normalIcon: Resource, selectedIcon: Resource) {

    Column() {
      Image(this.currentPage === targetIndex ? selectedIcon : normalIcon)
        .width($r('app.float.mainPage_baseTab_size'))
        .height($r('app.float.mainPage_baseTab_size'))
      Text(title)
        .margin({ top: $r('app.float.mainPage_baseTab_top') })
        .fontSize($r('app.float.main_tab_fontSize'))
        .fontColor(this.currentPage === targetIndex ? $r('app.color.mainPage_selected') : $r('app.color.mainPage_normal'))
    }
    .margin({ top: $r('app.float.mainPage_baseTab_margin') })
    .height($r('app.float.mainPage_barHeight'))
    .width('100%')
    .onClick(() => {
      this.currentPage = targetIndex
      this.tabController.changeIndex(targetIndex)
    })
  }

  @Builder tabTitles(title: Resource) {
    Text(title)
      .fontWeight(FontWeight.Medium)
      .fontSize($r('app.float.page_title_text_size'))
      .margin({ top: $r('app.float.mainPage_tabTitles_margin') })
      .padding({ left: $r('app.float.mainPage_tabTitles_padding') })
  }
}