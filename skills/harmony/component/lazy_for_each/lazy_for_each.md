# LazyForEach 懒加载渲染 HarmonyOS 6.0 开发 Skill

## 概述

LazyForEach 是 ArkUI 的高性能懒加载 API，通过按需渲染（虚拟化）技术，只为可见区域的数据项创建组件实例。适用于大数据量场景（100+ 项），可显著降低内存占用并提升滚动性能。

## 重要说明

- **虚拟化渲染**: 仅渲染可见区域及缓存区的组件
- **数据源要求**: 必须实现 IDataSource 接口
- **适用组件**: 仅支持 List、Grid、Swiper、WaterFlow
- **数据通知**: 数据变化必须调用通知方法更新 UI
- **适用场景**: 大数据量（≥ 100 项）、动态数据、性能敏感场景

## 模块信息

- **API 名称**: LazyForEach
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [LazyForEach - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-lazyforeach-V5)
  - [IDataSource 接口 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-datasource-ifs-V5)

## 一、核心接口

### 1.1 IDataSource 接口

LazyForEach 要求数据源必须实现 `IDataSource` 接口：

```typescript
interface IDataSource {
  totalCount(): number;                                    // 获取数据总数
  getData(index: number): any;                             // 获取指定索引的数据
  registerDataChangeListener(listener: DataChangeListener): void;   // 注册数据变化监听器
  unregisterDataChangeListener(listener: DataChangeListener): void; // 注销数据变化监听器
}
```

### 1.2 DataChangeListener 接口

```typescript
interface DataChangeListener {
  onDataReloaded(): void;              // 数据全部重新加载
  onDataAdd(index: number): void;      // 添加数据
  onDataChange(index: number): void;   // 数据变化
  onDataDelete(index: number): void;   // 删除数据
  onDataMove(from: number, to: number): void;  // 数据移动
}
```

## 二、基础用法

### 2.1 实现基本数据源

```typescript
/**
 * 基础数据源实现
 * 封装 IDataSource 接口，提供数据管理和通知机制
 */
class BasicDataSource implements IDataSource {
  private listeners: DataChangeListener[] = [];
  private originDataArray: any[] = [];

  // 获取数据总数
  totalCount(): number {
    return this.originDataArray.length;
  }

  // 获取指定索引的数据
  getData(index: number): any {
    return this.originDataArray[index];
  }

  // 注册数据变化监听器
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  // 注销数据变化监听器
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  // 通知所有监听器数据已重新加载
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    });
  }

  // 通知所有监听器添加数据
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    });
  }

  // 通知所有监听器数据变化
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    });
  }

  // 通知所有监听器删除数据
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    });
  }

  // 通知所有监听器数据移动
  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
    });
  }

  // 添加数据
  public addData(index: number, data: any): void {
    this.originDataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  // 删除数据
  public removeData(index: number): void {
    this.originDataArray.splice(index, 1);
    this.notifyDataDelete(index);
  }

  // 更新数据
  public updateData(index: number, data: any): void {
    this.originDataArray[index] = data;
    this.notifyDataChange(index);
  }

  // 移动数据
  public moveData(from: number, to: number): void {
    const item = this.originDataArray.splice(from, 1)[0];
    this.originDataArray.splice(to, 0, item);
    this.notifyDataMove(from, to);
  }

  // 重新加载所有数据
  public reloadData(data: any[]): void {
    this.originDataArray = data;
    this.notifyDataReload();
  }
}
```

### 2.2 使用 LazyForEach 渲染列表

```typescript
@ComponentV2
struct LazyForEachBasicExample {
  private dataSource: BasicDataSource = new BasicDataSource();

  aboutToAppear(): void {
    // 初始化数据
    const data: string[] = [];
    for (let i = 0; i < 1000; i++) {
      data.push(`Item ${i}`);
    }
    this.dataSource.reloadData(data);
  }

  build() {
    List({ space: 12 }) {
      LazyForEach(
        this.dataSource,
        (item: string, index: number) => {
          ListItem() {
            Row({ space: 12 }) {
              Text(`${index}`)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#007DFF')
                .width(40)

              Text(item)
                .fontSize(16)
                .layoutWeight(1)
            }
            .width('100%')
            .height(60)
            .padding({ left: 16, right: 16 })
            .backgroundColor(Color.White)
            .borderRadius(8)
          }
        },
        (item: string, index: number) => `item-${index}` // 唯一标识
      )
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16 })
  }
}
```

## 三、数据操作示例

### 3.1 增删改查操作

```typescript
@ComponentV2
struct LazyForEachOperationsExample {
  private dataSource: BasicDataSource = new BasicDataSource();

  aboutToAppear(): void {
    const data = ['Apple', 'Banana', 'Orange', 'Grape', 'Mango'];
    this.dataSource.reloadData(data);
  }

  // 添加数据
  addData(): void {
    this.dataSource.addData(
      this.dataSource.totalCount(),
      `New Item ${this.dataSource.totalCount()}`
    );
  }

  // 删除数据
  removeData(index: number): void {
    if (index >= 0 && index < this.dataSource.totalCount()) {
      this.dataSource.removeData(index);
    }
  }

  // 更新数据
  updateData(index: number): void {
    if (index >= 0 && index < this.dataSource.totalCount()) {
      this.dataSource.updateData(index, `Updated ${this.dataSource.getData(index)}`);
    }
  }

  // 移动数据
  moveData(from: number, to: number): void {
    const count = this.dataSource.totalCount();
    if (from >= 0 && from < count && to >= 0 && to < count) {
      this.dataSource.moveData(from, to);
    }
  }

  build() {
    Column({ space: 16 }) {
      // 操作按钮
      Row({ space: 8 }) {
        Button('添加')
          .onClick(() => this.addData())

        Button('删除末尾')
          .onClick(() => {
            this.removeData(this.dataSource.totalCount() - 1);
          })

        Button('更新首个')
          .onClick(() => this.updateData(0))
      }
      .width('100%')

      // 列表
      List({ space: 8 }) {
        LazyForEach(
          this.dataSource,
          (item: string, index: number) => {
            ListItem() {
              Row({ space: 12 }) {
                Text(`${index}`)
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .width(30)

                Text(item)
                  .fontSize(16)
                  .layoutWeight(1)
              }
              .width('100%')
              .height(50)
              .padding({ left: 12, right: 12 })
              .backgroundColor('#F5F5F5')
              .borderRadius(6)
            }
          },
          (item: string, index: number) => `item-${index}-${item}`
        )
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }
}
```

### 3.2 分页加载数据源

```typescript
/**
 * 分页数据源实现
 * 支持按页加载和滚动到底部自动加载更多
 */
class PagedDataSource extends BasicDataSource {
  private currentPage: number = 1;
  private pageSize: number = 20;
  private hasMore: boolean = true;

  // 获取当前页数据
  async loadPage(page: number): Promise<void> {
    // 模拟网络请求
    const newData: string[] = [];
    for (let i = 0; i < this.pageSize; i++) {
      newData.push(`Page ${page} - Item ${i + 1}`);
    }

    // 添加到数据源
    const startIndex = (page - 1) * this.pageSize;
    if (page === 1) {
      this.reloadData(newData);
    } else {
      newData.forEach((item, index) => {
        this.addData(startIndex + index, item);
      });
    }

    this.currentPage = page;
    this.hasMore = newData.length === this.pageSize;
  }

  // 加载下一页
  async loadNextPage(): Promise<void> {
    if (!this.hasMore) {
      return;
    }
    await this.loadPage(this.currentPage + 1);
  }

  // 刷新数据
  async refresh(): Promise<void> {
    this.currentPage = 0;
    this.hasMore = true;
    await this.loadPage(1);
  }

  // 是否有更多数据
  getHasMore(): boolean {
    return this.hasMore;
  }
}

@ComponentV2
struct PagedLazyForEachExample {
  private dataSource: PagedDataSource = new PagedDataSource();
  @Local isLoading: boolean = false;

  aboutToAppear(): void {
    this.loadInitialData();
  }

  async loadInitialData(): Promise<void> {
    this.isLoading = true;
    await this.dataSource.refresh();
    this.isLoading = false;
  }

  build() {
    Column() {
      List() {
        LazyForEach(
          this.dataSource,
          (item: string, index: number) => {
            ListItem() {
              Text(item)
                .width('100%')
                .height(60)
                .padding({ left: 16 })
                .backgroundColor('#F5F5F5')
            }
          },
          (item: string, index: number) => `paged-item-${index}`
        )

        // 加载更多指示器
        if (this.isLoading) {
          ListItem() {
            Row({ space: 8 }) {
              LoadingProgress()
                .width(20)
                .height(20)
              Text('加载中...')
                .fontSize(14)
                .fontColor('#999999')
            }
            .width('100%')
            .height(60)
            .justifyContent(FlexAlign.Center)
          }
        }
      }
      .width('100%')
      .layoutWeight(1)
      .onReachEnd(() => {
        if (!this.isLoading && this.dataSource.getHasMore()) {
          this.isLoading = true;
          this.dataSource.loadNextPage().then(() => {
            this.isLoading = false;
          });
        }
      })
    }
    .width('100%')
    .height('100%')
  }
}
```

## 四、高级用法

### 4.1 使用 @Reusable 优化性能

```typescript
/**
 * 可复用的列表项组件
 * 使用 @Reusable 装饰器减少组件创建开销
 */
@Reusable
@ComponentV2
struct ReusableListItem {
  @Param title: string = ''
  @Param subtitle: string = ''
  @Param index: number = 0

  build() {
    Column({ space: 4 }) {
      Text(this.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')

      Text(this.subtitle)
        .fontSize(14)
        .fontColor('#999999')
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: 2
    })
  }
}

@ComponentV2
struct ReusableLazyForEachExample {
  private dataSource: BasicDataSource = new BasicDataSource();

  aboutToAppear(): void {
    const data = Array.from({ length: 1000 }, (_, i) => ({
      id: `item-${i}`,
      title: `标题 ${i}`,
      subtitle: `副标题 ${i} - 这是详细描述`
    }));
    this.dataSource.reloadData(data);
  }

  build() {
    List({ space: 12 }) {
      LazyForEach(
        this.dataSource,
        (item: { id: string, title: string, subtitle: string }) => {
          ListItem() {
            // 使用可复用组件
            ReusableListItem({
              title: item.title,
              subtitle: item.subtitle,
              index: parseInt(item.id.split('-')[1])
            })
          }
        },
        (item: { id: string, title: string, subtitle: string }) => item.id
      )
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16 })
  }
}
```

### 4.2 带搜索过滤的数据源

```typescript
/**
 * 可过滤的数据源
 * 支持实时搜索和过滤
 */
class FilterableDataSource extends BasicDataSource {
  private originalData: any[] = [];
  private filteredData: any[] = [];

  // 设置原始数据并应用过滤
  setDataWithFilter(data: any[], filterFn?: (item: any) => boolean): void {
    this.originalData = data;
    this.applyFilter(filterFn);
  }

  // 应用过滤条件
  applyFilter(filterFn?: (item: any) => boolean): void {
    if (filterFn) {
      this.filteredData = this.originalData.filter(filterFn);
    } else {
      this.filteredData = [...this.originalData];
    }
    this.reloadData(this.filteredData);
  }

  // 搜索
  search(keyword: string): void {
    const lowerKeyword = keyword.toLowerCase();
    this.applyFilter((item: any) => {
      return item.name?.toLowerCase().includes(lowerKeyword) ||
             item.description?.toLowerCase().includes(lowerKeyword);
    });
  }
}

@ComponentV2
struct SearchableLazyForEachExample {
  private dataSource: FilterableDataSource = new FilterableDataSource();
  @Local searchText: string = '';

  aboutToAppear(): void {
    const data = Array.from({ length: 1000 }, (_, i) => ({
      id: `item-${i}`,
      name: `商品 ${i}`,
      description: `这是商品 ${i} 的描述信息`
    }));
    this.dataSource.setDataWithFilter(data);
  }

  build() {
    Column({ space: 16 }) {
      // 搜索框
      Search({ value: this.searchText, placeholder: '搜索商品' })
        .width('100%')
        .onChange((value: string) => {
          this.searchText = value;
          this.dataSource.search(value);
        })

      // 列表
      List({ space: 8 }) {
        LazyForEach(
          this.dataSource,
          (item: { id: string, name: string, description: string }) => {
            ListItem() {
              Column({ space: 4 }) {
                Text(item.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)

                Text(item.description)
                  .fontSize(14)
                  .fontColor('#999999')
              }
              .width('100%')
              .padding(12)
              .backgroundColor(Color.White)
              .borderRadius(6)
            }
          },
          (item: { id: string, name: string, description: string }) => item.id
        )
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }
}
```

### 4.3 分组数据源

```typescript
/**
 * 分组数据源实现
 * 支持可折叠的分组列表
 */
class GroupedDataSource extends BasicDataSource {
  private groups: Array<{ title: string, items: any[], expanded: boolean }> = [];

  // 设置分组数据
  setGroups(groups: Array<{ title: string, items: any[] }>): void {
    this.groups = groups.map(g => ({ ...g, expanded: true }));
    this.flattenData();
  }

  // 切换分组展开/折叠
  toggleGroup(groupIndex: number): void {
    this.groups[groupIndex].expanded = !this.groups[groupIndex].expanded;
    this.flattenData();
  }

  // 将分组数据展平为一维数组
  private flattenData(): void {
    const flatData: any[] = [];
    this.groups.forEach((group, groupIndex) => {
      // 添加分组标题
      flatData.push({
        type: 'header',
        title: group.title,
        groupIndex: groupIndex,
        expanded: group.expanded
      });

      // 添加分组项（仅展开时）
      if (group.expanded) {
        group.items.forEach(item => {
          flatData.push({
            type: 'item',
            data: item,
            groupIndex: groupIndex
          });
        });
      }
    });
    this.reloadData(flatData);
  }
}

@ComponentV2
struct GroupedLazyForEachExample {
  private dataSource: GroupedDataSource = new GroupedDataSource();

  aboutToAppear(): void {
    const groups = [
      {
        title: '水果',
        items: [
          { name: '苹果', price: '¥5.00' },
          { name: '香蕉', price: '¥3.00' },
          { name: '橙子', price: '¥6.00' }
        ]
      },
      {
        title: '蔬菜',
        items: [
          { name: '胡萝卜', price: '¥2.00' },
          { name: '西兰花', price: '¥4.00' }
        ]
      }
    ];
    this.dataSource.setGroups(groups);
  }

  build() {
    List() {
      LazyForEach(
        this.dataSource,
        (item: any) => {
          if (item.type === 'header') {
            // 分组标题
            ListItem() {
              Row({ space: 8 }) {
                Text(item.expanded ? '▼' : '▶')
                  .fontSize(14)
                  .fontColor('#666666')

                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .layoutWeight(1)
              }
              .width('100%')
              .height(50)
              .padding({ left: 16, right: 16 })
              .backgroundColor('#E3F2FD')
              .onClick(() => {
                this.dataSource.toggleGroup(item.groupIndex);
              })
            }
          } else {
            // 分组项
            ListItem() {
              Row({ space: 12 }) {
                Text(item.data.name)
                  .fontSize(16)
                  .layoutWeight(1)

                Text(item.data.price)
                  .fontSize(14)
                  .fontColor('#FF5252')
                  .fontWeight(FontWeight.Bold)
              }
              .width('100%')
              .height(50)
              .padding({ left: 32, right: 16 })
              .backgroundColor(Color.White)
            }
          }
        },
        (item: any, index: number) => {
          return item.type === 'header'
            ? `header-${item.groupIndex}`
            : `item-${item.groupIndex}-${index}`
        }
      )
    }
    .width('100%')
    .height('100%')
  }
}
```

## 五、性能优化

### 5.1 缓存策略

```typescript
@ComponentV2
struct CacheOptimizationExample {
  private dataSource: BasicDataSource = new BasicDataSource();

  build() {
    List({ space: 12 }) {
      LazyForEach(
        this.dataSource,
        (item: string) => {
          ListItem() {
            Text(item)
              .width('100%')
              .height(60)
              .padding(16)
              .backgroundColor('#F5F5F5')
          }
        },
        (item: string, index: number) => `cache-item-${index}`
      )
    }
    .cachedCount(5)  // 预加载上下各 5 个列表项
    .width('100%')
    .height('100%')
  }
}
```

### 5.2 避免复杂计算

```typescript
/**
 * 预计算数据源
 * 在数据加载时预计算所有需要的值
 */
class PreComputedDataSource extends BasicDataSource {
  setData(data: any[]): void {
    // 预计算所有需要的值
    const computed = data.map((item, index) => ({
      ...item,
      // 预计算显示文本
      displayText: `${item.name} - ${item.category}`,
      // 预计算样式
      backgroundColor: index % 2 === 0 ? '#F5F5F5' : '#FFFFFF',
      // 预计算图标
      icon: this.getIconForCategory(item.category)
    }));
    this.reloadData(computed);
  }

  private getIconForCategory(category: string): string {
    const icons: Record<string, string> = {
      'fruit': '🍎',
      'vegetable': '🥕',
      'meat': '🥩'
    };
    return icons[category] || '📦';
  }
}

@ComponentV2
struct PreComputedExample {
  private dataSource: PreComputedDataSource = new PreComputedDataSource();

  aboutToAppear(): void {
    const data = Array.from({ length: 1000 }, (_, i) => ({
      id: i,
      name: `Item ${i}`,
      category: i % 3 === 0 ? 'fruit' : (i % 3 === 1 ? 'vegetable' : 'meat')
    }));
    this.dataSource.setData(data);
  }

  build() {
    List({ space: 8 }) {
      LazyForEach(
        this.dataSource,
        (item: any) => {
          ListItem() {
            Row({ space: 12 }) {
              Text(item.icon)  // 使用预计算的图标
                .fontSize(24)

              Text(item.displayText)  // 使用预计算的文本
                .fontSize(16)
                .layoutWeight(1)
            }
            .width('100%')
            .height(60)
            .padding(16)
            .backgroundColor(item.backgroundColor)  // 使用预计算的背景色
          }
        },
        (item: any) => item.id
      )
    }
    .width('100%')
    .height('100%')
  }
}
```

## 六、实际应用场景

### 6.1 联系人列表

```typescript
interface Contact {
  id: string
  name: string
  phone: string
  avatar: string
  firstLetter: string
}

/**
 * 联系人数据源
 * 支持按首字母分组和索引定位
 */
class ContactDataSource extends BasicDataSource {
  private indexedGroups: Map<string, Contact[]> = new Map();

  setContacts(contacts: Contact[]): void {
    // 按首字母分组
    this.indexedGroups.clear();
    contacts.forEach(contact => {
      const letter = contact.firstLetter;
      if (!this.indexedGroups.has(letter)) {
        this.indexedGroups.set(letter, []);
      }
      this.indexedGroups.get(letter)!.push(contact);
    });

    // 展平数据
    const flatData: any[] = [];
    Array.from(this.indexedGroups.keys()).sort().forEach(letter => {
      flatData.push({
        type: 'header',
        letter: letter
      });
      this.indexedGroups.get(letter)!.forEach(contact => {
        flatData.push({
          type: 'contact',
          ...contact
        });
      });
    });

    this.reloadData(flatData);
  }

  // 跳转到指定首字母
  scrollToLetter(letter: string): void {
    // 实现跳转逻辑
  }
}

@ComponentV2
struct ContactListExample {
  private dataSource: ContactDataSource = new ContactDataSource();

  aboutToAppear(): void {
    const contacts: Contact[] = [
      { id: '1', name: 'Alice', phone: '13800138001', avatar: '', firstLetter: 'A' },
      { id: '2', name: 'Bob', phone: '13800138002', avatar: '', firstLetter: 'B' },
      // ... 更多联系人
    ];
    this.dataSource.setContacts(contacts);
  }

  build() {
    Stack({ alignContent: Alignment.End }) {
      List() {
        LazyForEach(
          this.dataSource,
          (item: any) => {
            if (item.type === 'header') {
              return ListItem() {
                Text(item.letter)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#007DFF')
                  .width('100%')
                  .height(40)
                  .padding({ left: 16 })
                  .backgroundColor('#F5F5F5')
              }
            } else {
              return ListItem() {
                Row({ space: 12 }) {
                  Circle()
                    .width(40)
                    .height(40)
                    .fill('#E0E0E0')

                  Column({ space: 4 }) {
                    Text(item.name)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)

                    Text(item.phone)
                      .fontSize(14)
                      .fontColor('#999999')
                  }
                  .alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)
                }
                .width('100%')
                .height(70)
                .padding({ left: 16, right: 16 })
                .backgroundColor(Color.White)
              }
            }
          },
          (item: any) => item.id || item.letter
        )
      }
      .width('100%')
      .height('100%')

      // 侧边字母索引
      Column({ space: 4 }) {
        ForEach(['A', 'B', 'C', 'D', 'E', 'F'], (letter: string) => {
          Text(letter)
            .fontSize(12)
            .fontColor('#007DFF')
            .width(20)
            .height(20)
            .textAlign(TextAlign.Center)
            .onClick(() => {
              this.dataSource.scrollToLetter(letter);
            })
        })
      }
      .padding({ right: 8, top: 20, bottom: 20 })
    }
    .width('100%')
    .height('100%')
  }
}
```

### 6.2 新闻列表

```typescript
interface NewsItem {
  id: string
  title: string
  summary: string
  publishTime: string
  imageUrl: string
  category: string
}

/**
 * 新闻数据源
 * 支持分类筛选和下拉刷新
 */
class NewsDataSource extends BasicDataSource {
  private allData: NewsItem[] = [];

  setNews(news: NewsItem[]): void {
    this.allData = news;
    this.reloadData(news);
  }

  filterByCategory(category: string): void {
    if (category === 'all') {
      this.reloadData(this.allData);
    } else {
      const filtered = this.allData.filter(item => item.category === category);
      this.reloadData(filtered);
    }
  }
}

@ComponentV2
struct NewsListExample {
  private dataSource: NewsDataSource = new NewsDataSource();
  @Local selectedCategory: string = 'all';
  @Local isRefreshing: boolean = false;

  aboutToAppear(): void {
    this.loadNews();
  }

  loadNews(): void {
    const news: NewsItem[] = Array.from({ length: 100 }, (_, i) => ({
      id: `news-${i}`,
      title: `新闻标题 ${i}`,
      summary: `这是新闻 ${i} 的摘要内容...`,
      publishTime: '2026-02-24',
      imageUrl: '',
      category: i % 3 === 0 ? 'tech' : (i % 3 === 1 ? 'sports' : 'entertainment')
    }));
    this.dataSource.setNews(news);
  }

  build() {
    Column({ space: 8 }) {
      // 分类标签
      Row({ space: 12 }) {
        this.CategoryTab('全部', 'all')
        this.CategoryTab('科技', 'tech')
        this.CategoryTab('体育', 'sports')
        this.CategoryTab('娱乐', 'entertainment')
      }
      .width('100%')
      .padding({ left: 16, right: 16 })

      // 新闻列表
      List({ space: 12 }) {
        LazyForEach(
          this.dataSource,
          (item: NewsItem) => {
            ListItem() {
              Column({ space: 8 }) {
                // 图片占位
                Row()
                  .width('100%')
                  .height(160)
                  .backgroundColor('#E0E0E0')
                  .borderRadius(8)
                  .justifyContent(FlexAlign.Center)

                // 标题
                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

                // 摘要
                Text(item.summary)
                  .fontSize(14)
                  .fontColor('#666666')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

                // 时间和分类
                Row({ space: 8 }) {
                  Text(item.publishTime)
                    .fontSize(12)
                    .fontColor('#999999')

                  Text(item.category)
                    .fontSize(12)
                    .fontColor('#007DFF')
                }
              }
              .width('100%')
              .padding(12)
              .backgroundColor(Color.White)
              .borderRadius(8)
            }
          },
          (item: NewsItem) => item.id
        )
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder CategoryTab(name: string, category: string) {
    Text(name)
      .fontSize(14)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.selectedCategory === category ? '#007DFF' : '#F5F5F5')
      .fontColor(this.selectedCategory === category ? Color.White : '#333333')
      .borderRadius(16)
      .onClick(() => {
        this.selectedCategory = category;
        this.dataSource.filterByCategory(category);
      })
  }
}
```

## 七、常见问题

### 7.1 数据更新不生效

**问题**: 调用数据源方法后界面不更新

**原因**: 没有调用通知方法

**解决**:
```typescript
// ❌ 错误
this.dataSource.originDataArray.push(newItem);

// ✅ 正确
this.dataSource.addData(index, newItem);
```

### 7.2 Key 重复

**问题**: 界面显示错乱

**原因**: keyGenerator 返回重复值

**解决**:
```typescript
// ❌ 错误
(item: any) => item.name  // name 可能重复

// ✅ 正确
(item: any) => item.id  // id 唯一
```

## 八、总结

### 核心要点

1. **实现 IDataSource**: 必须实现完整的接口和通知机制
2. **数据通知**: 数据变化后必须调用对应的 notify 方法
3. **唯一 Key**: keyGenerator 必须返回唯一且稳定的标识
4. **性能优化**: 使用 @Reusable、cachedCount 等技术
5. **适用场景**: 大数据量（≥ 100 项）必须使用 LazyForEach

### 与 ForEach 对比

| 特性 | ForEach | LazyForEach |
|------|---------|-------------|
| 数据量 | < 100 | ≥ 100 |
| 内存占用 | 高 | 低 |
| 滚动性能 | 一般 | 优秀 |
| 实现复杂度 | 简单 | 较复杂 |
| 适用组件 | 所有容器 | List/Grid/Swiper/WaterFlow |

## 相关文档

- [ForEach 渲染控制](../for_each/for_each.md)
- [List 组件](../list/list.md)
- [Grid 组件](../grid/grid.md)
- [WaterFlow 瀑布流](../water_flow/water_flow.md)

## 参考资源

- [解决LazyForEach懒加载数据UI渲染失败的问题](https://developer.huawei.com/consumer/cn/doc/architecture-guides/tools-v1_2-ts_265-0000002426940393)
- [鸿蒙 HarmonyOS 6 | ArkUI (04)：数据展示 List 列表容器 LazyForEach 懒加载机制](https://segmentfault.com/a/1190000047522475)
- [LazyForEach性能优化：解决长列表卡顿问题](https://www.cnblogs.com/xpzll/p/19109469)
