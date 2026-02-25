import { OpenHarmonyComponentPage } from './ArkUIComponentExample'

@Entry
@ComponentV2
struct Index {
  @Local navPathStack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.navPathStack) {
      OpenHarmonyComponentPage({
        onNavigate: (pageName: string) => {
          this.navPathStack.pushPathByName(pageName, null)
        }
      })
    }
    .title('ArkUI 组件示例')
    .mode(NavigationMode.Stack)
  }
}
