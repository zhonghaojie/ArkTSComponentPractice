@Extend(TextInput) function inputStyle () {
  .placeholderColor($r('app.color.placeholder_color'))
  .backgroundColor($r("app.color.background"))
  .fontSize($r("app.float.big_text_size"))
  .width("100%")
  .margin({ top: $r("app.float.input_margin_top") })
  .padding({ left: 0 })
  .height($r("app.float.login_input_height"))
}


@Entry
@Component
struct Login {
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

      TextInput()
        .inputStyle()
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .height("100%")
  }
}