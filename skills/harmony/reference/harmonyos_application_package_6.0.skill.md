# 鸿蒙 HarmonyOS 6.0 应用程序包与使用开发 Skill

## 概述

本 Skill 提供 HarmonyOS 6.0 应用程序包的开发与使用指南。HarmonyOS 应用程序采用模块化设计，主要包含 **App Pack**、**HAP**、**HAR**、**HSP** 四种包类型，每种包都有其特定的使用场景和优势。

## 重要说明

- **App Pack（应用包）**：应用发布的基本单元，包含一个或多个 HAP 包
- **HAP（Harmony Ability Package）**：应用安装和运行的基本单元
- **HAR（Harmony Archive）**：静态共享包，编译时共享代码和资源
- **HSP（Harmony Shared Package）**：动态共享包，运行时动态加载

## 模块信息

- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **更新日期**: 2026年1月
- **官方文档**:
  - [应用程序包基础 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/application-package-fundamentals)
  - [应用程序包开发与使用（HAP）- 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/hap-package)

## 一、应用程序包类型

### 1.1 包类型对比

| 包类型 | 全称 | 特性 | 使用场景 | 是否可独立发布 |
|--------|------|------|----------|---------------|
| **App Pack** | Application Package | 应用发布包，包含多个 HAP | 应用分发到应用市场 | ✅ 是 |
| **HAP** | Harmony Ability Package | 应用功能模块，可独立运行 | 主模块、功能模块 | ❌ 否（需打包成 App Pack） |
| **HAR** | Harmony Archive | 静态共享包，编译时共享 | 共享代码、组件、资源 | ✅ 是（可上传到仓） |
| **HSP** | Harmony Shared Package | 动态共享包，运行时加载 | 多模块共享、按需加载 | ❌ 否（需随主应用发布） |

### 1.2 包之间的关系

```
App Pack (应用包)
├── entry.hap (主模块，必需)
├── feature1.hap (功能模块，可选)
├── feature2.hap (功能模块，可选)
└── ...

HAP 依赖关系：
├── 可依赖 HAR 包
├── 可依赖 HSP 包
└── 不可依赖其他 HAP 包

HAR 包：
├── 静态共享包
├── 编译时集成到 HAP/HSP
└── 不能依赖其他 HAR/HSP

HSP 包：
├── 动态共享包
├── 运行时动态加载
├── 可依赖 HAR 包
└── 可依赖其他 HSP 包（不能循环依赖）
```

## 二、App Pack（应用包）

### 2.1 App Pack 结构

App Pack 是应用发布的最终形式，由一个或多个 HAP 包组成。

```json
// App Pack 结构示例
MyApp.app
├── entry.hap          // 主模块（必需）
├── feature_a.hap      // 功能模块 A（可选）
├── feature_b.hap      // 功能模块 B（可选）
├── pack.info          // 包信息文件
└── resources          // 全局资源（可选）
```

### 2.2 app.json5 配置文件

```json
{
  "app": {
    "bundleName": "com.example.myapp",
    "vendor": "example",
    "versionCode": 1000000,
    "versionName": "1.0.0",
    "icon": "$media:app_icon",
    "label": "$string:app_name",
    "targetAPIVersion": 12,
    "apiReleaseType": "Release"
  }
}
```

### 2.3 创建 App Pack

```bash
# 使用 DevEco Studio 构建 App Pack
# 方式 1：通过 IDE 菜单
Build -> Build Hap(s)/APP(s) -> Build APP(s)

# 方式 2：使用 Gradle 命令
./gradlew assembleApp

# 构建产物位置
build/outputs/app/release/
```

## 三、HAP 包（Harmony Ability Package）

### 3.1 HAP 包类型

#### Entry 类型（主模块）

```json
// module.json5
{
  "module": {
    "name": "entry",
    "type": "entry",
    "description": "$string:module_entry_desc",
    "mainElement": "EntryAbility",
    "deviceTypes": [
      "default",
      "tablet"
    ],
    "deliveryWithInstall": true,
    "installationFree": false,
    "pages": "$profile:main_pages",
    "abilities": [
      {
        "name": "EntryAbility",
        "srcEntry": "./ets/entryability/EntryAbility.ts",
        "description": "$string:EntryAbility_desc",
        "icon": "$media:icon",
        "label": "$string:EntryAbility_label",
        "startWindowIcon": "$media:icon",
        "startWindowBackground": "$color:start_window_background",
        "exported": true,
        "skills": [
          {
            "entities": [
              "entity.system.home"
            ],
            "actions": [
              "action.system.home"
            ]
          }
        ]
      }
    ]
  }
}
```

#### Feature 类型（功能模块）

```json
// module.json5
{
  "module": {
    "name": "feature_payment",
    "type": "feature",
    "description": "$string:module_payment_desc",
    "mainElement": "PaymentAbility",
    "deviceTypes": ["default"],
    "deliveryWithInstall": true,
    "installationFree": false,
    "pages": "$profile:payment_pages",
    "abilities": [
      {
        "name": "PaymentAbility",
        "srcEntry": "./ets/paymentability/PaymentAbility.ts",
        "description": "$string:PaymentAbility_desc",
        "icon": "$media:payment_icon",
        "label": "$string:PaymentAbility_label",
        "exported": false
      }
    ]
  }
}
```

### 3.2 HAP 包配置选项

#### deliveryWithInstall - 随主包安装

```json
{
  "module": {
    "name": "feature_vip",
    "type": "feature",
    "deliveryWithInstall": true  // 随主包一起安装
  }
}
```

#### onDemand - 按需加载

```json
{
  "module": {
    "name": "feature_game",
    "type": "feature",
    "deliveryWithInstall": false,  // 不随主包安装
    "installationFree": false
  }
}
```

### 3.3 创建 HAP 模块

```typescript
// 1. 创建 Feature 模块
// 在 DevEco Studio 中：File -> New -> Module -> Feature Module

// 2. 配置模块信息
{
  "module": {
    "name": "feature_user",
    "type": "feature",
    // ... 其他配置
  }
}

// 3. 在主模块中引用
import { UserComponent } from '@ohos/feature_user';
```

## 四、HAR 包（Harmony Archive）

### 4.1 HAR 包特点

- **静态共享包**：编译时集成到使用方
- **代码共享**：可包含 ArkUI 组件、工具方法、资源等
- **版本管理**：支持多版本共存
- **独立发布**：可发布到 Maven 仓库供其他项目使用

### 4.2 创建 HAR 包

**步骤 1：创建 HAR 模块**

```bash
# DevEco Studio：File -> New -> Module -> HAR Module
```

**步骤 2：配置 HAR 模块**

```json
// module.json5
{
  "module": {
    "name": "common_utils",
    "type": "har",
    "description": "$string:module_har_desc",
    "deviceTypes": ["default"],
    "installationFree": true,
    "syntaxVersion": "1.0"
  }
}
```

**步骤 3：导出内容**

```typescript
// CommonUtils.ets
export class StringUtils {
  static isEmpty(str: string): boolean {
    return str === null || str === undefined || str.length === 0;
  }

  static format(template: string, ...args: any[]): string {
    return template.replace(/{(\d+)}/g, (match, index) => {
      return args[index] || match;
    });
  }
}

export function formatDate(date: Date): string {
  // 日期格式化逻辑
  return date.toISOString();
}
```

**步骤 4：导出 ArkUI 组件**

```typescript
// CustomButton.ets
@Component
export struct CustomButton {
  @Prop text: string = '';
  @Prop onClick: () => void = () => {};

  build() {
    Button(this.text)
      .onClick(() => {
        this.onClick();
      })
  }
}
```

**步骤 5：导出资源**

```typescript
// Index.ets - 导出入口文件
export { StringUtils, formatDate } from './src/main/ets/utils/StringUtils';
export { CustomButton } from './src/main/ets/components/CustomButton';
```

### 4.3 使用 HAR 包

**方式 1：本地 HAR 包**

```json
// oh-package.json5
{
  "dependencies": {
    "common_utils": "file:../CommonUtils"
  }
}
```

**方式 2：远程 HAR 包**

```json
// oh-package.json5
{
  "dependencies": {
    "@company/common_utils": "^1.0.0"
  }
}
```

**使用 HAR 包中的内容**

```typescript
import { StringUtils, CustomButton } from '@company/common_utils';

@Entry
@Component
struct MainPage {
  build() {
    Column() {
      CustomButton({
        text: '点击我',
        onClick: () => {
          if (StringUtils.isEmpty('test')) {
            console.info('字符串为空');
          }
        }
      })
    }
  }
}
```

### 4.4 发布 HAR 包到仓库

```bash
# 1. 构建 HAR 包
./gradlew :common_utils:publishHar

# 2. 发布到本地仓库
./gradlew :common_utils:publishHarToMavenLocal

# 3. 发布到远程仓库
./gradlew :common_utils:publishHar
```

## 五、HSP 包（Harmony Shared Package）

### 5.1 HSP 包特点

- **动态共享包**：运行时动态加载
- **多模块共享**：多个 HAP 模块共享同一份代码
- **按需加载**：减少应用包体积
- **不能独立发布**：必须随主应用一起发布

### 5.2 创建 HSP 包

**步骤 1：创建 HSP 模块**

```bash
# DevEco Studio：File -> New -> Module -> HSP Module
```

**步骤 2：配置 HSP 模块**

```json
// module.json5
{
  "module": {
    "name": "shared_ui",
    "type": "shared",
    "description": "$string:module_hsp_desc",
    "deviceTypes": ["default"],
    "installationFree": true,
    "syntaxVersion": "1.0"
  }
}
```

**步骤 3：导出 HSP 内容**

```typescript
// SharedComponents.ets
@Component
export struct SharedHeader {
  @Prop title: string = '';
  @Prop showBack: boolean = true;

  build() {
    Row() {
      if (this.showBack) {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
      }

      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
  }
}

// SharedUtils.ets
export class SharedUtils {
  static async fetchData(url: string): Promise<Object> {
    // 网络请求逻辑
    return {};
  }
}
```

**步骤 4：配置导出**

```typescript
// Index.ets
export { SharedHeader } from './src/main/ets/components/SharedHeader';
export { SharedUtils } from './src/main/ets/utils/SharedUtils';
```

### 5.3 使用 HSP 包

**配置依赖**

```json
// oh-package.json5
{
  "dependencies": {
    "shared_ui": "file:../SharedUI"
  }
}
```

**使用 HSP 内容**

```typescript
import { SharedHeader, SharedUtils } from 'shared_ui';

@Entry
@Component
struct ProfilePage {
  build() {
    Column() {
      SharedHeader({
        title: '个人中心',
        showBack: true
      })

      // 页面内容
    }
  }
}
```

### 5.4 HSP 依赖关系

```typescript
// HSP 可以依赖 HAR
// HSP 可以依赖其他 HSP（但不能循环依赖）

// 错误示例：循环依赖
// HSP A 依赖 HSP B
// HSP B 依赖 HSP A ❌

// 正确示例：
// HSP A 依赖 HSP B
// HSP B 依赖 HAR C ✅
```

## 六、模块依赖管理

### 6.1 依赖配置文件

**oh-package.json5**

```json
{
  "name": "myapplication",
  "version": "1.0.0",
  "description": "My HarmonyOS Application",
  "main": "",
  "author": "",
  "license": "ISC",
  "dependencies": {
    "@company/common_utils": "^1.0.0",
    "shared_ui": "file:../SharedUI"
  },
  "devDependencies": {
    "@ohos/hypium": "1.0.16"
  }
}
```

### 6.2 依赖版本管理

```json
{
  "dependencies": {
    // 精确版本
    "package1": "1.0.0",

    // 兼容版本（不改变主版本号）
    "package2": "^1.2.3",

    // 近似版本（不改变次版本号）
    "package3": "~1.2.3",

    // 最新版本
    "package4": "*",

    // 范围版本
    "package5": ">=1.0.0 <2.0.0"
  }
}
```

### 6.3 依赖冲突解决

```bash
# 查看依赖树
ohpm list

# 清理依赖缓存
ohpm cache clean

# 重新安装依赖
ohpm install
```

## 七、应用程序包构建

### 7.1 构建配置

**build-profile.json5**

```json
{
  "app": {
    "signingProfiles": [],
    "compileSdkVersion": "12.0.0.0",
    "compatibleSdkVersion": "12.0.0.0",
    "products": [
      {
        "name": "default",
        "signingConfig": "default",
        "compatibleSdkVersion": "12.0.0.0",
        "runtimeOS": "HarmonyOS"
      }
    ],
    "buildModeSet": [
      {
        "name": "debug"
      },
      {
        "name": "release"
      }
    ]
  },
  "modules": [
    {
      "name": "entry",
      "src": "./entry",
      "targets": [
        {
          "name": "default",
          "applyToProducts": [
            "default"
          ]
        }
      ]
    },
    {
      "name": "feature_user",
      "src": "./feature_user",
      "targets": [
        {
          "name": "default",
          "applyToProducts": [
            "default"
          ]
        }
      ]
    }
  ]
}
```

### 7.2 构建命令

```bash
# 构建所有模块
./gradlew build

# 构建 HAP 包
./gradlew assembleHap

# 构建 App Pack
./gradlew assembleApp

# 清理构建产物
./gradlew clean

# 构建指定模块
./gradlew :entry:assembleHap
./gradlew :feature_user:assembleHap
```

### 7.3 构建产物

```bash
# HAP 包位置
build/outputs/default/entry-default-unsigned.hap
build/outputs/default/entry-default-signed.hap

# App Pack 位置
build/outputs/app/release/MyApp.app

# HAR 包位置
build/outputs/har/common_utils.har

# HSP 包位置
build/outputs/hsp/shared_ui.hsp
```

## 八、应用程序包安装

### 8.1 安装 HAP 包

```bash
# 通过 hdc 命令安装
hdc install entry-default-signed.hap

# 安装 App Pack
hdc install MyApp.app

# 卸载应用
hdc uninstall com.example.myapp

# 重新安装
hdc install -r entry-default-signed.hap
```

### 8.2 分包安装

```typescript
import bundleManager from '@ohos.bundle.bundleManager';

// 安装主包和基础分包
async function installMainPackage() {
  const installer = await bundleManager.getBundleInstaller();
  await installer.install(['entry.hap', 'feature_base.hap']);
}

// 按需安装功能分包
async function installFeatureModule() {
  const installer = await bundleManager.getBundleInstaller();
  await installer.install(['feature_game.hap']);
}
```

### 8.3 查询已安装应用

```typescript
import bundleManager from '@ohos.bundle.bundleManager';

// 获取所有应用信息
async function getAllBundles() {
  const data = await bundleManager.getAllBundleInfo(
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION
  );

  data.forEach(bundleInfo => {
    console.info('应用名称:', bundleInfo.name);
    console.info('应用包名:', bundleInfo.bundleName);
    console.info('版本号:', bundleInfo.versionName);
  });
}

// 获取指定应用信息
async function getBundleInfo(bundleName: string) {
  const data = await bundleManager.getBundleInfo(
    bundleName,
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION
  );

  console.info('应用信息:', JSON.stringify(data));
}
```

## 九、分包加载

### 9.1 配置分包

```json
// module.json5 - 主模块
{
  "module": {
    "name": "entry",
    "type": "entry",
    "installationFree": false,
    "deliveryWithInstall": true
  }
}

// module.json5 - 功能模块（按需加载）
{
  "module": {
    "name": "feature_game",
    "type": "feature",
    "installationFree": false,
    "deliveryWithInstall": false  // 不随主包安装
  }
}
```

### 9.2 动态加载分包

```typescript
import bundleManager from '@ohos.bundle.bundleManager';

// 下载并安装分包
async function downloadAndInstallFeature() {
  try {
    // 1. 请求下载分包
    const installer = await bundleManager.getBundleInstaller();

    // 2. 安装分包
    await installer.install(['feature_game.hap'], {
      userId: 100,
      installFlag: 1,
      isKeepData: true
    });

    console.info('分包安装成功');
  } catch (err) {
    console.error('分包安装失败:', err);
  }
}

// 检查分包是否已安装
async function checkFeatureInstalled(): Promise<boolean> {
  try {
    const bundleInfo = await bundleManager.getBundleInfo(
      'com.example.myapp',
      bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION
    );

    // 检查 feature_game 模块是否存在
    return bundleInfo.hapModuleInfo.some(
      module => module.name === 'feature_game'
    );
  } catch (err) {
    return false;
  }
}
```

### 9.3 分包预下载

```typescript
// 在应用启动时预下载常用分包
async function preloadFeatures() {
  const featuresToPreload = [
    'feature_game',
    'feature_payment',
    'feature_vip'
  ];

  for (const feature of featuresToPreload) {
    const isInstalled = await checkFeatureInstalled(feature);

    if (!isInstalled) {
      // 后台静默下载
      downloadFeature(feature);
    }
  }
}
```

## 十、资源管理

### 10.1 资源目录结构

```
resources/
├── base/                   # 基础资源（必选）
│   ├── element/           # 元素资源
│   ├── media/             # 媒体资源
│   ├── profile/           # 配置文件
│   └── json/              # JSON 文件
├── rawfile/               # 原始文件（可选）
└──限定词目录/             # 特定场景资源（可选）
    ├── en_US/             # 美式英语
    ├── zh_CN/             # 简体中文
    └── dark/              # 深色模式
```

### 10.2 资源引用

```typescript
// 引用字符串资源
Text($r('app.string.app_name'))

// 引用图片资源
Image($r('app.media.icon'))

// 引用颜色资源
Text().backgroundColor($r('app.color.primary'))

// 引用 rawfile 资源
Image($rawfile('image.png'))
```

### 10.3 系统资源引用

```typescript
// 使用系统资源
Text($r('sys.string.ohos_tabbar_label'))
  .fontSize($r('sys.float.ohos_id_text_size_headline'))
  .fontColor($r('sys.color.ohos_id_color_text_primary'))
```

## 十一、模块选择指南

### 11.1 选择 HAP 的场景

- ✅ 应用主模块（entry）
- ✅ 独立功能模块
- ✅ 需要独立发布的能力
- ✅ 需要独立安装/卸载的功能

### 11.2 选择 HAR 的场景

- ✅ 通用工具类库
- ✅ 可复用的 UI 组件
- ✅ 资源文件共享
- ✅ 跨项目共享代码

### 11.3 选择 HSP 的场景

- ✅ 多个 HAP 模块共享代码
- ✅ 需要动态加载的功能
- ✅ 减少应用包体积
- ✅ 按需加载的大型模块

### 11.4 决策流程图

```
是否需要独立发布？
├─ 是 → 使用 HAP
└─ 否 → 是否运行时加载？
    ├─ 是 → 使用 HSP
    └─ 否 → 使用 HAR
```

## 十二、最佳实践

### 12.1 模块化设计原则

```typescript
// 1. 按功能划分模块
features/
├── user/          // 用户功能模块
├── payment/       // 支付功能模块
├── game/          // 游戏功能模块
└── vip/           // VIP 功能模块

// 2. 抽取通用代码到 HAR
common/
├── utils/         // 工具类 HAR
├── components/    // 组件库 HAR
└── resources/     // 资源库 HAR

// 3. 共享代码使用 HSP
shared/
├── ui/            // 共享 UI 组件 HSP
├── network/       // 网络请求 HSP
└── storage/       // 数据存储 HSP
```

### 12.2 减少包体积

```typescript
// 1. 使用 HSP 替代重复代码
// 避免：每个 HAP 都包含相同的工具类
// 推荐：抽取到 HSP 中共享

// 2. 按需加载功能模块
// 配置 deliveryWithInstall: false
{
  "module": {
    "name": "feature_heavy",
    "deliveryWithInstall": false  // 不随主包安装
  }
}

// 3. 压缩资源文件
// 使用 WebP 格式替代 PNG
// 压缩 JSON 配置文件

// 4. 清理未使用资源
// DevEco Studio -> Build -> Clean Project
```

### 12.3 版本管理

```json
// 使用语义化版本
{
  "version": "1.2.3"
  // 格式：主版本号.次版本号.修订号
  // 主版本号：不兼容的 API 修改
  // 次版本号：向下兼容的功能性新增
  // 修订号：向下兼容的问题修正
}
```

### 12.4 依赖管理

```typescript
// 1. 避免循环依赖
// ❌ 错误：HAR A 依赖 HAR B，HAR B 依赖 HAR A

// 2. 限制依赖深度
// 推荐依赖深度不超过 3 层

// 3. 使用接口解耦
interface ILogger {
  log(message: string): void;
}

// 依赖接口而非具体实现
class MyClass {
  private logger: ILogger;

  constructor(logger: ILogger) {
    this.logger = logger;
  }
}
```

## 十三、常见问题

### 13.1 HAP 包安装失败

**问题**：安装 HAP 包时提示签名错误

**解决方案**：
```bash
# 1. 检查签名配置
# DevEco Studio -> File -> Project Structure -> Signing Configs

# 2. 重新签名
./gradlew assembleHap --signing-config release

# 3. 验证签名
hdc shell bm check -n com.example.myapp
```

### 13.2 HAR 包无法引用

**问题**：导入 HAR 包后找不到模块

**解决方案**：
```bash
# 1. 清理缓存
ohpm cache clean

# 2. 重新安装依赖
ohpm install

# 3. 检查 oh-package.json5 配置
# 确保依赖路径正确
```

### 13.3 HSP 动态加载失败

**问题**：运行时加载 HSP 包报错

**解决方案**：
```typescript
// 1. 确保 HSP 模块正确导出
// Index.ets 中使用 export 导出

// 2. 检查 HSP 依赖关系
// 避免循环依赖

// 3. 使用 try-catch 处理加载异常
try {
  const module = await import('shared_ui');
} catch (err) {
  console.error('HSP 加载失败:', err);
}
```

### 13.4 应用包过大

**问题**：最终 App Pack 体积过大

**解决方案**：
```json
// 1. 使用分包加载
{
  "module": {
    "deliveryWithInstall": false
  }
}

// 2. 启用代码混淆
// build-profile.json5
{
  "app": {
    "buildOption": {
      "externalNativeOptions": {
        "enableObfuscation": true
      }
    }
  }
}

// 3. 压缩资源
// 使用工具压缩图片、JSON 等资源文件
```

## 十四、版本兼容性

| API 版本 | HAP | HAR | HSP | App Pack |
|----------|-----|-----|-----|----------|
| API 9 | ✅ | ✅ | ❌ | ✅ |
| API 10 | ✅ | ✅ | ❌ | ✅ |
| API 11 | ✅ | ✅ | ✅ | ✅ |
| API 12+ | ✅ | ✅ | ✅ | ✅ |

## 十五、参考资料

### 官方文档
- [应用程序包基础 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/application-package-fundamentals)
- [应用程序包开发与使用（HAP）- 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/hap-package)
- [如何安装打包出来的App包 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-faqs/faqs-package-structure-13)
- [如何正确引用HAR/HSP包模块 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-faqs/faqs-package-structure-21)
- [HSP/HAR包中如何引用外部编译的so库文件 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-faqs/faqs-package-structure-6)

### 技术文章
- [HarmonyOS 应用包类型详解- HAP、HAR、HSP - 华为开发者社区](https://developer.huawei.com/consumer/cn/blog/topic/03199488509212053)
- [【HarmonyOS Next】鸿蒙中App、HAP、HAR、HSP概念详解 - 华为开发者社区](https://developer.huawei.com/consumer/cn/blog/topic/03177896634789079)
- [完整教程：鸿蒙中的APP、HAP、HSP、HAR包 - 博客园](https://www.cnblogs.com/clnchanpin/p/19444719)
- [HarmonyOS 要点笔记之包结构与模块HAP、HSP、HAR - 掘金](https://juejin.cn/post/7382891667672170546)
- [鸿蒙原生APP开发之应用架构设计(模块化设计) - 知乎](https://zhuanlan.zhihu.com/p/31844023534)
- [【HarmonyOS NEXT】HAP/HAR/HSP - CSDN](https://blog.csdn.net/weixin_71403100/article/details/156312822)
- [第十课：HarmonyOS Next应用打包与发布全流程解析 - 掘金](https://juejin.cn/post/7475973902658846731)
- [深入解析HarmonyOS应用包管理Bundle：从原理到实践 - CSDN](https://blog.csdn.net/u013176440/article/details/155108943)

### 社区资源
- [【HarmonyOS Next】鸿蒙中App、HAP、HAR、HSP概念详解 - 华为云社区](https://bbs.huaweicloud.com/blogs/449508)
- [HarmonyOS NEXT中怎么理解HAR、HAP、HSP、App的关系 - CSDN](https://harmonyosdev.csdn.net/69490441836da3214486c37c.html)
- [Harmony中的HAP、HAR、HSP区别 - 阿里云开发者社区](https://developer.aliyun.com/article/1626300)
- [Harmony中的HAP、HAR、HSP区别 - 腾讯云开发者社区](https://cloud.tencent.com/developer/article/2494614)
- [HSP转HAR的解决方案 - 华为云开发者论坛](https://bbs.huaweicloud.com/forum/thread-0212720417378254416-1-1.html)
