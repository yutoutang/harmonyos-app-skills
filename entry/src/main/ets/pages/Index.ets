import { OpenHarmonyComponentPage } from './ArkUIComponentExample'
import { AkrUIKitExample } from './AkrUIKitExample'

@Entry
@ComponentV2
struct Index {
  @Local navPathStack: NavPathStack = new NavPathStack()
  @Local currentTab: number = 0
  @Local tabController: TabsController = new TabsController()

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabController }) {
      // Tab 1: ArkUI 组件示例
      TabContent() {
        Navigation(this.navPathStack) {
          OpenHarmonyComponentPage({
            onNavigate: (pageName: string) => {
              this.navPathStack.pushPathByName(pageName, null)
            }
          })
        }
        .title('ArkUI 组件')
        .mode(NavigationMode.Stack)
      }
      .tabBar(this.TabBuilder('组件', 0, $r('app.media.startIcon'), $r('app.media.startIcon')))

      // Tab 2: HMS Kit 示例
      TabContent() {
        Navigation(this.navPathStack) {
          AkrUIKitExample({
            onNavigate: (pageName: string) => {
              this.navPathStack.pushPathByName(pageName, null)
            }
          })
        }
        .title('HMS Kit')
        .mode(NavigationMode.Stack)
      }
      .tabBar(this.TabBuilder('Kit', 1, $r('app.media.startIcon'), $r('app.media.startIcon')))
    }
    .barMode(BarMode.Fixed)
    .onChange((index: number) => {
      this.currentTab = index
    })
    .width('100%')
    .height('100%')
  }

  @Builder
  TabBuilder(title: string, targetIndex: number, selectedIcon: Resource, normalIcon: Resource) {
    Column() {
      Image(this.currentTab === targetIndex ? selectedIcon : normalIcon)
        .width(24)
        .height(24)
      Text(title)
        .fontSize(12)
        .fontColor(this.currentTab === targetIndex ? '#007AFF' : '#8E8E93')
        .fontWeight(this.currentTab === targetIndex ? FontWeight.Medium : FontWeight.Normal)
        .margin({ top: 4 })
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentTab = targetIndex
      this.tabController.changeIndex(targetIndex)
    })
  }
}
