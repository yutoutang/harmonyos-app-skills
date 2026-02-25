# 鸿蒙 HarmonyOS 6.0 系统路由表 (Navigation) 开发 Skill

## 概述

本 Skill 提供 HarmonyOS 6.0 页面路由与导航的开发指南。从 API 12 开始，**Navigation 组件**是官方推荐的路由方案，支持系统路由表管理，适用于模块内和跨模块的页面切换，提供更流畅的转场动效和完整的生命周期管理。

## 重要说明

- **Navigation 组件**：官方推荐方案，提供更好的转场动效和生命周期管理
- **系统路由表**：从 API 12 开始支持，路由表方案下沉到系统中管理
- **适用场景**：适用于模块内和跨模块的路由切换

## 模块信息

- **组件名称**: `Navigation`
- **API 版本**: API 12+ (系统路由表)
- **更新日期**: 2026年1月
- **官方文档**:
  - [组件导航 Navigation - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-navigation-navigation)
  - [组件导航和页面路由概述 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-navigation-introduction)

## 一、Navigation 组件基础

### 1.1 导入模块

```typescript
import { Navigation, NavPathStack } from '@kit.ArkUI';
```

### 1.2 简单的 Navigation 示例

```typescript
@Entry
@Component
struct NavigationExample {
  // 创建导航栈
  @Provide('NavPathStack') navPathStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.navPathStack) {
      Column() {
        Text('首页')
          .fontSize(24)

        Button('跳转到详情页')
          .onClick(() => {
            // 跳转到详情页
            this.navPathStack.pushPath({ name: 'DetailPage' });
          })
      }
    }
    .title('Navigation 示例')
    .titleMode(NavigationTitleMode.Mini)
  }
}
```

## 二、系统路由表配置（API 12+）

从 API 12 开始，Navigation 支持系统路由表方案。各业务模块（HSP/HAR）中独立配置路由表。

### 2.1 配置步骤

**步骤 1：在模块目录下创建 `router_map.json` 文件**

```json
{
  "routerMap": [
    {
      "name": "DetailPage",
      "pageSourceFile": "src/main/ets/pages/DetailPage.ets",
      "buildFunction": "DetailPageBuilder"
    },
    {
      "name": "UserProfile",
      "pageSourceFile": "src/main/ets/pages/UserProfile.ets",
      "buildFunction": "UserProfileBuilder"
    },
    {
      "name": "SettingsPage",
      "pageSourceFile": "src/main/ets/pages/SettingsPage.ets",
      "buildFunction": "SettingsPageBuilder"
    }
  ]
}
```

**步骤 2：在模块的 `module.json5` 中声明路由配置**

```json
{
  "module": {
    "name": "entry",
    "type": "entry",
    "routerMap": "$profile:router_map"
  }
}
```

**步骤 3：创建目标页面（必须使用 NavDestination 包裹）**

> **重要**：从 API 12 开始，使用系统路由表跳转的目标页面**必须使用 NavDestination 包裹**，否则无法正常跳转和显示。

```typescript
// DetailPage.ets
@Component
export struct DetailPage {
  @State message: string = '详情页';

  build() {
    // 必须使用 NavDestination 包裹页面内容
    NavDestination() {
      Column() {
        Text(this.message)
          .fontSize(24)
          .margin(20)

        Button('返回')
          .onClick(() => {
            // 获取路由栈并返回
            const navPathStack = NavigationManager.getNavPathStack();
            navPathStack.pop();
          })
      }
      .width('100%')
      .height('100%')
    }
    .title('详情页') // 设置导航栏标题
    .mode(NavDestinationMode.STANDARD) // 标准模式
  }
}

// 导出页面构建函数
export function DetailPageBuilder() {
  DetailPage();
}
```

**NavDestination 常用配置：**

```typescript
NavDestination() {
  // 页面内容
}
.title('页面标题')                    // 导航栏标题
.subtitle('副标题')                  // 导航栏副标题
.mode(NavDestinationMode.STANDARD)   // 页面模式：STANDARD(标准) / MODAL(模态)
.hideTitleBar(false)                 // 是否隐藏标题栏
.hideBackButton(false)               // 是否隐藏返回按钮
```

## 三、页面跳转

### 3.1 pushPath - 压入新页面

```typescript
@Entry
@Component
struct HomePage {
  @Provide('NavPathStack') navPathStack: NavPathStack = new NavPathStack();

  // 跳转到详情页（不传参）
  navigateToDetail() {
    this.navPathStack.pushPath({ name: 'DetailPage' });
  }

  // 跳转到详情页（传参）
  navigateToDetailWithParams() {
    this.navPathStack.pushPathByName(
      'DetailPage',
      { id: 1001, title: '商品详情' }
    );
  }

  // 跳转并添加动画
  navigateWithAnimation() {
    this.navPathStack.pushPath(
      { name: 'DetailPage' },
      false, // 不恢复之前的页面状态
      (err) => {
        if (err) {
          console.error('跳转失败:', err);
        }
      }
    );
  }

  build() {
    Navigation(this.navPathStack) {
      Column({ space: 20 }) {
        Button('跳转详情页')
          .onClick(() => this.navigateToDetail())

        Button('跳转详情页（带参数）')
          .onClick(() => this.navigateToDetailWithParams())

        Button('跳转（带动画）')
          .onClick(() => this.navigateWithAnimation())
      }
    }
    .title('首页')
  }
}
```

### 3.2 pushPathByName - 通过路由名称跳转

```typescript
// 使用路由名称跳转，传递参数
navigateByName() {
  const params = {
    userId: 12345,
    userName: '张三'
  };

  this.navPathStack.pushPathByName(
    'UserProfile', // 路由名称
    params,        // 传递的参数
    (err) => {
      if (err) {
        console.error('跳转失败:', err.message);
      } else {
        console.info('跳转成功');
      }
    }
  );
}
```

### 3.3 replacePath - 替换当前页面

```typescript
// 替换当前页面（不保留当前页面在栈中）
replaceCurrentPage() {
  this.navPathStack.replacePath(
    { name: 'SettingsPage' },
    (err) => {
      if (err) {
        console.error('替换页面失败:', err);
      }
    }
  );
}

// 替换并传递参数
replaceWithName() {
  this.navPathStack.replacePathByName(
    'SettingsPage',
    { theme: 'dark' },
    (err) => {
      console.info('页面已替换');
    }
  );
}
```

### 3.4 pop - 返回上一页

```typescript
// 返回上一页
goBack() {
  this.navPathStack.pop();
}

// 返回并传递结果
goBackWithResult() {
  this.navPathStack.pop({ result: 'success', data: 123 });
}

// 返回到指定页面
popToName() {
  // 返回到名为 'HomePage' 的页面
  this.navPathStack.popToName('HomePage');
}

// 返回到根页面
popToRoot() {
  this.navPathStack.clear();
}
```

### 3.5 获取传递的参数

```typescript
@Component
export struct DetailPage {
  @State productId: number = 0;
  @State productTitle: string = '';

  aboutToAppear() {
    // 获取路由栈
    const navPathStack = NavigationManager.getNavPathStack();

    // 获取传递的参数
    const params = navPathStack.getParamByName('DetailPage') as Record<string, Object>;

    if (params) {
      this.productId = params['id'] as number;
      this.productTitle = params['title'] as string;
    }
  }

  build() {
    Column({ space: 20 }) {
      Text(`商品ID: ${this.productId}`)
        .fontSize(18)

      Text(`商品标题: ${this.productTitle}`)
        .fontSize(18)

      Button('返回')
        .onClick(() => {
          const navPathStack = NavigationManager.getNavPathStack();
          navPathStack.pop();
        })
    }
  }
}
```

## 四、Navigation 导航栏配置

```typescript
@Entry
@Component
struct NavigationTitleExample {
  @Provide('NavPathStack') navPathStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.navPathStack) {
      Column() {
        Text('页面内容')
      }
    }
    // 标题栏配置
    .title('导航标题')
    .titleMode(NavigationTitleMode.Full) // 完整模式
    .subtitle('副标题')
    .menus([
      {
        value: '菜单1',
        icon: './images/menu1.png',
        action: () => {
          console.info('点击菜单1');
        }
      },
      {
        value: '菜单2',
        icon: './images/menu2.png',
        action: () => {
          console.info('点击菜单2');
        }
      }
    ])
    .toolbarConfiguration([
      { value: '工具1', icon: './images/tool1.png' },
      { value: '工具2', icon: './images/tool2.png' }
    ])
    .hideBackButton(false) // 显示返回按钮
    .hideTitleBar(false)   // 显示标题栏
  }
}
```

## 五、Navigation 转场动画

```typescript
// 自定义转场动画
@Entry
@Component
struct NavigationAnimationExample {
  @Provide('NavPathStack') navPathStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.navPathStack) {
      Column() {
        Button('跳转（自定义动画）')
          .onClick(() => {
            this.navPathStack.pushPath(
              { name: 'DetailPage' },
              false,
              (err) => {},
              // 自定义转场动画
              {
                onTransition: (from, to, type) => {
                  if (type === NavigationTransitionType.PUSH) {
                    // 进场动画
                    to.opacity = 0;
                    to.translate({ x: '100%' });
                    animateTo({
                      duration: 300,
                      curve: Curve.EaseInOut
                    }, () => {
                      to.opacity = 1;
                      to.translate({ x: 0 });
                    });
                  } else if (type === NavigationTransitionType.POP) {
                    // 出场动画
                    from.opacity = 1;
                    from.translate({ x: 0 });
                    animateTo({
                      duration: 300,
                      curve: Curve.EaseInOut
                    }, () => {
                      from.opacity = 0;
                      from.translate({ x: '100%' });
                    });
                  }
                }
              }
            );
          })
      }
    }
    .title('转场动画示例')
  }
}
```

## 六、完整示例：多页面应用

```typescript
// App.ets - 应用入口
@Entry
@Component
struct App {
  @Provide('NavPathStack') navPathStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.navPathStack) {
      Column() {
        HomePage()
      }
    }
    .title('我的应用')
  }
}

// HomePage.ets - 首页
@Component
export struct HomePage {
  build() {
    Column({ space: 20 }) {
      List({ space: 15 }) {
        ListItem() {
          this.PageCard('用户资料', 'user', () => {
            this.navPathStack.pushPathByName('UserProfile', { userId: 1001 });
          })
        }

        ListItem() {
          this.PageCard('设置', 'settings', () => {
            this.navPathStack.pushPath({ name: 'SettingsPage' });
          })
        }

        ListItem() {
          this.PageCard('关于', 'info', () => {
            this.navPathStack.pushPath({ name: 'AboutPage' });
          })
        }
      }
    }
    .padding(20)
  }

  @Builder PageCard(title: string, icon: string, onClick: () => void) {
    Row() {
      Text(icon)
        .fontSize(30)

      Text(title)
        .fontSize(18)
        .margin({ left: 15 })
        .layoutWeight(1)

      Text('>')
        .fontSize(16)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(10)
    .onClick(onClick)
  }
}

// UserProfile.ets - 用户资料页
@Component
export struct UserProfile {
  @Consume('NavPathStack') navPathStack: NavPathStack;
  @State userId: number = 0;
  @State userName: string = '';
  @State userAvatar: string = '';

  aboutToAppear() {
    // 获取传递的参数
    const params = this.navPathStack.getParamByName('UserProfile') as Record<string, Object>;
    if (params) {
      this.userId = params['userId'] as number;
      // 这里可以根据 userId 获取用户详细信息
      this.loadUserInfo();
    }
  }

  loadUserInfo() {
    // 模拟加载用户数据
    this.userName = '张三';
    this.userAvatar = 'https://example.com/avatar.jpg';
  }

  build() {
    Column({ space: 20 }) {
      // 用户头像
      Image(this.userAvatar)
        .width(80)
        .height(80)
        .borderRadius(40)

      // 用户名
      Text(this.userName)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 用户ID
      Text(`ID: ${this.userId}`)
        .fontSize(14)
        .fontColor(Color.Gray)

      Divider()

      // 用户信息列表
      List({ space: 1 }) {
        ListItem() {
          Row() {
            Text('手机号')
              .fontSize(16)
            Text('138****8888')
              .fontSize(16)
              .layoutWeight(1)
              .textAlign(TextAlign.End)
              .fontColor(Color.Gray)
          }
          .width('100%')
          .padding(15)
          .backgroundColor(Color.White)
        }

        ListItem() {
          Row() {
            Text('邮箱')
              .fontSize(16)
            Text('zhangsan@example.com')
              .fontSize(16)
              .layoutWeight(1)
              .textAlign(TextAlign.End)
              .fontColor(Color.Gray)
          }
          .width('100%')
          .padding(15)
          .backgroundColor(Color.White)
        }
      }
      .divider({ strokeWidth: 1, color: '#F0F0F0' })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F5F5F5')
  }
}
```

## 七、高级功能

### 7.1 路由拦截器

```typescript
class RouterInterceptor {
  // 路由前置拦截
  static async beforeNavigate(
    navPathStack: NavPathStack,
    targetName: string,
    params: Object
  ): Promise<boolean> {
    // 检查登录状态
    const isLoggedIn = await checkLoginStatus();
    if (!isLoggedIn) {
      // 未登录，跳转到登录页
      navPathStack.pushPath({ name: 'LoginPage' });
      return false;
    }

    // 检查权限
    const hasPermission = await checkPermission(targetName);
    if (!hasPermission) {
      console.error('无权限访问:', targetName);
      return false;
    }

    return true;
  }

  // 路由后置处理
  static afterNavigate(targetName: string) {
    // 页面访问统计
    reportPageView(targetName);
  }
}

// 使用拦截器
async function navigateWithInterceptor(
  navPathStack: NavPathStack,
  pageName: string,
  params: Object
) {
  const canNavigate = await RouterInterceptor.beforeNavigate(
    navPathStack,
    pageName,
    params
  );

  if (canNavigate) {
    navPathStack.pushPathByName(pageName, params, (err) => {
      if (!err) {
        RouterInterceptor.afterNavigate(pageName);
      }
    });
  }
}
```

### 7.2 嵌套导航

```typescript
@Component
struct NestedNavigationExample {
  @Provide('ChildNavStack') childNavStack: NavPathStack = new NavPathStack();

  build() {
    Column() {
      // 子导航
      Navigation(this.childNavStack) {
        Column() {
          Text('子导航页面')
            .fontSize(20)

          Button('跳转到子页面')
            .onClick(() => {
              this.childNavStack.pushPath({ name: 'ChildDetailPage' });
            })
        }
      }
      .title('子导航')
      .titleMode(NavigationTitleMode.Mini)
      .height('50%')

      Divider()

      // 父导航内容
      Text('父导航内容')
        .fontSize(20)
    }
  }
}
```

### 7.3 路由动画定制

```typescript
// 自定义页面转场动画
@Entry
@Component
struct CustomTransitionExample {
  @Provide('NavPathStack') navPathStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.navPathStack) {
      Column() {
        Button('跳转（淡入淡出）')
          .onClick(() => {
            this.navPathStack.pushPath(
              { name: 'DetailPage' },
              false,
              () => {},
              {
                onTransition: (from, to, type) => {
                  if (type === NavigationTransitionType.PUSH) {
                    to.opacity = 0;
                    animateTo({ duration: 500 }, () => {
                      to.opacity = 1;
                    });
                  } else if (type === NavigationTransitionType.POP) {
                    from.opacity = 1;
                    animateTo({ duration: 500 }, () => {
                      from.opacity = 0;
                    });
                  }
                }
              }
            );
          })
      }
    }
  }
}
```

### 7.4 路由状态管理

```typescript
// Navigation 管理器单例
class NavigationManager {
  private static instance: NavigationManager;
  private navPathStack: NavPathStack;

  private constructor() {
    this.navPathStack = new NavPathStack();
  }

  static getInstance(): NavigationManager {
    if (!NavigationManager.instance) {
      NavigationManager.instance = new NavigationManager();
    }
    return NavigationManager.instance;
  }

  getNavPathStack(): NavPathStack {
    return this.navPathStack;
  }

  // 获取当前页面
  getCurrentPage(): string {
    const allPages = this.navPathStack.getAllPathName();
    return allPages[allPages.length - 1];
  }

  // 获取页面栈深度
  getStackSize(): number {
    return this.navPathStack.size();
  }

  // 判断是否可以返回
  canGoBack(): boolean {
    return this.getStackSize() > 1;
  }
}

// 使用示例
const navManager = NavigationManager.getInstance();
const navPathStack = navManager.getNavPathStack();

console.info('当前页面:', navManager.getCurrentPage());
console.info('页面栈深度:', navManager.getStackSize());
console.info('是否可以返回:', navManager.canGoBack());
```

## 八、最佳实践

### 8.1 路由命名规范

```typescript
// 推荐的路由命名方式
const ROUTE_NAMES = {
  // 首页相关
  HOME: 'HomePage',
  HOME_TAB: 'HomeTabPage',

  // 用户相关
  USER_PROFILE: 'UserProfile',
  USER_LOGIN: 'UserLogin',
  USER_REGISTER: 'UserRegister',
  USER_SETTINGS: 'UserSettings',

  // 商品相关
  PRODUCT_LIST: 'ProductListPage',
  PRODUCT_DETAIL: 'ProductDetailPage',
  PRODUCT_SEARCH: 'ProductSearchPage',

  // 订单相关
  ORDER_LIST: 'OrderListPage',
  ORDER_DETAIL: 'OrderDetailPage',
  ORDER_CREATE: 'OrderCreatePage'
};

// 使用常量跳转
navPathStack.pushPathByName(ROUTE_NAMES.PRODUCT_DETAIL, { id: 1001 });
```

### 8.2 参数传递规范

```typescript
// 定义页面参数接口
interface ProductDetailParams {
  id: number;
  title?: string;
  category?: string;
  from?: string;
}

interface UserProfileParams {
  userId: number;
  userName?: string;
  editable?: boolean;
}

// 使用类型安全的参数传递
function navigateToProductDetail(params: ProductDetailParams) {
  navPathStack.pushPathByName(ROUTE_NAMES.PRODUCT_DETAIL, params);
}

// 使用示例
navigateToProductDetail({
  id: 1001,
  title: '商品标题',
  from: 'list'
});
```

### 8.3 路由跳转封装

```typescript
// 路由工具类
class RouterUtil {
  // 跳转到登录页
  static goToLogin(redirectUrl?: string) {
    const navStack = NavigationManager.getInstance().getNavPathStack();
    navStack.pushPathByName('UserLogin', { redirectUrl });
  }

  // 跳转到用户资料
  static goToUserProfile(userId: number) {
    const navStack = NavigationManager.getInstance().getNavPathStack();
    navStack.pushPathByName('UserProfile', { userId });
  }

  // 返回并刷新
  static goBackWithRefresh() {
    const navStack = NavigationManager.getInstance().getNavPathStack();
    navStack.pop({ refresh: true });
  }

  // 跳转到详情页
  static goToDetail(id: number, type: string) {
    const navStack = NavigationManager.getInstance().getNavPathStack();
    navStack.pushPathByName('DetailPage', { id, type });
  }
}

// 使用示例
RouterUtil.goToLogin('pages/HomePage');
RouterUtil.goToUserProfile(12345);
RouterUtil.goToDetail(1001, 'product');
```

### 8.4 错误处理

```typescript
// 完善的错误处理
async function safeNavigate(
  navPathStack: NavPathStack,
  pageName: string,
  params?: Object
): Promise<boolean> {
  try {
    // 检查路由是否注册
    const allPages = navPathStack.getAllPathName();
    if (!allPages.includes(pageName)) {
      console.error('路由未注册:', pageName);
      return false;
    }

    // 执行跳转
    return new Promise((resolve) => {
      navPathStack.pushPathByName(
        pageName,
        params || {},
        (err) => {
          if (err) {
            console.error('跳转失败:', err);
            resolve(false);
          } else {
            console.info('跳转成功:', pageName);
            resolve(true);
          }
        }
      );
    });
  } catch (error) {
    console.error('跳转异常:', error);
    return false;
  }
}

// 使用示例
const success = await safeNavigate(
  navPathStack,
  'DetailPage',
  { id: 1001 }
);

if (!success) {
  // 处理跳转失败的情况
  showToast('页面跳转失败，请重试');
}
```

## 九、常见问题

### 9.1 路由找不到

**问题**：跳转时提示路由未注册

**解决方案**：
1. 检查 `router_map.json` 文件是否存在
2. 检查路由名称是否拼写正确
3. 检查 `module.json5` 中是否声明了 `routerMap`

### 9.2 参数传递丢失

**问题**：页面跳转后获取不到参数

**解决方案**：
```typescript
// 确保使用正确的方式获取参数
const params = navPathStack.getParamByName('DetailPage') as Record<string, Object>;
if (params) {
  // 处理参数
} else {
  console.warn('未获取到参数');
}
```

### 9.3 页面栈溢出

**问题**：页面栈过深导致内存问题

**解决方案**：
```typescript
// 定期清理页面栈，或者使用 replacePath
if (navPathStack.size() > 10) {
  navPathStack.popToName('HomePage');
}

// 或使用 replace 替代 push
navPathStack.replacePathByName('DetailPage', params);
```

## 十、版本兼容性

| API 版本 | Navigation 系统路由表 |
|----------|---------------------|
| API 9 | ❌ 不支持 |
| API 10 | ❌ 不支持 |
| API 11 | ❌ 不支持 |
| API 12+ | ✅ 推荐 |
| API 13+ | ✅ 完整支持 |

## 十一、核心 API 速查

### 页面跳转

```typescript
// 压入新页面
navPathStack.pushPath({ name: 'DetailPage' });
navPathStack.pushPathByName('DetailPage', { id: 1001 });

// 替换当前页
navPathStack.replacePath({ name: 'HomePage' });
navPathStack.replacePathByName('HomePage', {});

// 返回上一页
navPathStack.pop();

// 返回并传递结果
navPathStack.pop({ result: 'success' });

// 返回到指定页面
navPathStack.popToName('HomePage');

// 清空页面栈
navPathStack.clear();
```

### 获取路由信息

```typescript
// 获取所有页面名称
const allPages = navPathStack.getAllPathName();

// 获取页面栈大小
const size = navPathStack.size();

// 获取传递的参数
const params = navPathStack.getParamByName('DetailPage');
```

## 十二、参考资料

### 官方文档
- [组件导航 Navigation - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-navigation-navigation)
- [组件导航和页面路由概述 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-navigation-introduction)

### 实战教程
- [HarmonyOS Next导航与路由开发指南](https://blog.csdn.net/m0_71441912/article/details/145865574)
- [ArkTS实现的动态路由架构设计 - 华为云社区](https://bbs.huaweicloud.com/forum/thread-0212720313915439401-1-1.html)
- [ArkUI 导航架构Navigation 组件与路由栈管理最佳实践](https://segmentfault.com/a/1190000047552973)
- [HarmonyOS6 - 路由组件router和组件导航Navigation](https://blog.csdn.net/wujiangbo520/article/details/156914110)

### 社区资源
- [Harmony OS next页面跳转该使用什么路由方案？](https://developer.huawei.com/consumer/cn/forum/topic/0203170068973886406)
- 【HarmonyOS NEXT星河版开发实战】页面跳转 - 腾讯云
- 【HarmonyOS Next开发】Navigation使用 - 阿里云开发者社区

### 第三方框架
- [HMRouter - 鸿蒙路由管理框架](https://cloud.tencent.com/developer/article/2535668)
- [HarmonyOS Next 优雅的路由跳转方案ZRouter](https://juejin.cn/post/7503437639690207268)
