import { MyDataSource } from '../view/Home';
import { MainViewModel } from '../viewmodel/MainViewModel'
import ItemData from '../common/bean/ItemData'
import prompt from '@ohos.prompt';
var a = 0

@Component
export default struct Setting {
  private viewModel: MainViewModel = new MainViewModel();
  private dataSource: MyDataSource;

  aboutToAppear() {
    if (this.dataSource === undefined) {
      this.dataSource = new MyDataSource(this.viewModel.getSettingListData())
    }
  }

  build() {
    Column() {
      this.userInfo()
      this.settingList()
      Blank()
      Button($r('app.string.setting_button'), { type: ButtonType.Capsule })
        .width('90%')
        .height($r('app.float.login_button_height'))
        .fontSize($r('app.float.normal_text_size'))
        .fontColor($r('app.color.setting_button_fontColor'))
        .fontWeight(FontWeight.Medium)
        .backgroundColor($r('app.color.setting_button_backgroundColor'))
        .margin({ bottom: $r('app.float.setting_button_bottom')})
    }.height('100%')
  }
  @Builder userInfo() {
    Row() {
      Image($r('app.media.account'))
        .width($r('app.float.setting_account_size'))
        .height($r('app.float.setting_account_size'))
      Column() {
        Text($r('app.string.setting_account_name'))
          .fontWeight(FontWeight.Bold)
          .fontSize(26)
        Text($r('app.string.setting_account_email'))
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 24 })
    }
    .margin({ top: $r('app.float.setting_account_margin') })
    .padding({ left: $r('app.float.setting_account_padding') })
    .width('100%')
    .height($r('app.float.setting_account_height'))
    .backgroundColor(Color.White)
    .borderRadius($r('app.float.setting_account_borderRadius'))
  }
  @Builder listItem(item: ItemData) {
    Row() {
      Row({ space: 12 }) {
        Image(item.img)
          .width($r('app.float.setting_size'))
          .height($r('app.float.setting_size'))
        Text(item.title)
          .fontWeight(FontWeight.Medium)
          .fontSize($r('app.float.normal_text_size'))

      }

      if (item.others === null) {
        Image($r('app.media.right_grey'))
          .width($r('app.float.setting_jump_width'))
          .height($r('app.float.setting_jump_height'))
      } else {
        Toggle({ type: ToggleType.Switch, isOn: false })
      }
    }
    .alignItems(Alignment.Center | Alignment.Start)
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .height(40)
    .padding({
      left: $r('app.float.setting_settingCell_left'),
      right: $r('app.float.setting_settingCell_right')
    })
    .onClick(()=>{
      prompt.showToast({message:item.title})
    })
  }

  @Builder settingList() {
    List({ space: 20, initialIndex: 0 }) {
      LazyForEach(this.dataSource, (item: ItemData) => {
        ListItem() {
          this.listItem(item)
        }
      })
    }
    .divider({
      strokeWidth: $r('app.float.setting_list_strokeWidth'),
      color: Color.Gray,
      startMargin: $r('app.float.setting_list_startMargin'),
      endMargin: $r('app.float.setting_list_endMargin')
    })
    .margin({ top: 12 })
    .backgroundColor(Color.White)
    .borderRadius($r('app.float.setting_list_borderRadius'))
    .width('100%')
  }


}