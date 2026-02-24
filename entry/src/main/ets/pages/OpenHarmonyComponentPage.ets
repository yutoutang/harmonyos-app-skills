/**
 * OpenHarmony Component Examples Page
 * 鸿蒙原生组件示例页面
 *
 * 展示各种 OpenHarmony 原生组件的使用示例
 */

/**
 * 组件项数据接口
 */
interface ComponentItem {
  id: string
  name: string
  description: string
  routeName: string
}

@Entry
@ComponentV2
struct OpenHarmonyComponentPage {
  // 导航回调函数
  @Param onNavigate: (pageName: string) => void = () => {}

  // 组件列表 - 完整版本，包含所有已实现的组件
  @Local componentList: ComponentItem[] = [
    // ==================== 基础组件 ====================
    {
      id: 'text',
      name: 'Text 文本',
      description: '展示 Text 组件的字体、对齐、溢出等效果',
      routeName: 'TextExamplePage'
    },
    {
      id: 'image',
      name: 'Image 图片',
      description: '展示 Image 组件的加载、填充、样式等效果',
      routeName: 'ImageExamplePage'
    },
    {
      id: 'button',
      name: 'Button 按钮',
      description: '展示 Button 组件的多种类型和样式',
      routeName: 'ButtonExamplePage'
    },
    {
      id: 'span',
      name: 'Span 文本片段',
      description: '展示 Span、ImageSpan、SymbolSpan、SymbolGlyph 文本片段',
      routeName: 'SpanExamplePage'
    },

    // ==================== 布局组件 ====================
    {
      id: 'column_row',
      name: 'Column & Row 布局',
      description: '展示 Column 和 Row 布局组件的对齐、权重等效果',
      routeName: 'ColumnRowExamplePage'
    },
    {
      id: 'stack',
      name: 'Stack 层叠布局',
      description: '展示 Stack 组件的层叠对齐效果',
      routeName: 'StackExamplePage'
    },
    {
      id: 'layout',
      name: 'Flex/Scroll/List/Grid 布局',
      description: '展示弹性布局、滚动容器、列表和网格布局',
      routeName: 'LayoutExamplePage'
    },
    {
      id: 'advanced',
      name: 'Advanced 高级布局',
      description: '展示 RelativeContainer、GridContainer、WaterFlow 等高级布局',
      routeName: 'AdvancedExamplePage'
    },
    {
      id: 'column_split',
      name: 'ColumnSplit 分割布局',
      description: '展示 ColumnSplit 垂直分割容器',
      routeName: 'ColumnSplitExamplePage'
    },
    {
      id: 'row_split',
      name: 'RowSplit 分割布局',
      description: '展示 RowSplit 水平分割容器',
      routeName: 'RowSplitExamplePage'
    },
    {
      id: 'water_flow',
      name: 'WaterFlow 瀑布流',
      description: '展示 WaterFlow 瀑布流布局',
      routeName: 'WaterFlowExamplePage'
    },

    // ==================== 形状组件 ====================
    {
      id: 'shape',
      name: 'Shape 形状组件',
      description: '展示 Divider、Blank、Badge、Circle、Ellipse、Rect、Polygon、Polyline、Path',
      routeName: 'ShapeExamplePage'
    },

    // ==================== 输入组件 ====================
    {
      id: 'input',
      name: 'Input 输入组件',
      description: '展示 TextInput、TextArea、Checkbox、Radio、Select',
      routeName: 'InputExamplePage'
    },
    {
      id: 'textarea',
      name: 'TextArea 多行输入',
      description: '展示 TextArea 多行文本输入组件',
      routeName: 'TextAreaExamplePage'
    },
    {
      id: 'select',
      name: 'Select 下拉选择',
      description: '展示 Select 下拉选择组件',
      routeName: 'SelectExamplePage'
    },
    {
      id: 'search',
      name: 'Search 搜索',
      description: '展示 Search 搜索组件',
      routeName: 'SearchExamplePage'
    },
    {
      id: 'alphabet_indexer',
      name: 'AlphabetIndexer 索引',
      description: '展示 AlphabetIndexer 字母索引列表',
      routeName: 'AlphabetIndexerExamplePage'
    },

    // ==================== 选择组件 ====================
    {
      id: 'selection',
      name: 'Selection 选择组件',
      description: '展示 Toggle、Slider、Rating、Search、Progress',
      routeName: 'SelectionExamplePage'
    },
    {
      id: 'form',
      name: 'Form 表单组件',
      description: '展示 Stepper、Counter、PatternLock、CalendarPicker',
      routeName: 'FormExamplePage'
    },
    {
      id: 'counter',
      name: 'Counter 计数器',
      description: '展示 Counter 计数器组件',
      routeName: 'CounterExamplePage'
    },

    // ==================== 进度和数据展示 ====================
    {
      id: 'data',
      name: 'Data 数据展示',
      description: '展示 Gauge、LoadingProgress、DataPanel、Progress、Refresh',
      routeName: 'DataExamplePage'
    },
    {
      id: 'progress',
      name: 'Progress 进度组件',
      description: '展示 Progress、LoadingProgress、Gauge 进度展示组件',
      routeName: 'ProgressExamplePage'
    },
    {
      id: 'refresh',
      name: 'Refresh 下拉刷新',
      description: '展示 Refresh 下拉刷新和 DataPanel 数据面板',
      routeName: 'RefreshExamplePage'
    },

    // ==================== 媒体组件 ====================
    {
      id: 'media',
      name: 'Media 媒体组件',
      description: '展示 Video、Web、ImageAnimator',
      routeName: 'MediaExamplePage'
    },

    // ==================== 富文本组件 ====================
    {
      id: 'rich',
      name: 'Rich 富文本组件',
      description: '展示 RichText、RichEditor、Marquee、TextClock、TextTimer',
      routeName: 'RichExamplePage'
    },

    // ==================== 导航组件 ====================
    {
      id: 'nav_router',
      name: 'NavRouter 路由',
      description: '展示 NavRouter 路由导航',
      routeName: 'NavRouterExamplePage'
    },
    {
      id: 'navigator',
      name: 'Navigator 导航器',
      description: '展示 Navigator 组件导航',
      routeName: 'NavigatorExamplePage'
    },

    // ==================== 标签页和选择器 ====================
    {
      id: 'tabs',
      name: 'Tabs 标签页',
      description: '展示 Tabs、TabContent、DatePicker、TimePicker、TextPicker',
      routeName: 'TabsExamplePage'
    },
    {
      id: 'tab_content',
      name: 'TabContent 标签内容',
      description: '展示 TabContent 标签页内容',
      routeName: 'TabContentExamplePage'
    },
    {
      id: 'picker',
      name: 'Picker 选择器',
      description: '展示 DatePicker、TimePicker、TextPicker',
      routeName: 'PickerExamplePage'
    },

    // ==================== 列表组件 ====================
    {
      id: 'list_ex',
      name: 'List Enhanced 增强列表',
      description: '展示 ListItem、ListItemGroup、GridItem、ScrollBar、SideBar',
      routeName: 'ListExExamplePage'
    },
    {
      id: 'sidebar',
      name: 'SideBar 侧边栏',
      description: '展示 SideBar 侧边栏组件',
      routeName: 'SideBarExamplePage'
    },

    // ==================== 轮播和动画 ====================
    {
      id: 'curves',
      name: 'Curves 曲线',
      description: '展示 Curves API 的动画曲线效果',
      routeName: 'CurvesExamplePage'
    },
    {
      id: 'swiper',
      name: 'Swiper 轮播组件',
      description: '展示 Swiper 轮播图、自动播放、自定义指示器、程序化控制',
      routeName: 'SwiperExamplePage'
    },

    // ==================== 对话框和菜单 ====================
    {
      id: 'dialog',
      name: 'Dialog 对话框',
      description: '展示 AlertDialog、ActionSheet、CustomDialog',
      routeName: 'DialogExamplePage'
    },
    {
      id: 'menu',
      name: 'Menu 菜单',
      description: '展示 Menu、ContextMenu、MenuItem、MenuItemGroup',
      routeName: 'MenuExamplePage'
    },

    // ==================== 工具组件 ====================
    {
      id: 'blank',
      name: 'Blank 空白填充',
      description: '展示 Blank 空白填充组件',
      routeName: 'BlankExamplePage'
    },
    {
      id: 'indicator',
      name: 'Indicator 指示器',
      description: '展示 IndicatorComponent、PasteButton、SaveButton',
      routeName: 'IndicatorExamplePage'
    },

    // ==================== 高级组件 ====================
    {
      id: 'graphics',
      name: 'Graphics 图形组件',
      description: '展示 Canvas、QRCode、Hyperlink、Particle',
      routeName: 'GraphicsExamplePage'
    },
    {
      id: 'form_link',
      name: 'FormLink 表单链接',
      description: '展示 FormLink、FolderStack、NodeContainer',
      routeName: 'FormLinkExamplePage'
    },
    {
      id: 'embedded',
      name: 'Embedded 嵌入组件',
      description: '展示 EmbeddedComponent、XComponent 嵌入式组件',
      routeName: 'EmbeddedExamplePage'
    }
  ]

  build() {
    Column() {
      // 页面标题
      this.HeaderBuilder()

      // 组件列表
      Scroll() {
        Column({ space: 12 }) {
          ForEach(this.componentList, (item: ComponentItem) => {
            this.ComponentCardBuilder(item)
          }, (item: ComponentItem) => item.id)
        }
        .width('100%')
        .padding({ left: 16, right: 16, bottom: 16 })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  /**
   * 页面头部构建器
   */
  @Builder
  HeaderBuilder() {
    Column() {
      Text('OpenHarmony 原生组件')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Text('探索鸿蒙系统原生 UI 组件的使用方法')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }

  /**
   * 组件卡片构建器
   */
  @Builder
  ComponentCardBuilder(item: ComponentItem) {
    Column() {
      Row() {
        Column({ space: 8 }) {
          Text(item.name)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')

          Text(item.description)
            .fontSize(14)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text('\uE6E0') // 右箭头图标
          .fontSize(20)
          .fontColor('#CCCCCC')
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .onClick(() => {
      this.navigateToComponentPage(item)
    })
  }

  /**
   * 导航到组件示例页面
   * 使用 HarmonyOS 6.0 Navigation 路由系统
   */
  navigateToComponentPage(item: ComponentItem) {
    // 通过回调触发导航
    this.onNavigate(item.routeName)
  }
}

export { OpenHarmonyComponentPage }
