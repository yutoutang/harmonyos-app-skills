# SideBarContainer 组件 HarmonyOS 6.0 开发 Skill

## 概述

SideBarContainer 组件是 OpenHarmony 中的侧边栏容器组件，提供侧边栏（Sidebar）与主内容区域的布局。支持显示/隐藏侧边栏，并能根据容器宽度自动切换显示模式。适用于文件管理器、音乐播放器、文档编辑器等应用场景。

## 重要说明

- **基础组件**: SideBarContainer 是 ArkUI 的基础内置组件，无需导入
- **子组件限制**: 必须包含恰好 2 个子组件（侧边栏 + 主内容区）
- **渲染控制**: 不支持 if/else、ForEach、LazyForEach 等渲染控制组件
- **自动适配**: 根据容器宽度自动选择显示模式（Embed/Overlay）
- **API 版本**: 从 API 9 开始支持

## 模块信息

- **组件名称**: SideBarContainer
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [SideBarContainer - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-sidebarcontainer-V5)

## 一、API 参数

### 构造函数

```typescript
SideBarContainer(type?: SideBarContainerType)
```

| 参数 | 类型 | 必填 | 描述 |
|------|------|------|------|
| type | SideBarContainerType | 否 | 侧边栏显示模式，默认 Auto |

### SideBarContainerType 枚举

| 值 | 描述 |
|----|------|
| SideBarContainerType.Embed | 侧边栏嵌入在容器中，与内容区并排显示 |
| SideBarContainerType.Overlay | 侧边栏浮在内容区上方 |
| SideBarContainerType.Auto | 根据容器宽度自动选择 Embed 或 Overlay |

### 样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| showSideBar | boolean | true | 是否显示侧边栏 |
| showControlButton | boolean | true | 是否显示控制按钮 |
| controlButton | ButtonStyle | - | 控制按钮样式 |
| sideBarWidth | number \| Length | 200 | 侧边栏宽度 |
| minSideBarWidth | number \| Length | 200 | 侧边栏最小宽度 |
| maxSideBarWidth | number \| Length | 280 | 侧边栏最大宽度 |
| autoHide | boolean | true | 拖动侧边栏小于最小宽度时自动隐藏 |
| sideBarPosition | SideBarPosition | SideBarPosition.Start | 侧边栏位置（左侧/右侧） |

### SideBarPosition 枚举

| 值 | 描述 |
|----|------|
| SideBarPosition.Start | 侧边栏在左侧（默认） |
| SideBarPosition.End | 侧边栏在右侧 |

### 事件

| 事件 | 类型 | 描述 |
|------|------|------|
| onChange | (value: boolean) => void | 侧边栏显示状态改变时触发，value 表示当前是否显示 |

## 二、使用示例

### 2.1 基础 SideBarContainer

```typescript
@ComponentV2
struct BasicSideBarExample {
  @Local isSideBarVisible: boolean = true

  build() {
    SideBarContainer() {
      // 第一个子组件：侧边栏
      Column({ space: 16 }) {
        Text('Sidebar')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        ForEach(['Menu 1', 'Menu 2', 'Menu 3', 'Menu 4'], (item: string) => {
          Text(item)
            .width('100%')
            .height(44)
            .fontSize(16)
            .padding({ left: 16 })
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
            .onClick(() => {
              console.info(`Clicked: ${item}`)
            })
        })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')

      // 第二个子组件：主内容区
      Column() {
        Text('Main Content')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        Text('This is the main content area')
          .fontSize(16)
          .fontColor('#666666')
          .margin({ top: 16 })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#E3F2FD')
    }
    .width('100%')
    .height('100%')
    .sideBarWidth(200)
    .onChange((value: boolean) => {
      this.isSideBarVisible = value
      console.info(`Sidebar visible: ${value}`)
    })
  }
}
```

### 2.2 文件管理器布局

```typescript
@ComponentV2
struct FileManagerSideBarExample {
  @Local selectedPath: string = 'Home'
  @Local fileSystem: FileSystemItem[] = [
    { name: 'Home', icon: '\uE639', type: 'folder' },
    { name: 'Documents', icon: '\uE640', type: 'folder' },
    { name: 'Downloads', icon: '\uE8EF', type: 'folder' },
    { name: 'Pictures', icon: '\uE641', type: 'folder' },
    { name: 'Music', icon: '\uE642', type: 'folder' },
    { name: 'Videos', icon: '\uE643', type: 'folder' }
  ]

  build() {
    SideBarContainer(SideBarContainerType.Embed) {
      // 侧边栏：文件夹导航
      Column({ space: 8 }) {
        // 标题
        Row() {
          Text('File Explorer')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 8 })

        // 文件夹列表
        ForEach(this.fileSystem, (folder: FileSystemItem) => {
          Row({ space: 12 }) {
            Text(folder.icon)
              .fontSize(24)
              .fontColor(this.selectedPath === folder.name ? '#007DFF' : '#666666')

            Text(folder.name)
              .fontSize(16)
              .fontColor(this.selectedPath === folder.name ? '#007DFF' : '#333333')
              .fontWeight(
                this.selectedPath === folder.name ? FontWeight.Bold : FontWeight.Normal
              )
              .layoutWeight(1)
          }
          .width('100%')
          .height(48)
          .padding({ left: 16, right: 16 })
          .backgroundColor(this.selectedPath === folder.name ? '#E3F2FD' : '#FFFFFF')
          .borderRadius(8)
          .onClick(() => {
            this.selectedPath = folder.name
            console.info(`Selected: ${folder.name}`)
          })
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      // 主内容区：文件列表
      Column({ space: 12 }) {
        Row() {
          Text(this.selectedPath)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Blank()

          Text('12 items')
            .fontSize(14)
            .fontColor('#999999')
        }
        .width('100%')
        .padding({ bottom: 16 })

        // 文件列表
        ForEach([1, 2, 3, 4, 5], (item: number) => {
          Row({ space: 12 }) {
            Text('\uE644')
              .fontSize(32)
              .fontColor('#007DFF')

            Column({ space: 4 }) {
              Text(`File ${item}.txt`)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')

              Text('2.5 KB • Modified today')
                .fontSize(14)
                .fontColor('#999999')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .height(72)
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .shadow({ radius: 2, color: '#E0E0E0', offsetX: 0, offsetY: 1 })
        })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
    .sideBarWidth(240)
    .minSideBarWidth(200)
    .maxSideBarWidth(320)
  }
}

interface FileSystemItem {
  name: string
  icon: string
  type: string
}
```

### 2.3 音乐播放器布局

```typescript
@ComponentV2
struct MusicPlayerSideBarExample {
  @Local currentPlaylist: string = 'Favorites'
  @Local playlists: Playlist[] = [
    { name: 'Favorites', count: 25, color: '#FF5252' },
    { name: 'Recent', count: 18, color: '#007DFF' },
    { name: 'Most Played', count: 32, color: '#FFC107' },
    { name: 'Downloads', count: 45, color: '#28A745' },
    { name: 'My Playlist', count: 12, color: '#9C27B0' }
  ]

  build() {
    SideBarContainer(SideBarContainerType.Auto) {
      // 侧边栏：播放列表
      Column({ space: 16 }) {
        // 标题
        Text('Library')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .padding({ left: 16, right: 16, top: 16 })

        // 播放列表
        ForEach(this.playlists, (playlist: Playlist) => {
          Row({ space: 12 }) {
            // 图标
            Text()
              .width(40)
              .height(40)
              .backgroundColor(playlist.color)
              .borderRadius(20)
              .margin({ left: 16 })

            Column({ space: 2 }) {
              Text(playlist.name)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')

              Text(`${playlist.count} songs`)
                .fontSize(12)
                .fontColor('#999999')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .height(64)
          .backgroundColor(
            this.currentPlaylist === playlist.name ? '#E3F2FD' : 'transparent'
          )
          .onClick(() => {
            this.currentPlaylist = playlist.name
          })
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      // 主内容区：当前播放
      Column({ space: 24 }) {
        // 专辑封面
        Text()
          .width(280)
          .height(280)
          .backgroundColor('#E3F2FD')
          .borderRadius(12)

        // 歌曲信息
        Column({ space: 8 }) {
          Text('Beautiful Song')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Text('Amazing Artist')
            .fontSize(18)
            .fontColor('#999999')
        }

        // 进度条
        Column({ space: 8 }) {
          Row() {
            Text('1:23')
              .fontSize(12)
              .fontColor('#999999')

            Blank()

            Text('3:45')
              .fontSize(12)
              .fontColor('#999999')
          }
          .width('100%')

          Row() {
            Text()
              .width('35%')
              .height(4)
              .backgroundColor('#007DFF')
              .borderRadius(2)
          }
          .width('100%')
        }

        // 控制按钮
        Row({ space: 32 }) {
          Text('\uE645')
            .fontSize(32)
            .fontColor('#666666')

          Text('\uE646')
            .fontSize(48)
            .fontColor('#007DFF')

          Text('\uE647')
            .fontSize(32)
            .fontColor('#666666')
        }
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FAFAFA')
    }
    .width('100%')
    .height('100%')
    .sideBarWidth(280)
  }
}

interface Playlist {
  name: string
  count: number
  color: string
}
```

### 2.4 带控制按钮的侧边栏

```typescript
@ComponentV2
struct ControlButtonSideBarExample {
  @Local showSideBar: boolean = true

  build() {
    SideBarContainer(SideBarContainerType.Overlay) {
      // 侧边栏
      Column() {
        Text('Sidebar Content')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#E3F2FD')

      // 主内容区
      Column() {
        Text('Main Content Area')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        Text(this.showSideBar ? 'Sidebar is shown' : 'Sidebar is hidden')
          .fontSize(16)
          .fontColor('#666666')
          .margin({ top: 16 })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .showSideBar(this.showSideBar)
    .showControlButton(true)
    .controlButton({
      style: ButtonStyleMode.NORMAL
    })
    .sideBarWidth(250)
    .onChange((value: boolean) => {
      this.showSideBar = value
      console.info(`Sidebar state changed: ${value}`)
    })
  }
}
```

### 2.5 右侧侧边栏

```typescript
@ComponentV2
struct RightSideBarExample {
  @Local settings: string[] = ['General', 'Display', 'Sound', 'Network', 'Security']

  build() {
    SideBarContainer() {
      // 主内容区（左侧）
      Column() {
        Text('Application Main Interface')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        Text('User interacts with the main content here')
          .fontSize(16)
          .fontColor('#666666')
          .margin({ top: 16 })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F5F5F5')

      // 侧边栏（右侧）
      Column({ space: 16 }) {
        Text('Settings')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .padding(16)

        ForEach(this.settings, (setting: string) => {
          Text(setting)
            .width('100%')
            .height(44)
            .fontSize(16)
            .padding({ left: 16 })
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .onClick(() => {
              console.info(`Setting: ${setting}`)
            })
        })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .sideBarWidth(220)
    .sideBarPosition(SideBarPosition.End) // 侧边栏在右侧
  }
}
```

## 三、最佳实践

### 3.1 布局建议

1. **宽度设置**: sideBarWidth 通常设为 200-300vp
2. **最小宽度**: minSideBarWidth 保证侧边栏内容不拥挤
3. **最大宽度**: maxSideBarWidth 防止侧边栏过宽
4. **模式选择**: 根据应用场景选择 Embed/Overlay/Auto 模式

### 3.2 交互设计

1. **控制按钮**: 使用 showControlButton 提供显示/隐藏切换
2. **状态反馈**: 使用 onChange 事件响应侧边栏状态变化
3. **拖动支持**: autoHide 允许用户拖动调整宽度
4. **位置选择**: 根据用户习惯选择左侧或右侧侧边栏

### 3.3 样式统一

1. **背景层次**: 侧边栏和主内容区使用不同背景色区分
2. **间距一致**: 内部使用统一的 padding 和 space
3. **圆角统一**: 使用相同的 borderRadius
4. **字体层级**: 使用不同字号和字重区分内容层级

### 3.4 性能优化

1. **避免复杂渲染**: 侧边栏内容尽量简洁
2. **按需加载**: 主内容区使用 LazyForEach 加载数据
3. **避免频繁更新**: 侧边栏内容相对静态，避免频繁刷新

### 3.5 常见问题

**Q: 侧边栏不显示？**
A: 检查 showSideBar 是否为 true，确保有 2 个子组件

**Q: 子组件数量错误？**
A: SideBarContainer 必须恰好包含 2 个子组件，第一个为侧边栏，第二个为主内容区

**Q: 侧边栏宽度无法调整？**
A: 检查 minSideBarWidth 和 maxSideBarWidth 设置，确保在合理范围内

**Q: 控制按钮不显示？**
A: 确保 showControlButton 为 true，且容器宽度足够

**Q: 内容被截断？**
A: 检查侧边栏宽度设置，确保内容有足够空间显示

**Q: 自动切换模式不生效？**
A: 确保 type 设为 SideBarContainerType.Auto，容器宽度会自动选择 Embed 或 Overlay

## 四、典型应用场景

1. **文件管理器**: 左侧文件夹导航，右侧文件列表
2. **音乐播放器**: 左侧播放列表，右侧播放界面
3. **文档编辑器**: 左侧目录/大纲，右侧编辑区域
4. **邮件应用**: 左侧邮箱列表，右侧邮件内容
5. **设置界面**: 左侧设置分类，右侧具体设置项
6. **社交应用**: 左侧联系人/群组，右侧聊天界面

## 五、相关组件

- **Navigation**: 页面导航容器
- **Tabs**: 标签页容器
- **SplitContainer**: 分屏容器
- **Panel**: 弹出面板组件
