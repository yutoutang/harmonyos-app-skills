import { OpenHarmonyComponentPage } from './OpenHarmonyComponentPage'
import {
  ButtonExamplePage,
  CurvesExamplePage,
  TextExamplePage,
  ImageExamplePage,
  ColumnRowExamplePage,
  StackExamplePage,
  ShapeExamplePage,
  SpanExamplePage,
  InputExamplePage,
  AdvancedExamplePage,
  SelectionExamplePage
} from 'ycomponent'

@Entry
@ComponentV2
struct Index {
  @Local navPathStack: NavPathStack = new NavPathStack()

  @Builder
  PageBuilder(name: string, params: Object) {
    if (name === 'TextExamplePage') {
      TextExamplePage()
    } else if (name === 'ImageExamplePage') {
      ImageExamplePage()
    } else if (name === 'ColumnRowExamplePage') {
      ColumnRowExamplePage()
    } else if (name === 'StackExamplePage') {
      StackExamplePage()
    } else if (name === 'ShapeExamplePage') {
      ShapeExamplePage()
    } else if (name === 'SpanExamplePage') {
      SpanExamplePage()
    } else if (name === 'InputExamplePage') {
      InputExamplePage()
    } else if (name === 'AdvancedExamplePage') {
      AdvancedExamplePage()
    } else if (name === 'SelectionExamplePage') {
      SelectionExamplePage()
    } else if (name === 'ButtonExamplePage') {
      ButtonExamplePage()
    } else if (name === 'CurvesExamplePage') {
      CurvesExamplePage()
    }
  }

  build() {
    Navigation(this.navPathStack) {
      OpenHarmonyComponentPage({
        onNavigate: (pageName: string) => {
          this.navPathStack.pushPathByName(pageName, null)
        }
      })
    }
    .navDestination(this.PageBuilder)
    .mode(NavigationMode.Stack)
  }
}
