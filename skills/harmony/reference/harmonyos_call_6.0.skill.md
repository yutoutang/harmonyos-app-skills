# 鸿蒙 HarmonyOS 6.0 拨打电话 (Call) 开发 Skill

## 概述

本 Skill 提供 HarmonyOS 6.0 拨打电话功能的开发指南。三方应用可通过 `makeCall` 接口拉起系统电话应用，用户确认后拨出通话。系统应用可直接拨打电话并在应用界面显示通话界面。

## 模块信息

- **模块名称**: `@ohos.telephony.call`
- **API 版本**: API 6+
- **更新日期**: 2026年1月
- **官方文档**: [拨打电话 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/telephony-call)
- **API 参考**: [ohos.telephony.call (拨打电话)](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V14/js-apis-call-V14)

## 导入模块

```typescript
import call from '@ohos.telephony.call';
```

## 权限要求

在使用拨打电话功能前，需要在 `module.json5` 中声明以下权限：

```json
{
  "requestPermissions": [
    {
      "name": "ohos.permission.PLACE_CALL",
      "reason": "$string:place_call_reason",
      "usedScene": {
        "abilities": ["EntryAbility"],
        "when": "inuse"
      }
    }
  ]
}
```

**权限说明**：
- **三方应用**: 建议使用 `makeCall` 接口拉起系统电话应用，由用户确认后拨出通话
- **系统应用**: 可直接拨打电话，无需用户确认

## 场景介绍

### 三方应用场景
使用 `makeCall` 接口拉起拨号界面，用户点击拨号按钮后发起通话。

### 系统应用场景
使用 `makeCall` 接口直接拨打电话，并在应用内显示通话界面。

## 一、拨打电话

### 1. 基础拨打电话（拉起拨号界面）

```typescript
import call from '@ohos.telephony.call';

async function makeCall(phoneNumber: string) {
  try {
    // 拉起系统拨号界面
    await call.makeCall(phoneNumber, false);
    console.info('拉起拨号界面成功');
  } catch (err) {
    console.error('拉起拨号界面失败:', err);
  }
}
```

### 2. 直接拨打电话（系统应用）

```typescript
async function makeDirectCall(phoneNumber: string) {
  try {
    // 直接拨打电话，不显示拨号界面
    await call.makeCall(phoneNumber, true);
    console.info('拨打电话成功');
  } catch (err) {
    console.error('拨打电话失败:', err);
  }
}
```

### 3. 完整示例：拨打电话页面

```typescript
import call from '@ohos.telephony.call';

@Entry
@Component
struct CallPhonePage {
  @State phoneNumber: string = '';
  @State callResult: string = '';

  // 拨打电话
  async makeCall() {
    if (!this.phoneNumber) {
      this.callResult = '请输入电话号码';
      return;
    }

    try {
      // 拉起拨号界面
      await call.makeCall(this.phoneNumber, false);
      this.callResult = '已拉起拨号界面';
    } catch (err) {
      console.error('拨打电话失败:', err);
      this.callResult = '拨打电话失败: ' + err.message;
    }
  }

  build() {
    Column() {
      Text('拨打电话')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 50, bottom: 30 })

      // 电话号码输入框
      TextInput({ placeholder: '请输入电话号码', text: this.phoneNumber })
        .type(InputType.PhoneNumber)
        .fontSize(18)
        .onChange((value: string) => {
          this.phoneNumber = value;
        })
        .margin({ bottom: 20 })

      // 拨打按钮
      Button('拨打')
        .width('80%')
        .height(50)
        .fontSize(18)
        .onClick(() => this.makeCall())
        .margin({ bottom: 20 })

      // 结果显示
      Text(this.callResult)
        .fontSize(16)
        .fontColor(this.callResult.includes('失败') ? Color.Red : Color.Green)
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}
```

### 4. 带联系人的拨号示例

```typescript
import call from '@ohos.telephony.call';
import { BusinessError } from '@ohos.base';

@Entry
@Component
struct ContactCallPage {
  @State contacts: Array<ContactInfo> = [
    { name: '张三', phone: '13800138000' },
    { name: '李四', phone: '13900139000' },
    { name: '王五', phone: '13700137000' }
  ];

  // 从联系人拨打电话
  async callContact(phoneNumber: string, name: string) {
    try {
      await call.makeCall(phoneNumber, false);
      console.info(`正在拨打 ${name}: ${phoneNumber}`);
    } catch (err) {
      const error = err as BusinessError;
      console.error(`拨打 ${name} 失败:`, error.message);
    }
  }

  build() {
    Column() {
      Text('联系人列表')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })

      List({ space: 10 }) {
        ForEach(this.contacts, (contact: ContactInfo, index: number) => {
          ListItem() {
            Row() {
              Column() {
                Text(contact.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                Text(contact.phone)
                  .fontSize(14)
                  .fontColor(Color.Gray)
                  .margin({ top: 5 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button('拨打')
                .onClick(() => this.callContact(contact.phone, contact.name))
            }
            .width('100%')
            .padding(15)
            .backgroundColor(Color.White)
            .borderRadius(8)
          }
        })
      }
      .padding(10)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
    .padding(15)
  }
}

interface ContactInfo {
  name: string;
  phone: string;
}
```

## 二、通话状态监听

### 1. 监听通话状态变化

```typescript
import call from '@ohos.telephony.call';

class CallStateManager {
  private observerId: number = -1;

  // 注册通话状态监听
  registerCallStateListener() {
    try {
      // 订阅通话状态
      call observer.on('callStateChange', (data) => {
        console.info('通话状态变化:', JSON.stringify(data));

        // 状态值说明
        switch (data.callState) {
          case call.CallState.CALL_STATUS_IDLE:
            console.info('状态: 空闲');
            break;
          case call.CallState.CALL_STATUS_RINGING:
            console.info('状态: 响铃中');
            break;
          case call.CallState.CALL_STATUS_OFFERING:
            console.info('状态: 正在接听');
            break;
          case call.CallState.CALL_STATUS_ACTIVE:
            console.info('状态: 通话中');
            break;
          case call.CallState.CALL_STATUS_HOLDING:
            console.info('状态: 保持中');
            break;
          case call.CallState.CALL_STATUS_DIALING:
            console.info('状态: 拨号中');
            break;
          case call.CallState.CALL_STATUS_DISCONNECTED:
            console.info('状态: 已断开');
            break;
          case call.CallState.CALL_STATUS_DISCONNECTING:
            console.info('状态: 正在断开');
            break;
          default:
            console.info('状态: 未知');
        }
      });

      console.info('通话状态监听注册成功');
    } catch (err) {
      console.error('注册监听失败:', err);
    }
  }

  // 取消通话状态监听
  unregisterCallStateListener() {
    try {
      call observer.off('callStateChange');
      console.info('通话状态监听取消成功');
    } catch (err) {
      console.error('取消监听失败:', err);
    }
  }
}

// 使用示例
const callStateManager = new CallStateManager();
callStateManager.registerCallStateListener();
```

### 2. 获取当前通话状态

```typescript
import call from '@ohos.telephony.call';

async function getCurrentCallState() {
  try {
    const state = await call.getCallState();
    console.info('当前通话状态:', state);

    // 状态说明
    if (state === call.CallState.CALL_STATUS_IDLE) {
      console.info('当前空闲');
    } else if (state === call.CallState.CALL_STATUS_ACTIVE) {
      console.info('正在通话中');
    } else if (state === call.CallState.CALL_STATUS_RINGING) {
      console.info('正在响铃');
    }

    return state;
  } catch (err) {
    console.error('获取通话状态失败:', err);
    return call.CallState.CALL_STATUS_IDLE;
  }
}
```

## 三、电话号码格式化

### 1. 格式化电话号码

```typescript
import call from '@ohos.telephony.call';

function formatPhoneNumber(phoneNumber: string): string {
  try {
    // 格式化电话号码
    const formatted = call.formatPhoneNumber(phoneNumber, 'CN');
    console.info('格式化前:', phoneNumber);
    console.info('格式化后:', formatted);
    return formatted;
  } catch (err) {
    console.error('格式化失败:', err);
    return phoneNumber;
  }
}

// 使用示例
const formatted = formatPhoneNumber('13800138000');
// 输出: 138 0013 8000
```

### 2. 格式化电话号码并获取格式字符串

```typescript
import call from '@ohos.telephony.call';

function formatPhoneNumberWithPattern(phoneNumber: string): {
  formattedNumber: string;
  formatPattern: string;
} {
  try {
    const result = call.formatPhoneNumberToE164(phoneNumber, 'CN');
    console.info('E164格式:', result);
    return result;
  } catch (err) {
    console.error('格式化失败:', err);
    return {
      formattedNumber: phoneNumber,
      formatPattern: ''
    };
  }
}
```

## 四、判断是否紧急号码

```typescript
import call from '@ohos.telephony.call';

async function checkEmergencyNumber(phoneNumber: string) {
  try {
    const isEmergency = await call.isInEmergencyCall(phoneNumber);
    if (isEmergency) {
      console.info(`${phoneNumber} 是紧急号码`);
    } else {
      console.info(`${phoneNumber} 不是紧急号码`);
    }
    return isEmergency;
  } catch (err) {
    console.error('判断失败:', err);
    return false;
  }
}

// 使用示例
await checkEmergencyNumber('110');  // true (紧急号码)
await checkEmergencyNumber('120');  // true (紧急号码)
await checkEmergencyNumber('13800138000');  // false (普通号码)
```

## 五、完整示例：拨号应用

```typescript
import call from '@ohos.telephony.call';
import { BusinessError } from '@ohos.base';

@Entry
@Component
struct DialerApp {
  @State phoneNumber: string = '';
  @State callStatus: string = '空闲';
  @State callHistory: Array<string> = [];

  aboutToAppear() {
    this.registerCallStateListener();
  }

  // 注册通话状态监听
  registerCallStateListener() {
    call.on('callStateChange', (data) => {
      switch (data.callState) {
        case call.CallState.CALL_STATUS_IDLE:
          this.callStatus = '空闲';
          break;
        case call.CallState.CALL_STATUS_DIALING:
          this.callStatus = '拨号中';
          break;
        case call.CallState.CALL_STATUS_RINGING:
          this.callStatus = '响铃中';
          break;
        case call.CallState.CALL_STATUS_ACTIVE:
          this.callStatus = '通话中';
          break;
        case call.CallState.CALL_STATUS_DISCONNECTED:
          this.callStatus = '已断开';
          break;
        default:
          this.callStatus = '未知状态';
      }
    });
  }

  // 拨打电话
  async makeCall() {
    if (!this.phoneNumber) {
      return;
    }

    try {
      await call.makeCall(this.phoneNumber, false);

      // 添加到通话记录
      this.callHistory.unshift(this.phoneNumber);
      if (this.callHistory.length > 10) {
        this.callHistory.pop();
      }
    } catch (err) {
      const error = err as BusinessError;
      console.error('拨打电话失败:', error.message);
    }
  }

  // 从历史记录拨打
  async callFromHistory(phoneNumber: string) {
    this.phoneNumber = phoneNumber;
    await this.makeCall();
  }

  // 清空输入
  clearInput() {
    this.phoneNumber = '';
  }

  // 删除最后一个字符
  deleteLastChar() {
    if (this.phoneNumber.length > 0) {
      this.phoneNumber = this.phoneNumber.slice(0, -1);
    }
  }

  build() {
    Column() {
      // 显示区域
      Column() {
        // 通话状态
        Text(this.callStatus)
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ bottom: 10 })

        // 电话号码显示
        Text(this.phoneNumber || '请输入号码')
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .height(60)
      }
      .width('100%')
      .padding(20)
      .backgroundColor(Color.White)
      .margin({ bottom: 20 })

      // 拨号按钮
      Button('拨打')
        .width('80%')
        .height(50)
        .fontSize(18)
        .backgroundColor('#007DFF')
        .onClick(() => this.makeCall())
        .margin({ bottom: 20 })

      // 数字键盘
      Grid() {
        ForEach(['1', '2', '3', '4', '5', '6', '7', '8', '9', '*', '0', '#'],
          (num: string) => {
            GridItem() {
              Button(num)
                .width(70)
                .height(70)
                .fontSize(24)
                .backgroundColor('#F5F5F5')
                .fontColor(Color.Black)
                .onClick(() => {
                  this.phoneNumber += num;
                })
            }
          }
        )
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsGap(10)
      .columnsGap(10)
      .width('100%')
      .margin({ bottom: 20 })
      .justifyContent(FlexAlign.Center)

      // 操作按钮
      Row() {
        Button('清空')
          .width(100)
          .height(40)
          .onClick(() => this.clearInput())

        Button('删除')
          .width(100)
          .height(40)
          .margin({ left: 10, right: 10 })
          .onClick(() => this.deleteLastChar())
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 20 })

      // 通话记录
      Column() {
        Text('最近通话')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 10 })
          .width('100%')

        List({ space: 5 }) {
          ForEach(this.callHistory, (phone: string, index: number) => {
            ListItem() {
              Row() {
                Text(phone)
                  .fontSize(16)
                  .layoutWeight(1)

                Button('拨打')
                  .height(30)
                  .fontSize(14)
                  .onClick(() => this.callFromHistory(phone))
              }
              .width('100%')
              .padding(10)
              .backgroundColor(Color.White)
              .borderRadius(5)
            }
          })
        }
        .layoutWeight(1)
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FAFAFA')
  }

  aboutToDisappear() {
    // 取消监听
    call.off('callStateChange');
  }
}
```

## 六、常量说明

### CallState - 通话状态

| 状态值 | 说明 |
|--------|------|
| `CALL_STATUS_IDLE` | 空闲状态，无正在进行的通话 |
| `CALL_STATUS_RINGING` | 响铃状态，来电正在响铃 |
| `CALL_STATUS_OFFERING` | 来电正在接听 |
| `CALL_STATUS_ACTIVE` | 激活状态，通话正在进行 |
| `CALL_STATUS_HOLDING` | 保持状态，通话被保持 |
| `CALL_STATUS_DIALING` | 拨号状态，正在拨出电话 |
| `CALL_STATUS_DISCONNECTED` | 断开连接状态，通话已结束 |
| `CALL_STATUS_DISCONNECTING` | 正在断开连接 |

###紧急号码

中国常见的紧急号码：
- **110** - 报警电话
- **119** - 火警电话
- **120** - 急救电话
- **122** - 交通事故报警

## 七、最佳实践

### 1. 拨号前验证

```typescript
async function validateAndCall(phoneNumber: string) {
  // 验证电话号码
  if (!phoneNumber || phoneNumber.length === 0) {
    console.error('电话号码不能为空');
    return false;
  }

  // 检查是否紧急号码
  const isEmergency = await call.isInEmergencyCall(phoneNumber);
  if (isEmergency) {
    console.warn('这是紧急号码，请确认');
  }

  // 拨打电话
  try {
    await call.makeCall(phoneNumber, false);
    return true;
  } catch (err) {
    console.error('拨打电话失败:', err);
    return false;
  }
}
```

### 2. 权限申请

```typescript
import abilityAccessCtrl from '@ohos.abilityAccessCtrl';
import { BusinessError } from '@ohos.base';

async function requestCallPermission(context: Context) {
  const atManager = abilityAccessCtrl.createAtManager();

  try {
    // 请求拨号权限
    const result = await atManager.requestPermissionsFromUser(context, [
      'ohos.permission.PLACE_CALL'
    ]);

    if (result.authResults[0] === 0) {
      console.info('权限授予成功');
      return true;
    } else {
      console.error('权限被拒绝');
      return false;
    }
  } catch (err) {
    const error = err as BusinessError;
    console.error('权限请求失败:', error.code, error.message);
    return false;
  }
}
```

### 3. 错误处理

```typescript
import { BusinessError } from '@ohos.base';

async function handleCallError(phoneNumber: string) {
  try {
    await call.makeCall(phoneNumber, false);
  } catch (err) {
    const error = err as BusinessError;

    switch (error.code) {
      case 201:
        console.error('权限被拒绝，请授予拨号权限');
        break;
      case 202:
        console.error('系统应用才能直接拨打电话');
        break;
      case 401:
        console.error('参数错误，检查电话号码格式');
        break;
      case 8300001:
        console.error('电话模块不可用');
        break;
      case 8300002:
        console.error('通话状态异常');
        break;
      case 8300003:
        console.error('拨打电话失败');
        break;
      default:
        console.error('未知错误:', error.code, error.message);
    }
  }
}
```

### 4. 用户体验优化

```typescript
@Entry
@Component
struct OptimizedCallPage {
  @State phoneNumber: string = '';
  @State isCalling: boolean = false;
  @State errorMessage: string = '';

  async makeCallWithFeedback() {
    if (!this.phoneNumber) {
      this.errorMessage = '请输入电话号码';
      return;
    }

    this.isCalling = true;
    this.errorMessage = '';

    try {
      await call.makeCall(this.phoneNumber, false);

      // 添加震动反馈
      vibrator.startVibration({
        type: 'time',
        duration: 50
      }, {
        usage: 'touch'
      });

    } catch (err) {
      const error = err as BusinessError;
      this.errorMessage = `拨打电话失败: ${error.message}`;
    } finally {
      this.isCalling = false;
    }
  }

  build() {
    Column() {
      TextInput({ placeholder: '请输入电话号码' })
        .type(InputType.PhoneNumber)
        .onChange((value: string) => {
          this.phoneNumber = value;
          this.errorMessage = '';
        })

      Button(this.isCalling ? '正在拨打...' : '拨打')
        .enabled(!this.isCalling)
        .onClick(() => this.makeCallWithFeedback())

      if (this.errorMessage) {
        Text(this.errorMessage)
          .fontColor(Color.Red)
          .fontSize(14)
          .margin({ top: 10 })
      }
    }
  }
}
```

## 八、常见错误码

| 错误码 | 说明 |
|--------|------|
| 201 | 权限验证失败 |
| 202 | 系统应用才能直接拨打电话 |
| 401 | 参数错误 |
| 8300001 | 电话模块不可用 |
| 8300002 | 通话状态异常 |
| 8300003 | 拨打电话失败 |
| 8300999 | 未知错误 |

## 九、注意事项

1. **三方应用限制**：三方应用只能拉起系统拨号界面，不能直接拨打电话
2. **权限申请**：使用前必须申请 `ohos.permission.PLACE_CALL` 权限
3. **电话号码格式**：支持字符串格式，建议在拨号前进行格式验证
4. **紧急号码**：特殊处理紧急号码（110、120、119等）
5. **通话状态监听**：应用退出时记得取消监听，避免内存泄漏
6. **用户体验**：在拨号前验证电话号码，提供清晰的错误提示

## 十、版本兼容性

| API 版本 | 支持情况 |
|----------|---------|
| API 6 | 支持 `makeCall` 基础功能 |
| API 7+ | 支持完整的通话管理功能 |
| API 9+ | 增强的状态监听和格式化功能 |
| API 12+ | HarmonyOS NEXT 新特性支持 |

## 参考资料

### 官方文档
- [拨打电话开发指南 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/telephony-call)
- [ohos.telephony.call API 参考](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V14/js-apis-call-V14)
- [华为开发者联盟文档中心](https://developer.huawei.com/consumer/cn/doc/)

### 实战教程
- [鸿蒙应用开发实战：拨打电话](https://blog.csdn.net/wangsen927/article/details/157021185)
- [HarmonyOS NEXT 实战：拨打电话 - 阿里云开发者](https://developer.aliyun.com/article/1668889)
- [鸿蒙开发进阶：实现拨打电话功能实践](https://blog.csdn.net/wea22984984/article/details/143235621)
- [仓颉开发实战：基于 OpenHarmony 实现拨打电话功能](https://cloud.tencent.com/developer/article/2624907)
- [HarmonyOS 电话服务开发指导](https://juejin.cn/post/7295694519185211401)

### 社区资源
- [OpenHarmony 一键呼叫 - 腾讯云开发者](https://cloud.tencent.com/developer/article/2186381)
- [鸿蒙实战应用开发：拨打电话功能 - HarmonyOS 技术社区](https://bbs.elecfans.com/m/jishu_2415688_1_1.html)
