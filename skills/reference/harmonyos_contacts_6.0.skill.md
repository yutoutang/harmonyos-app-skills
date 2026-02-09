# 鸿蒙 HarmonyOS 6.0 联系人 (Contacts) 开发 Skill

## 概述

本 Skill 提供 HarmonyOS 6.0 联系人管理功能的开发指南，包括联系人的添加、查询、更新、删除等核心操作。

## 模块信息

- **模块名称**: `@ohos.contact`
- **API 版本**: API 7+
- **更新日期**: 2026年1月
- **官方文档**: [ohos.contact (联系人)](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/js-apis-contact)

## 导入模块

```typescript
import contact from '@ohos.contact';
```

## 权限要求

在使用联系人功能前，需要在 `module.json5` 中声明以下权限：

```json
{
  "requestPermissions": [
    {
      "name": "ohos.permission.READ_CONTACTS",
      "reason": "$string:contact_read_reason",
      "usedScene": {
        "abilities": ["EntryAbility"],
        "when": "inuse"
      }
    },
    {
      "name": "ohos.permission.WRITE_CONTACTS",
      "reason": "$string:contact_write_reason",
      "usedScene": {
        "abilities": ["EntryAbility"],
        "when": "inuse"
      }
    }
  ]
}
```

## 核心功能

### 1. 添加联系人

#### 方式一：通过 UI 添加联系人

```typescript
import contact from '@ohos.contact';

// 添加联系人并打开系统编辑界面
async function addContactViaUI() {
  try {
    // 构建联系人对象
    const contactData = {
      attributes: [
        {
          key: 'name',
          value: '张三'
        },
        {
          key: 'phone',
          value: '13800138000'
        },
        {
          key: 'email',
          value: 'zhangsan@example.com'
        }
      ]
    };

    // 打开系统联系人编辑界面
    await contact.addContact(contactData);
    console.info('添加联系人成功');
  } catch (err) {
    console.error('添加联系人失败:', err);
  }
}
```

#### 方式二：直接添加联系人（无 UI）

```typescript
async function addContactDirectly() {
  try {
    // 创建联系人对象
    const contactData = {
      attributes: [
        {
          key: contact.Attribute.ATTR_NAME,
          value: '李四'
        },
        {
          key: contact.Attribute.ATTR_PHONE_NUMBER,
          value: '13900139000'
        },
        {
          key: contact.Attribute.ATTR_EMAIL,
          value: 'lisi@example.com'
        },
        {
          key: contact.Attribute.ATTR_ADDRESS,
          value: '北京市朝阳区'
        }
      ]
    };

    // 直接添加到联系人数据库
    const result = await contact.addContact(contactData, {
      isAddedToFavorite: false
    });
    console.info('联系人 ID:', result);
  } catch (err) {
    console.error('添加联系人失败:', err);
  }
}
```

### 2. 查询联系人

#### 查询所有联系人

```typescript
async function queryAllContacts() {
  try {
    const contacts = await contact.queryContacts({});
    console.info('联系人总数:', contacts.length);

    contacts.forEach((item, index) => {
      console.info(`联系人 ${index + 1}:`, JSON.stringify(item));
    });
  } catch (err) {
    console.error('查询联系人失败:', err);
  }
}
```

#### 根据条件查询联系人

```typescript
async function queryContactsByCondition() {
  try {
    // 按姓名查询
    const hold = {
      attributes: [contact.Attribute.ATTR_NAME],
      value: '张三',
      condition: contact.ContactCondition.EQUALS
    };

    const contacts = await contact.queryContacts(hold);
    console.info('查询结果:', contacts.length);
  } catch (err) {
    console.error('查询失败:', err);
  }
}
```

#### 根据 ID 查询联系人

```typescript
async function queryContactById(contactId: number) {
  try {
    const contactData = await contact.queryContact(contactId);
    console.info('联系人详情:', JSON.stringify(contactData));
  } catch (err) {
    console.error('查询失败:', err);
  }
}
```

### 3. 更新联系人

```typescript
async function updateContact(contactId: number) {
  try {
    const contactData = {
      id: contactId,
      attributes: [
        {
          key: contact.Attribute.ATTR_NAME,
          value: '张三（更新）'
        },
        {
          key: contact.Attribute.ATTR_PHONE_NUMBER,
          value: '13800138888'
        }
      ]
    };

    await contact.updateContact(contactData);
    console.info('更新联系人成功');
  } catch (err) {
    console.error('更新联系人失败:', err);
  }
}
```

### 4. 删除联系人

```typescript
async function deleteContact(contactId: number) {
  try {
    // 删除单个联系人
    await contact.deleteContact(contactId);
    console.info('删除联系人成功');
  } catch (err) {
    console.error('删除联系人失败:', err);
  }
}

// 批量删除联系人
async function deleteMultipleContacts(contactIds: number[]) {
  try {
    await contact.batchDelete(contactIds);
    console.info('批量删除成功');
  } catch (err) {
    console.error('批量删除失败:', err);
  }
}
```

### 5. 搜索联系人

```typescript
async function searchContacts(keyword: string) {
  try {
    const holder = {
      attributes: [
        contact.Attribute.ATTR_NAME,
        contact.Attribute.ATTR_PHONE_NUMBER,
        contact.Attribute.ATTR_EMAIL
      ],
      value: keyword,
      condition: contact.ContactCondition.CONTAINS
    };

    const contacts = await contact.queryContacts(holder);
    console.info('搜索结果:', contacts.length);
    return contacts;
  } catch (err) {
    console.error('搜索失败:', err);
    return [];
  }
}
```

## 联系人属性常量

| 属性常量 | 说明 |
|---------|------|
| `ATTR_NAME` | 姓名 |
| `ATTR_PHONE_NUMBER` | 电话号码 |
| `ATTR_EMAIL` | 电子邮件 |
| `ATTR_ADDRESS` | 地址 |
| `ATTR_ORGANIZATION` | 组织 |
| `ATTR_EVENT` | 事件（生日等） |
| `ATTR_IM` | 即时通讯 |
| `ATTR_NOTE` | 备注 |
| `ATTR_NICKNAME` | 昵称 |
| `ATTR_WEBSITE` | 网站 |

## 条件常量

| 条件常量 | 说明 |
|---------|------|
| `EQUALS` | 等于 |
| `CONTAINS` | 包含 |
| `STARTS_WITH` | 以...开始 |
| `ENDS_WITH` | 以...结束 |

## 完整示例：联系人管理页面

```typescript
import contact from '@ohos.contact';

@Entry
@Component
struct ContactManager {
  @State contacts: Array<Object> = [];
  @State searchText: string = '';

  aboutToAppear() {
    this.loadContacts();
  }

  // 加载所有联系人
  async loadContacts() {
    try {
      this.contacts = await contact.queryContacts({});
    } catch (err) {
      console.error('加载联系人失败:', err);
    }
  }

  // 添加联系人
  async addContact() {
    const contactData = {
      attributes: [
        { key: contact.Attribute.ATTR_NAME, value: '新联系人' },
        { key: contact.Attribute.ATTR_PHONE_NUMBER, value: '13800000000' }
      ]
    };

    try {
      await contact.addContact(contactData);
      this.loadContacts();
    } catch (err) {
      console.error('添加失败:', err);
    }
  }

  // 搜索联系人
  async searchContacts() {
    if (!this.searchText) {
      this.loadContacts();
      return;
    }

    try {
      const holder = {
        attributes: [
          contact.Attribute.ATTR_NAME,
          contact.Attribute.ATTR_PHONE_NUMBER
        ],
        value: this.searchText,
        condition: contact.ContactCondition.CONTAINS
      };

      this.contacts = await contact.queryContacts(holder);
    } catch (err) {
      console.error('搜索失败:', err);
    }
  }

  build() {
    Column() {
      // 搜索栏
      Row() {
        TextInput({ placeholder: '搜索联系人' })
          .onChange((value: string) => {
            this.searchText = value;
          })
          .layoutWeight(1)

        Button('搜索')
          .onClick(() => this.searchContacts())
      }
      .padding(10)
      .width('100%')

      // 添加按钮
      Button('添加联系人')
        .onClick(() => this.addContact())
        .margin({ top: 10 })

      // 联系人列表
      List({ space: 10 }) {
        ForEach(this.contacts, (item: Object, index: number) => {
          ListItem() {
            Text(JSON.stringify(item))
              .fontSize(16)
              .padding(10)
          }
        })
      }
      .padding(10)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}
```

## 最佳实践

### 1. 权限申请最佳实践

```typescript
import abilityAccessCtrl from '@ohos.abilityAccessCtrl';
import { BusinessError } from '@ohos.base';

async function requestContactPermissions() {
  const atManager = abilityAccessCtrl.createAtManager();

  try {
    // 请求读取联系人权限
    await atManager.requestPermissionsFromUser(context, [
      'ohos.permission.READ_CONTACTS',
      'ohos.permission.WRITE_CONTACTS'
    ]);
  } catch (err) {
    const error = err as BusinessError;
    console.error(`权限请求失败: ${error.code}, ${error.message}`);
  }
}
```

### 2. 错误处理

```typescript
async function handleContactOperation() {
  try {
    // 联系人操作
    await contact.addContact(contactData);
  } catch (err) {
    if (err.code === 201) {
      console.error('权限被拒绝');
    } else if (err.code === 13900001) {
      console.error('参数错误');
    } else {
      console.error('未知错误:', err.code, err.message);
    }
  }
}
```

### 3. 性能优化

- 使用分页查询大量联系人
- 避免在主线程中进行大量联系人操作
- 使用缓存减少重复查询

## 常见错误码

| 错误码 | 说明 |
|--------|------|
| 201 | 权限验证失败 |
| 13900001 | 参数错误 |
| 13900002 | 联系人不存在 |
| 13900003 | 数据库操作失败 |

## 参考资料

- [华为开发者联盟 - 联系人 API 参考](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/js-apis-contact)
- [HarmonyOS 6.0 读取系统联系人实战案例](https://blog.csdn.net/wujiangbo520/article/details/157217096)
- [鸿蒙联系人管理开发指南](https://blog.csdn.net/weixin_56727963/article/details/148983398)
