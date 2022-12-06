import ItemData from '../common/bean/ItemData'
import { MainViewModel } from '../viewmodel/MainViewModel'

export class MyDataSource implements IDataSource {
  private list: any[] = []
  private listener: DataChangeListener

  isEmpty(): boolean {
    return this.list.length === 0
  }

  constructor(data: any[]) {
    this.list = data
  }

  totalCount(): number {
    return this.list.length
  }

  getData(index: number): any {
    return this.list[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    this.listener = listener
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    this.listener = null

  }
}


@Component
export default struct Home {
  private swiperImageDataSource: MyDataSource ;
  private firstGridDataSource: MyDataSource ;
  private secondGridDataSource: MyDataSource ;
  private viewModel: MainViewModel = new MainViewModel();

  aboutToAppear() {
    if (this.swiperImageDataSource == null || this.swiperImageDataSource == undefined) {
      this.swiperImageDataSource = new MyDataSource(this.viewModel.getSwiperImages())
    }
    if (this.firstGridDataSource == null || this.firstGridDataSource == undefined) {
      this.firstGridDataSource = new MyDataSource(this.viewModel.getFirstGridData())
    }
    if (this.secondGridDataSource == null || this.secondGridDataSource == undefined) {
      this.secondGridDataSource = new MyDataSource(this.viewModel.getSecondGridData())
    }
  }

  private swiperController: SwiperController = new SwiperController()

  build() {
    Scroll() {
      Column() {
        Swiper(this.swiperController) {
          LazyForEach(this.swiperImageDataSource, (item: string) => {
            Image(item).borderRadius($r('app.float.home_swiper_borderRadius'))
          }, item => item)
        }
        .margin({ top: $r('app.float.home_swiper_margin') })
        .autoPlay(true)

        Grid() {
          LazyForEach(this.firstGridDataSource, (item: ItemData) => {
            GridItem() {
              Column() {
                Image(item.img)
                  .width($r('app.float.home_homeCell_size'))
                  .height($r('app.float.home_homeCell_size'))
                Text(item.title)
                  .fontSize($r('app.float.little_text_size'))
                  .margin({ top: $r('app.float.home_homeCell_margin') })
              }
            }
          }, item => item)
        }
        .margin({top:$r('app.float.home_grid_margin')})
        .columnsTemplate('1fr 1fr 1fr 1fr')//列数
        .rowsTemplate('1fr 1fr')//行数
        .columnsGap($r('app.float.home_grid_columnsGap'))//列间距
        .rowsGap($r('app.float.home_grid_rowGap'))//行间距
        .padding({ top: $r('app.float.home_grid_padding'), bottom: $r('app.float.home_grid_padding') })
        .height($r('app.float.home_grid_height'))
        .backgroundColor(Color.White)
        .borderRadius($r('app.float.home_grid_borderRadius'))

        Text($r('app.string.home_list'))
          .fontSize($r('app.float.normal_text_size'))
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ top: $r('app.float.home_text_margin'),bottom: $r('app.float.home_text_margin')})

        Grid() {
          LazyForEach(this.secondGridDataSource, (secondItem: ItemData) => {
            GridItem() {
              Column() {
                Text(secondItem.title)
                  .fontSize($r('app.float.normal_text_size'))
                  .fontWeight(FontWeight.Medium)
                Text(secondItem.others)
                  .margin({ top: $r('app.float.home_list_margin') })
                  .fontSize($r('app.float.little_text_size'))
                  .fontColor($r('app.color.home_grid_fontColor'))
              }
              .alignItems(HorizontalAlign.Start)
            }
            .padding({ top: $r('app.float.home_list_padding'), left: $r('app.float.home_list_padding') })
            .borderRadius($r('app.float.home_backgroundImage_borderRadius'))
            .align(Alignment.TopStart)
            .backgroundImage(secondItem.img)
            .backgroundImageSize(ImageSize.Cover)
            .width('100%')
            .height('100%')
          }, secondItem => secondItem.toString())
        }
        .width('100%')
        .height($r('app.float.home_secondGrid_height'))
        .columnsTemplate('1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .columnsGap($r('app.float.home_grid_columnsGap'))
        .rowsGap($r('app.float.home_grid_rowGap'))
        .margin({ bottom: $r('app.float.setting_button_bottom')})
      }
    }

  }
}