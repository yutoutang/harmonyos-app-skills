import { OpenHarmonyComponentPage } from './OpenHarmonyComponentPage'

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
    .title('OpenHarmony 组件示例')
    .mode(NavigationMode.Stack)
  }
}
