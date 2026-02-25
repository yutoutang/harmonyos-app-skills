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
struct ArkUIComponentExample {
  // 导航回调函数
  @Param onNavigate: (pageName: string) => void = () => {}

  // 组件列表 - 完整版本，包含所有已实现的组件（按字母顺序）
  @Local componentList: ComponentItem[] = [
    // ==================== A ====================
    {
      id: 'advanced',
      name: 'Advanced 高级布局',
      description: '展示 RelativeContainer、GridContainer、WaterFlow 等高级布局',
      routeName: 'AdvancedExamplePage'
    },
    {
      id: 'alphabet_indexer',
      name: 'AlphabetIndexer 索引',
      description: '展示 AlphabetIndexer 字母索引列表',
      routeName: 'AlphabetIndexerExamplePage'
    },

    // ==================== B ====================
    {
      id: 'badge',
      name: 'Badge 徽章',
      description: '展示 Badge 徽章组件的各种用法',
      routeName: 'BadgeExamplePage'
    },
    {
      id: 'blank',
      name: 'Blank 空白填充',
      description: '展示 Blank 空白填充组件',
      routeName: 'BlankExamplePage'
    },
    {
      id: 'button',
      name: 'Button 按钮',
      description: '展示 Button 组件的多种类型和样式',
      routeName: 'ButtonExamplePage'
    },

    // ==================== C ====================
    {
      id: 'calendar_picker',
      name: 'CalendarPicker 日历选择器',
      description: '展示 CalendarPicker 日历选择器组件',
      routeName: 'CalendarPickerExamplePage'
    },
    {
      id: 'column_row',
      name: 'Column & Row 布局',
      description: '展示 Column 和 Row 布局组件的对齐、权重等效果',
      routeName: 'ColumnRowExamplePage'
    },
    {
      id: 'column_split',
      name: 'ColumnSplit 分割布局',
      description: '展示 ColumnSplit 垂直分割容器',
      routeName: 'ColumnSplitExamplePage'
    },
    {
      id: 'counter',
      name: 'Counter 计数器',
      description: '展示 Counter 计数器组件',
      routeName: 'CounterExamplePage'
    },
    {
      id: 'curves',
      name: 'Curves 曲线',
      description: '展示 Curves API 的动画曲线效果',
      routeName: 'CurvesExamplePage'
    },

    // ==================== D ====================
    {
      id: 'data',
      name: 'Data 数据展示',
      description: '展示 Gauge、LoadingProgress、DataPanel、Progress、Refresh',
      routeName: 'DataExamplePage'
    },
    {
      id: 'dialog',
      name: 'Dialog 对话框',
      description: '展示 AlertDialog、ActionSheet、CustomDialog',
      routeName: 'DialogExamplePage'
    },

    // ==================== E ====================
    {
      id: 'embedded',
      name: 'Embedded 嵌入组件',
      description: '展示 EmbeddedComponent、XComponent 嵌入式组件',
      routeName: 'EmbeddedExamplePage'
    },

    // ==================== F ====================
    {
      id: 'flow_item',
      name: 'FlowItem 瀑布流项',
      description: '展示 FlowItem 瀑布流布局项',
      routeName: 'FlowItemExamplePage'
    },
    {
      id: 'folder_stack',
      name: 'FolderStack 文件夹栈',
      description: '展示 FolderStack 文件夹堆叠效果',
      routeName: 'FolderStackExamplePage'
    },
    {
      id: 'form',
      name: 'Form 表单组件',
      description: '展示 Stepper、Counter、PatternLock、CalendarPicker',
      routeName: 'FormExamplePage'
    },
    {
      id: 'form_link',
      name: 'FormLink 表单链接',
      description: '展示 FormLink、FolderStack、NodeContainer',
      routeName: 'FormLinkExamplePage'
    },

    // ==================== G ====================
    {
      id: 'graphics',
      name: 'Graphics 图形组件',
      description: '展示 Canvas、QRCode、Hyperlink、Particle',
      routeName: 'GraphicsExamplePage'
    },
    {
      id: 'grid_col',
      name: 'GridCol 网格列',
      description: '展示 GridCol 网格列组件',
      routeName: 'GridColExamplePage'
    },
    {
      id: 'grid_container',
      name: 'GridContainer 网格容器',
      description: '展示 GridContainer 响应式网格容器',
      routeName: 'GridContainerExamplePage'
    },
    {
      id: 'grid_row',
      name: 'GridRow 网格行',
      description: '展示 GridRow 网格行组件',
      routeName: 'GridRowExamplePage'
    },

    // ==================== H ====================
    {
      id: 'indicator',
      name: 'Indicator 指示器',
      description: '展示 IndicatorComponent 指示器组件',
      routeName: 'IndicatorExamplePage'
    },
    {
      id: 'image',
      name: 'Image 图片',
      description: '展示 Image 组件的加载、填充、样式等效果',
      routeName: 'ImageExamplePage'
    },
    {
      id: 'input',
      name: 'Input 输入组件',
      description: '展示 TextInput、TextArea、Checkbox、Radio、Select',
      routeName: 'InputExamplePage'
    },

    // ==================== L ====================
    {
      id: 'layout',
      name: 'Flex/Scroll/List/Grid 布局',
      description: '展示弹性布局、滚动容器、列表和网格布局',
      routeName: 'LayoutExamplePage'
    },
    {
      id: 'list_ex',
      name: 'List Enhanced 增强列表',
      description: '展示 ListItem、ListItemGroup、GridItem、ScrollBar、SideBar',
      routeName: 'ListExExamplePage'
    },

    // ==================== M ====================
    {
      id: 'media',
      name: 'Media 媒体组件',
      description: '展示 Video、Web、ImageAnimator',
      routeName: 'MediaExamplePage'
    },
    {
      id: 'menu',
      name: 'Menu 菜单',
      description: '展示 Menu、ContextMenu、MenuItem、MenuItemGroup',
      routeName: 'MenuExamplePage'
    },

    // ==================== N ====================
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
    {
      id: 'node_container',
      name: 'NodeContainer 节点容器',
      description: '展示 NodeContainer 节点容器组件',
      routeName: 'NodeContainerExamplePage'
    },

    // ==================== O ====================

    // ==================== P ====================
    {
      id: 'panel',
      name: 'Panel 面板',
      description: '展示 Panel 滑动面板组件',
      routeName: 'PanelExamplePage'
    },
    {
      id: 'paste_button',
      name: 'PasteButton 粘贴按钮',
      description: '展示 PasteButton 粘贴按钮组件',
      routeName: 'PasteButtonExamplePage'
    },
    {
      id: 'pattern_lock',
      name: 'PatternLock 图案锁',
      description: '展示 PatternLock 图案锁组件',
      routeName: 'PatternLockExamplePage'
    },
    {
      id: 'picker',
      name: 'Picker 选择器',
      description: '展示 DatePicker、TimePicker、TextPicker',
      routeName: 'PickerExamplePage'
    },
    {
      id: 'progress',
      name: 'Progress 进度组件',
      description: '展示 Progress、LoadingProgress、Gauge 进度展示组件',
      routeName: 'ProgressExamplePage'
    },

    // ==================== R ====================
    {
      id: 'refresh',
      name: 'Refresh 下拉刷新',
      description: '展示 Refresh 下拉刷新和 DataPanel 数据面板',
      routeName: 'RefreshExamplePage'
    },
    {
      id: 'relative_container',
      name: 'RelativeContainer 相对布局',
      description: '展示 RelativeContainer 相对定位容器',
      routeName: 'RelativeContainerExamplePage'
    },
    {
      id: 'rich',
      name: 'Rich 富文本组件',
      description: '展示 RichText、RichEditor、Marquee、TextClock、TextTimer 跑马灯、时钟、计时器',
      routeName: 'RichExamplePage'
    },
    {
      id: 'rich_editor',
      name: 'RichEditor 富文本编辑器',
      description: '展示 RichEditor 富文本编辑器组件',
      routeName: 'RichEditorExamplePage'
    },
    {
      id: 'row_split',
      name: 'RowSplit 分割布局',
      description: '展示 RowSplit 水平分割容器',
      routeName: 'RowSplitExamplePage'
    },

    // ==================== S ====================
    {
      id: 'save_button',
      name: 'SaveButton 保存按钮',
      description: '展示 SaveButton 保存按钮组件',
      routeName: 'SaveButtonExamplePage'
    },
    {
      id: 'scroll_bar',
      name: 'ScrollBar 滚动条',
      description: '展示 ScrollBar 滚动条组件',
      routeName: 'ScrollBarExamplePage'
    },
    {
      id: 'search',
      name: 'Search 搜索',
      description: '展示 Search 搜索组件',
      routeName: 'SearchExamplePage'
    },
    {
      id: 'selection',
      name: 'Selection 选择组件',
      description: '展示 Toggle、Slider、Rating、Search、Progress',
      routeName: 'SelectionExamplePage'
    },
    {
      id: 'shape',
      name: 'Shape 形状组件',
      description: '展示 Divider、Blank、Badge、Circle、Ellipse、Rect、Polygon、Polyline、Path',
      routeName: 'ShapeExamplePage'
    },
    {
      id: 'sidebar',
      name: 'SideBar 侧边栏',
      description: '展示 SideBar 侧边栏组件',
      routeName: 'SideBarExamplePage'
    },
    {
      id: 'span',
      name: 'Span 文本片段',
      description: '展示 Span、ImageSpan、SymbolSpan、SymbolGlyph 文本片段',
      routeName: 'SpanExamplePage'
    },
    {
      id: 'stack',
      name: 'Stack 层叠布局',
      description: '展示 Stack 组件的层叠对齐效果',
      routeName: 'StackExamplePage'
    },
    {
      id: 'stepper',
      name: 'Stepper 步进器',
      description: '展示 Stepper 步骤导航组件',
      routeName: 'StepperExamplePage'
    },
    {
      id: 'swiper',
      name: 'Swiper 轮播组件',
      description: '展示 Swiper 轮播图、自动播放、自定义指示器、程序化控制',
      routeName: 'SwiperExamplePage'
    },

    // ==================== T ====================
    {
      id: 'tab_content',
      name: 'TabContent 标签内容',
      description: '展示 TabContent 标签页内容',
      routeName: 'TabContentExamplePage'
    },
    {
      id: 'tabs',
      name: 'Tabs 标签页',
      description: '展示 Tabs、TabContent、DatePicker、TimePicker、TextPicker',
      routeName: 'TabsExamplePage'
    },
    {
      id: 'text',
      name: 'Text 文本',
      description: '展示 Text 组件的字体、对齐、溢出等效果',
      routeName: 'TextExamplePage'
    },
    {
      id: 'textarea',
      name: 'TextArea 多行输入',
      description: '展示 TextArea 多行文本输入组件',
      routeName: 'TextAreaExamplePage'
    },

    // ==================== U ====================

    // ==================== V ====================
    {
      id: 'video',
      name: 'Video 视频播放器',
      description: '展示 Video 视频播放器组件',
      routeName: 'VideoExamplePage'
    },

    // ==================== W ====================
    {
      id: 'web',
      name: 'Web 网页容器',
      description: '展示 Web 网页容器组件',
      routeName: 'WebExamplePage'
    },
    {
      id: 'water_flow',
      name: 'WaterFlow 瀑布流',
      description: '展示 WaterFlow 瀑布流布局',
      routeName: 'WaterFlowExamplePage'
    },

    // ==================== X ====================
    {
      id: 'xcomponent',
      name: 'XComponent 原生容器',
      description: '展示 XComponent 原生 C++ 组件容器',
      routeName: 'XComponentExamplePage'
    }
  ]

  build() {
    Column() {
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

export { ArkUIComponentExample as OpenHarmonyComponentPage }
