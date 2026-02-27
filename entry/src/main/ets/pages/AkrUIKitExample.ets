/**
 * HarmonyOS HMS Kit 示例导航页面
 *
 * 展示所有 50 个 HarmonyOS HMS Kit 的使用示例
 */

/**
 * Kit 项数据接口
 */
export interface KitItem {
  id: string
  name: string
  englishName: string
  description: string
  routeName: string
  category: string
  isDeprecated?: boolean
  replaceWith?: string
}

@ComponentV2
export struct AkrUIKitExample {
  // 导航回调函数
  @Param onNavigate: (pageName: string) => void = () => {}

  // 当前搜索关键词
  @Local searchKeyword: string = ''

  // 当前选择的分类
  @Local selectedCategory: string = 'all'

  // 分类列表
  @Local categories: string[] = ['all', 'account', 'ai', 'media', 'network', 'system', 'ui', 'other']

  // 分类名称映射
  private categoryNames: Record<string, string> = {
    'all': '全部',
    'account': '账号与认证',
    'ai': 'AI 服务',
    'media': '媒体与文档',
    'network': '网络与通信',
    'system': '系统服务',
    'ui': 'UI 设计',
    'other': '其他服务'
  }

  // Kit 列表 - 所有 50 个 HMS Kit
  @Local kitList: KitItem[] = [
    // ==================== 账号与认证 ====================
    {
      id: 'account-kit',
      name: '华为账号',
      englishName: 'AccountKit',
      description: '华为帐号登录、授权和管理',
      routeName: 'AccountKitExamplePage',
      category: 'account'
    },
    {
      id: 'online-auth-kit',
      name: '在线认证',
      englishName: 'OnlineAuthenticationKit',
      description: '在线身份认证服务',
      routeName: 'OnlineAuthenticationKitExamplePage',
      category: 'account'
    },

    // ==================== AI 服务 ====================
    {
      id: 'vision-kit',
      name: '视觉 Kit',
      englishName: 'VisionKit',
      description: '图像识别、分类、检测等视觉服务',
      routeName: 'VisionKitExamplePage',
      category: 'ai'
    },
    {
      id: 'core-vision-kit',
      name: '核心视觉 Kit',
      englishName: 'CoreVisionKit',
      description: '核心视觉算法服务',
      routeName: 'CoreVisionKitExamplePage',
      category: 'ai'
    },
    {
      id: 'speech-kit',
      name: '语音 Kit',
      englishName: 'SpeechKit',
      description: '语音识别、合成等语音服务',
      routeName: 'SpeechKitExamplePage',
      category: 'ai'
    },
    {
      id: 'core-speech-kit',
      name: '核心语音 Kit',
      englishName: 'CoreSpeechKit',
      description: '核心语音算法服务',
      routeName: 'CoreSpeechKitExamplePage',
      category: 'ai'
    },
    {
      id: 'natural-language-kit',
      name: '自然语言 Kit',
      englishName: 'NaturalLanguageKit',
      description: '自然语言处理服务',
      routeName: 'NaturalLanguageKitExamplePage',
      category: 'ai'
    },
    {
      id: 'ar-engine',
      name: 'AR 引擎',
      englishName: 'AREngine',
      description: '增强现实引擎',
      routeName: 'AREngineExamplePage',
      category: 'ai'
    },
    {
      id: 'spatial-recon-kit',
      name: '空间重建 Kit',
      englishName: 'SpatialReconKit',
      description: '3D 空间重建服务',
      routeName: 'SpatialReconKitExamplePage',
      category: 'ai'
    },
    {
      id: 'agent-framework-kit',
      name: '智能体框架 Kit',
      englishName: 'AgentFrameworkKit',
      description: 'AI 智能体框架',
      routeName: 'AgentFrameworkKitExamplePage',
      category: 'ai'
    },
    {
      id: 'data-augmentation-kit',
      name: '数据增强 Kit',
      englishName: 'DataAugmentationKit',
      description: 'AI 数据增强服务',
      routeName: 'DataAugmentationKitExamplePage',
      category: 'ai'
    },
    {
      id: 'intents-kit',
      name: '意图 Kit',
      englishName: 'IntentsKit',
      description: '意图识别服务',
      routeName: 'IntentsKitExamplePage',
      category: 'ai'
    },

    // ==================== 媒体与文档 ====================
    {
      id: 'scan-kit',
      name: '扫码 Kit',
      englishName: 'ScanKit',
      description: '条码/二维码扫描与生成',
      routeName: 'ScanKitExamplePage',
      category: 'media'
    },
    {
      id: 'pdf-kit',
      name: 'PDF Kit',
      englishName: 'PDFKit',
      description: 'PDF 文档处理服务',
      routeName: 'PDFKitExamplePage',
      category: 'media'
    },
    {
      id: 'reader-kit',
      name: '阅读器 Kit',
      englishName: 'ReaderKit',
      description: '电子书阅读服务',
      routeName: 'ReaderKitExamplePage',
      category: 'media'
    },
    {
      id: 'preview-kit',
      name: '预览 Kit',
      englishName: 'PreviewKit',
      description: '文档预览服务',
      routeName: 'PreviewKitExamplePage',
      category: 'media'
    },
    {
      id: 'ringtone-kit',
      name: '铃声 Kit',
      englishName: 'RingtoneKit',
      description: '铃声管理服务',
      routeName: 'RingtoneKitExamplePage',
      category: 'media'
    },

    // ==================== 网络与通信 ====================
    {
      id: 'network-boost-kit',
      name: '网络加速 Kit',
      englishName: 'NetworkBoostKit',
      description: '网络加速优化服务',
      routeName: 'NetworkBoostKitExamplePage',
      category: 'network'
    },
    {
      id: 'nearlink-kit',
      name: '星闪 Kit',
      englishName: 'NearLinkKit',
      description: '星闪短距离通信',
      routeName: 'NearLinkKitExamplePage',
      category: 'network'
    },
    {
      id: 'remote-communication-kit',
      name: '远程通信 Kit',
      englishName: 'RemoteCommunicationKit',
      description: '远程通信服务',
      routeName: 'RemoteCommunicationKitExamplePage',
      category: 'network'
    },
    {
      id: 'call-kit',
      name: '通话 Kit',
      englishName: 'CallKit',
      description: '通话服务 (已弃用)',
      routeName: 'CallKitExamplePage',
      category: 'network',
      isDeprecated: true,
      replaceWith: 'CallServiceKit'
    },
    {
      id: 'call-service-kit',
      name: '通话服务 Kit',
      englishName: 'CallServiceKit',
      description: '通话服务 (推荐)',
      routeName: 'CallServiceKitExamplePage',
      category: 'network'
    },

    // ==================== 系统服务 ====================
    {
      id: 'push-kit',
      name: '推送 Kit',
      englishName: 'PushKit',
      description: '华为推送服务',
      routeName: 'PushKitExamplePage',
      category: 'system'
    },
    {
      id: 'map-kit',
      name: '地图 Kit',
      englishName: 'MapKit',
      description: '华为地图服务',
      routeName: 'MapKitExamplePage',
      category: 'system'
    },
    {
      id: 'car-kit',
      name: '车载 Kit',
      englishName: 'CarKit',
      description: '车载服务',
      routeName: 'CarKitExamplePage',
      category: 'system'
    },
    {
      id: 'wear-engine',
      name: '穿戴引擎',
      englishName: 'WearEngine',
      description: '华为穿戴服务',
      routeName: 'WearEngineExamplePage',
      category: 'system'
    },
    {
      id: 'health-service-kit',
      name: '健康服务 Kit',
      englishName: 'HealthServiceKit',
      description: '华为健康服务',
      routeName: 'HealthServiceKitExamplePage',
      category: 'system'
    },
    {
      id: 'weather-service-kit',
      name: '天气服务 Kit',
      englishName: 'WeatherServiceKit',
      description: '华为天气服务',
      routeName: 'WeatherServiceKitExamplePage',
      category: 'system'
    },
    {
      id: 'device-security-kit',
      name: '设备安全 Kit',
      englishName: 'DeviceSecurityKit',
      description: '设备安全服务',
      routeName: 'DeviceSecurityKitExamplePage',
      category: 'system'
    },
    {
      id: 'cloud-foundation-kit',
      name: '云基础 Kit',
      englishName: 'CloudFoundationKit',
      description: '华为云基础服务',
      routeName: 'CloudFoundationKitExamplePage',
      category: 'system'
    },
    {
      id: 'file-manager-service-kit',
      name: '文件管理服务 Kit',
      englishName: 'FileManagerServiceKit',
      description: '文件管理服务',
      routeName: 'FileManagerServiceKitExamplePage',
      category: 'system'
    },
    {
      id: 'enterprise-data-guard-kit',
      name: '企业数据保护 Kit',
      englishName: 'EnterpriseDataGuardKit',
      description: '企业数据保护',
      routeName: 'EnterpriseDataGuardKitExamplePage',
      category: 'system'
    },
    {
      id: 'enterprise-space-kit',
      name: '企业空间 Kit',
      englishName: 'EnterpriseSpaceKit',
      description: '企业空间管理',
      routeName: 'EnterpriseSpaceKitExamplePage',
      category: 'system'
    },
    {
      id: 'screen-time-guard-kit',
      name: '屏幕时间守护 Kit',
      englishName: 'ScreenTimeGuardKit',
      description: '屏幕时间管理',
      routeName: 'ScreenTimeGuardKitExamplePage',
      category: 'system'
    },
    {
      id: 'service-collaboration-kit',
      name: '服务协作 Kit',
      englishName: 'ServiceCollaborationKit',
      description: '服务协作',
      routeName: 'ServiceCollaborationKitExamplePage',
      category: 'system'
    },
    {
      id: 'scenario-fusion-kit',
      name: '场景融合 Kit',
      englishName: 'ScenarioFusionKit',
      description: '多场景融合',
      routeName: 'ScenarioFusionKitExamplePage',
      category: 'system'
    },
    {
      id: 'live-view-kit',
      name: '实时视图 Kit',
      englishName: 'LiveViewKit',
      description: '实时视图显示',
      routeName: 'LiveViewKitExamplePage',
      category: 'system'
    },

    // ==================== UI 设计 ====================
    {
      id: 'ui-design-kit',
      name: 'UI 设计 Kit',
      englishName: 'UIDesignKit',
      description: 'UI 设计规范',
      routeName: 'UIDesignKitExamplePage',
      category: 'ui'
    },
    {
      id: 'desktop-extension-kit',
      name: '桌面扩展 Kit',
      englishName: 'DesktopExtensionKit',
      description: '桌面扩展',
      routeName: 'DesktopExtensionKitExamplePage',
      category: 'ui'
    },
    {
      id: 'status-bar-extension-kit',
      name: '状态栏扩展 Kit',
      englishName: 'StatusBarExtensionKit',
      description: '状态栏扩展 (已弃用)',
      routeName: 'StatusBarExtensionKitExamplePage',
      category: 'ui',
      isDeprecated: true,
      replaceWith: 'DesktopExtensionKit'
    },

    // ==================== 其他服务 ====================
    {
      id: 'share-kit',
      name: '分享 Kit',
      englishName: 'ShareKit',
      description: '华为分享服务',
      routeName: 'ShareKitExamplePage',
      category: 'other'
    },
    {
      id: 'iap-kit',
      name: '应用内购买 Kit',
      englishName: 'IAPKit',
      description: '应用内购买服务',
      routeName: 'IAPKitExamplePage',
      category: 'other'
    },
    {
      id: 'payment-kit',
      name: '支付 Kit',
      englishName: 'PaymentKit',
      description: '华为支付服务',
      routeName: 'PaymentKitExamplePage',
      category: 'other'
    },
    {
      id: 'wallet-kit',
      name: '钱包 Kit',
      englishName: 'WalletKit',
      description: '华为钱包服务',
      routeName: 'WalletKitExamplePage',
      category: 'other'
    },
    {
      id: 'app-gallery-kit',
      name: '应用市场 Kit',
      englishName: 'AppGalleryKit',
      description: '华为应用市场 (推荐)',
      routeName: 'AppGalleryKitExamplePage',
      category: 'other'
    },
    {
      id: 'store-kit',
      name: '应用商店 Kit',
      englishName: 'StoreKit',
      description: '应用商店 (已弃用)',
      routeName: 'StoreKitExamplePage',
      category: 'other',
      isDeprecated: true,
      replaceWith: 'AppGalleryKit'
    },
    {
      id: 'game-service-kit',
      name: '游戏服务 Kit',
      englishName: 'GameServiceKit',
      description: '华为游戏服务',
      routeName: 'GameServiceKitExamplePage',
      category: 'other'
    },
    {
      id: 'graphics-accelerate-kit',
      name: '图形加速 Kit',
      englishName: 'GraphicsAccelerateKit',
      description: '图形加速服务',
      routeName: 'GraphicsAccelerateKitExamplePage',
      category: 'other'
    },
    {
      id: 'app-linking-kit',
      name: '应用链接 Kit',
      englishName: 'AppLinkingKit',
      description: '应用链接服务',
      routeName: 'AppLinkingKitExamplePage',
      category: 'other'
    },
    {
      id: 'pen-kit',
      name: '手写笔 Kit',
      englishName: 'Penkit',
      description: '手写笔输入',
      routeName: 'PenKitExamplePage',
      category: 'other'
    }
  ]

  // 过滤后的 Kit 列表
  @Computed
  get filteredKitList(): KitItem[] {
    let filtered = this.kitList

    // 按分类过滤
    if (this.selectedCategory !== 'all') {
      filtered = filtered.filter(kit => kit.category === this.selectedCategory)
    }

    // 按关键词搜索
    if (this.searchKeyword) {
      const keyword = this.searchKeyword.toLowerCase()
      filtered = filtered.filter(kit =>
        kit.name.toLowerCase().includes(keyword) ||
        kit.englishName.toLowerCase().includes(keyword) ||
        kit.description.toLowerCase().includes(keyword)
      )
    }

    return filtered
  }

  // 获取分类统计
  getCategoryCount(category: string): number {
    if (category === 'all') {
      return this.kitList.length
    }
    return this.kitList.filter(kit => kit.category === category).length
  }

  build() {
    Column() {
      // 标题栏
      this.buildHeader()

      // 搜索栏
      this.buildSearchBar()

      // 分类标签
      this.buildCategoryTabs()

      // Kit 列表
      Scroll() {
        Column() {
          ForEach(this.filteredKitList, (kit: KitItem) => {
            this.buildKitItem(kit)
          }, (kit: KitItem) => kit.id)
        }
        .width('100%')
        .padding({ left: 16, right: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildHeader() {
    Column() {
      Text('HMS Kit')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
      Text('HarmonyOS HMS Kit 接口示例')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 4 })
    }
    .width('100%')
    .padding({ top: 20, bottom: 16, left: 16, right: 16 })
    .backgroundColor(Color.White)
  }

  @Builder
  buildSearchBar() {
    Row() {
      Search({ value: $$this.searchKeyword, placeholder: '搜索 Kit 名称或描述' })
        .searchButton('搜索')
        .width('100%')
        .backgroundColor('#F0F0F0')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(Color.White)
  }

  @Builder
  buildCategoryTabs() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          Button(this.categoryNames[category])
            .type(ButtonType.Normal)
            .fontSize(14)
            .fontWeight(this.selectedCategory === category ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(this.selectedCategory === category ? Color.White : '#333333')
            .backgroundColor(this.selectedCategory === category ? '#007AFF' : '#E0E0E0')
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .borderRadius(20)
            .onClick(() => {
              this.selectedCategory = category
            })
        }, (category: string) => category)
      }
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .padding({ top: 12, bottom: 12 })
    .backgroundColor(Color.White)
  }

  @Builder
  buildKitItem(kit: KitItem) {
    Column() {
      Row() {
        Column() {
          Text(kit.name)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(kit.isDeprecated ? '#999999' : '#333333')

          Text(kit.englishName)
            .fontSize(14)
            .fontColor('#666666')
            .margin({ top: 4 })

          Text(kit.description)
            .fontSize(14)
            .fontColor('#999999')
            .margin({ top: 6 })
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          if (kit.isDeprecated) {
            Text(`已弃用，请使用 ${kit.replaceWith}`)
              .fontSize(12)
              .fontColor(Color.Red)
              .margin({ top: 6 })
          }
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Image($r('sys.media.ohos_ic_public_arrow_right'))
          .width(16)
          .height(16)
          .fillColor('#CCCCCC')
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .margin({ bottom: 12 })
    .onClick(() => {
      this.onNavigate(kit.routeName)
    })
  }
}
