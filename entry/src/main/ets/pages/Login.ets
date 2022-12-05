import prompt from '@ohos.prompt';
import router from '@ohos.router';


/**
 * 输入框样式
 */
@Extend(TextInput) function inputStyle () {
  .placeholderColor($r('app.color.placeholder_color'))
  .height($r('app.float.login_input_height'))
  .fontSize($r('app.float.big_text_size'))
  .backgroundColor($r('app.color.background'))
  .width('100%')
  .padding({ left: 0 })
  .margin({ top: $r('app.float.input_margin_top') })
};

/**
 * 分割线样式
 */
@Extend(Line) function lineStyle () {
  .width('100%')
  .height(1)
  .backgroundColor($r("app.color.line_color"))
}

/**
 * 蓝字样式
 */
@Extend(Text) function blueTextStyle () {
  .fontColor($r('app.color.login_blue_text_color'))
  .fontSize($r("app.float.small_text_size"))
  .fontWeight(FontWeight.Medium)
  .padding({ top: $r('app.float.forgot_margin_top'), bottom: $r('app.float.forgot_margin_top') })
}

@Entry
@Component
struct Login {

  @State isShowLoading:boolean = false//是否显示loading组件
  @State account:string = ""//用户名
  @State password:string = ""//密码
  private timeOutId = null//延时任务，模拟请求接口
  /**
   * 登陆
   */
  login(){
//    if(this.account === "" || this.password===""){
//      prompt.showToast({
//        message: $r('app.string.input_empty_tips')
//      })
//      return
//    }
    this.isShowLoading = true
    if(this.timeOutId === null){
      this.timeOutId = setTimeout(()=>{
        this.isShowLoading = false
        this.timeOutId = null
        prompt.showToast({
          message: "登陆成功"
        })
        router.replace({
          url:'pages/MainPage'
        })
      },2000)
    }

  }

  /**
   * 自定义ImageButton
   * @param src 图片
   */
  @Builder imageButton(src: Resource) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Image(src)
    }
    .height($r('app.float.other_login_image_size'))
    .width($r('app.float.other_login_image_size'))
    .backgroundColor($r('app.color.background'))
  }

  build() {
    Column() {
      Image($r('app.media.logo'))
        .width($r('app.float.logo_image_size'))
        .height($r('app.float.logo_image_size'))
        .margin({ top: $r('app.float.logo_margin_top'), bottom: $r('app.float.logo_margin_bottom') })
      Text($r("app.string.login_page"))
        .fontSize($r("app.float.page_title_text_size"))
        .fontColor($r('app.color.title_text_color'))
        .fontWeight(FontWeight.Medium)
      Text($r("app.string.login_more"))
        .fontSize($r('app.float.normal_text_size'))
        .fontColor($r('app.color.login_more_text_color'))
        .margin({ bottom: $r('app.float.login_more_margin_bottom'), top: $r('app.float.login_more_margin_top') })

      TextInput({ placeholder: $r('app.string.account') })
        .maxLength(11)
        .type(InputType.Number)
        .inputStyle()
        .onChange((value)=>{
          this.account = value
        })
      Line().lineStyle()

      TextInput({ placeholder: $r('app.string.password') })
        .maxLength(8)
        .type(InputType.Password)
        .inputStyle()
        .onChange((value)=>{
          this.password = value
        })
      Line().lineStyle()

      Row() {
        Text($r("app.string.message_login")).blueTextStyle()
        Text($r("app.string.forgot_password")).blueTextStyle()
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)


      Button($r('app.string.login'), { type: ButtonType.Capsule })
        .width("90%")
        .height($r('app.float.login_button_height'))
        .fontSize($r('app.float.normal_text_size'))
        .fontWeight(FontWeight.Medium)
        .backgroundColor($r('app.color.login_button_color'))
        .margin({ top: $r('app.float.login_button_margin_top'), bottom: $r('app.float.login_button_margin_bottom') })
        .onClick(() => {
          this.login()
        })

      if(this.isShowLoading){
        LoadingProgress()
          .color($r('app.color.loading_color'))
          .width($r('app.float.login_progress_size'))
          .height($r('app.float.login_progress_size'))
          .margin({ top: $r('app.float.login_progress_margin_top') })
      }
      Blank()
      Text($r('app.string.other_login_method'))
        .fontColor($r('app.color.other_login_text_color'))
        .fontSize($r('app.float.little_text_size'))
        .fontWeight(FontWeight.Medium)
        .margin({ top: $r('app.float.other_login_margin_top'), bottom: $r('app.float.other_login_margin_bottom') })

      Row({ space: 44 }) {
        this.imageButton($r('app.media.login_method1'))
        this.imageButton($r('app.media.login_method2'))
        this.imageButton($r('app.media.login_method3'))
      }
    }
    .backgroundColor($r('app.color.background'))
    .padding({
      left: $r('app.float.page_padding_hor'),
      right: $r('app.float.page_padding_hor'),
      bottom: $r('app.float.login_page_padding_bottom')
    })
    .width('100%')
    .height("100%")
  }
}