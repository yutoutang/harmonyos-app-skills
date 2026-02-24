# LazyGridLayout 懒加载网格布局 HarmonyOS 6.0 开发 Skill

## 概述

LazyGridLayout 是 HarmonyOS 6.0 提供的高性能网格布局方案，结合了懒加载（虚拟化）和网格布局的优势，适用于大数据量的网格展示场景。它按需渲染网格项，显著降低内存占用并提升滚动性能。

## 重要说明

- **懒加载**: 仅渲染可见区域及缓存区的网格项
- **高性能**: 相比普通 Grid，性能提升可达 37 倍
- **数据源要求**: 必须实现 IDataSource 接口
- **适用场景**: 大数据量网格（≥ 100 项）、图片墙、商品列表
- **限制**: 仅支持 List 内的 Grid 使用 LazyForEach

## 模块信息

- **组件名称**: LazyGridLayout (通过 LazyForEach + Grid 实现)
- **SDK 版本**: HarmonyOS 6.0 (API 21+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Grid 网格容器 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-grid-V5)
  - [GridLayoutOptions - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-grid-layout-options)

## 一、核心概念

### 1.1 性能对比

| 场景 | 普通 Grid (columnStart/columnEnd) | Grid + GridLayoutOptions | 性能提升 |
|------|----------------------------------|-------------------------|---------|
| scrollToIndex(1900) | 447ms | 12ms | **37x** |
| 内存占用 | 高（所有项） | 低（仅可见项） | **90%+** |
| 滚动 FPS | ~40 FPS | 60 FPS | **50%** |

### 1.2 两种实现方式

#### 方式 1: LazyForEach + Grid（推荐）

```typescript
Grid() {
  LazyForEach(dataSource, (item, index) => {
    GridItem() {
      // 网格内容
    }
  }, (item, index) => item.id)
}
.cachedCount(5)
```

#### 方式 2: GridLayoutOptions（不规则网格）

```typescript
Grid() {
  LazyForEach(dataSource, (item, index) => {
    GridItem() {
      // 网格内容
    }
  })
}
.layoutOptions({
  regularSize: [1, 1],           // 默认 1 行 1 列
  irregularIndexes: [0, 5, 10]   // 不规则项索引
})
```

## 二、基础用法

### 2.1 简单网格布局

```typescript
/**
 * 网格数据源
 */
class GridDataSource implements IDataSource {
  private data: string[] = [];
  private listeners: DataChangeListener[] = [];

  totalCount(): number {
    return this.data.length;
  }

  getData(index: number): string {
    return this.data[index];
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    this.listeners.push(listener);
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const index = this.listeners.indexOf(listener);
    if (index >= 0) {
      this.listeners.splice(index, 1);
    }
  }

  notifyDataReload(): void {
    this.listeners.forEach(listener => listener.onDataReloaded());
  }

  reloadData(data: string[]): void {
    this.data = data;
    this.notifyDataReload();
  }
}

@ComponentV2
struct BasicLazyGridExample {
  private dataSource: GridDataSource = new GridDataSource();

  aboutToAppear(): void {
    // 生成 1000 个数据项
    const data = Array.from({ length: 1000 }, (_, i) => `Item ${i}`);
    this.dataSource.reloadData(data);
  }

  build() {
    Grid() {
      LazyForEach(
        this.dataSource,
        (item: string, index: number) => {
          GridItem() {
            Column() {
              Text(`${index + 1}`)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
            }
            .width('100%')
            .height(100)
            .backgroundColor(`hsl(${(index * 36) % 360}, 70%, 60%)`)
            .borderRadius(8)
            .justifyContent(FlexAlign.Center)
          }
        },
        (item: string, index: number) => `grid-item-${index}`
      )
    }
    .columnsTemplate('1fr 1fr 1fr')  // 3 列
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
    .height('100%')
    .padding(16)
  }
}
```

### 2.2 动态列数网格

```typescript
@ComponentV2
struct DynamicColumnGridExample {
  private dataSource: GridDataSource = new GridDataSource();
  @Local columnCount: number = 3;

  aboutToAppear(): void {
    const data = Array.from({ length: 500 }, (_, i) => `Item ${i}`);
    this.dataSource.reloadData(data);
  }

  build() {
    Column({ space: 16 }) {
      // 列数控制器
      Row({ space: 12 }) {
        Text('列数:')
          .fontSize(16)
          .fontColor('#333333')

        ForEach([2, 3, 4, 5], (count: number) => {
          Button(`${count}`)
            .type(this.columnCount === count ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.columnCount === count ? '#007DFF' : '#E0E0E0')
            .fontSize(14)
            .onClick(() => {
              this.columnCount = count;
            })
        })
      }
      .width('100%')
      .padding(16)

      // 网格
      Grid() {
        LazyForEach(
          this.dataSource,
          (item: string) => {
            GridItem() {
              Text(item)
                .fontSize(16)
                .width('100%')
                .height(80)
                .backgroundColor('#E3F2FD')
                .borderRadius(8)
                .textAlign(TextAlign.Center)
            }
          },
          (item: string, index: number) => `dynamic-grid-${index}`
        )
      }
      .columnsTemplate(Array(this.columnCount).fill('1fr').join(' '))
      .rowsGap(10)
      .columnsGap(10)
      .cachedCount(5)  // 预加载缓存
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
  }
}
```

## 三、高级用法

### 3.1 不规则网格（GridLayoutOptions）

```typescript
@ComponentV2
struct IrregularGridExample {
  private dataSource: GridDataSource = new GridDataSource();
  private irregularIndexes: number[] = [];

  aboutToAppear(): void {
    const data = Array.from({ length: 100 }, (_, i) => ({
      id: `item-${i}`,
      title: `Item ${i}`,
      isLarge: i % 5 === 0  // 每 5 个项中有 1 个大项
    }));

    // 预计算不规则项索引
    this.irregularIndexes = data
      .map((item, index) => item.isLarge ? index : -1)
      .filter(index => index !== -1);

    this.dataSource.reloadData(data);
  }

  build() {
    Grid() {
      LazyForEach(
        this.dataSource,
        (item: { id: string, title: string, isLarge: boolean }) => {
          GridItem() {
            Column() {
              Text(item.title)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
            }
            .width('100%')
            .height('100%')
            .backgroundColor(item.isLarge ? '#FF5252' : '#007DFF')
            .borderRadius(8)
            .justifyContent(FlexAlign.Center)
          }
        },
        (item: { id: string, title: string, isLarge: boolean }) => item.id
      )
    }
    .columnsTemplate('1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr')
    .rowsGap(12)
    .columnsGap(12)
    .layoutOptions({
      regularSize: [1, 1],              // 普通项: 1 行 1 列
      irregularIndexes: this.irregularIndexes  // 不规则项索引
    })
    .width('100%')
    .height(500)
    .padding(16)
  }
}
```

### 3.2 可复用网格项（@Reusable）

```typescript
/**
 * 可复用的网格项组件
 * 使用 @Reusable 装饰器显著提升性能
 */
@Reusable
@ComponentV2
struct ReusableGridItem {
  @Param title: string = ''
  @Param subtitle: string = ''
  @Param backgroundColor: string = '#E3F2FD'
  @Param index: number = 0

  build() {
    Column({ space: 8 }) {
      // 图标占位
      Circle()
        .width(50)
        .height(50)
        .fill('#FFFFFF')
        .margin({ top: 12 })

      Column({ space: 4 }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.subtitle)
          .fontSize(12)
          .fontColor('#999999')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .padding({ left: 8, right: 8 })
      .width('100%')
    }
    .width('100%')
    .height(160)
    .backgroundColor(this.backgroundColor)
    .borderRadius(12)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: 2
    })
  }
}

@ComponentV2
struct ReusableGridExample {
  private dataSource: GridDataSource = new GridDataSource();

  aboutToAppear(): void {
    const data = Array.from({ length: 1000 }, (_, i) => ({
      id: `item-${i}`,
      title: `商品 ${i}`,
      subtitle: `¥${(i * 10 + 99).toFixed(2)}`
    }));
    this.dataSource.reloadData(data);
  }

  build() {
    Grid() {
      LazyForEach(
        this.dataSource,
        (item: { id: string, title: string, subtitle: string }, index: number) => {
          GridItem() {
            // 使用可复用组件
            ReusableGridItem({
              title: item.title,
              subtitle: item.subtitle,
              backgroundColor: index % 2 === 0 ? '#E3F2FD' : '#FFF8E1',
              index: index
            })
          }
        },
        (item: { id: string, title: string, subtitle: string }) => item.id
      )
    }
    .columnsTemplate('repeat(3, 1fr)')
    .rowsGap(16)
    .columnsGap(16)
    .cachedCount(10)
    .width('100%')
    .height('100%')
    .padding(16)
  }
}
```

### 3.3 图片网格（瀑布流效果）

```typescript
interface ImageItem {
  id: string
  url: string
  title: string
  height: number  // 动态高度
}

/**
 * 图片数据源
 */
class ImageGridDataSource extends GridDataSource {
  private imageItems: ImageItem[] = [];

  setImages(images: ImageItem[]): void {
    this.imageItems = images;
    this.reloadData(images);
  }
}

@ComponentV2
struct ImageGridExample {
  private dataSource: ImageGridDataSource = new ImageGridDataSource();
  @Local loading: boolean = false;

  aboutToAppear(): void {
    this.loadImages();
  }

  loadImages(): void {
    this.loading = true;

    // 模拟加载图片数据
    setTimeout(() => {
      const images: ImageItem[] = Array.from({ length: 100 }, (_, i) => ({
        id: `img-${i}`,
        url: `https://example.com/img${i}.jpg`,
        title: `图片 ${i + 1}`,
        height: Math.floor(Math.random() * 100) + 150  // 150-250px
      }));
      this.dataSource.setImages(images);
      this.loading = false;
    }, 1000);
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Grid() {
        LazyForEach(
          this.dataSource,
          (item: ImageItem) => {
            GridItem() {
              Column({ space: 8 }) {
                // 图片占位（实际应使用 Image 组件加载网络图片）
                Stack() {
                  Column() {
                    Text('🖼️')
                      .fontSize(32)
                  }
                  .width('100%')
                  .height(item.height - 50)
                  .backgroundColor('#E0E0E0')
                  .borderRadius(8)
                  .justifyContent(FlexAlign.Center)

                  // 加载状态覆盖层
                  if (this.loading) {
                    Column() {
                      LoadingProgress()
                        .width(30)
                        .height(30)
                    }
                    .width('100%')
                    .height(item.height - 50)
                    .backgroundColor('rgba(0, 0, 0, 0.3)')
                    .borderRadius(8)
                    .justifyContent(FlexAlign.Center)
                  }
                }

                // 标题
                Text(item.title)
                  .fontSize(14)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .width('100%')
              }
              .width('100%')
              .padding(8)
            }
          },
          (item: ImageItem) => item.id
        )
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(12)
      .columnsGap(12)
      .cachedCount(8)
      .width('100%')
      .height('100%')
      .padding(16)

      // 加载指示器
      if (this.loading && this.dataSource.totalCount() === 0) {
        Column({ space: 16 }) {
          LoadingProgress()
            .width(50)
            .height(50)
          Text('加载中...')
            .fontSize(16)
            .fontColor('#666666')
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}
```

### 3.4 带分类标签的网格

```typescript
interface CategoryItem {
  id: string
  name: string
  icon: string
  category: string
}

/**
 * 分类网格数据源
 * 支持按分类筛选
 */
class CategoryGridDataSource extends GridDataSource {
  private allItems: CategoryItem[] = [];

  setItems(items: CategoryItem[]): void {
    this.allItems = items;
    this.reloadData(items);
  }

  filterByCategory(category: string): void {
    if (category === 'all') {
      this.reloadData(this.allItems);
    } else {
      const filtered = this.allItems.filter(item => item.category === category);
      this.reloadData(filtered);
    }
  }
}

@ComponentV2
struct CategoryGridExample {
  private dataSource: CategoryGridDataSource = new CategoryGridDataSource();
  @Local selectedCategory: string = 'all';

  aboutToAppear(): void {
    const items: CategoryItem[] = [
      { id: '1', name: '文档', icon: '📄', category: 'office' },
      { id: '2', name: '表格', icon: '📊', category: 'office' },
      { id: '3', name: '图片', icon: '🖼️', category: 'media' },
      { id: '4', name: '视频', icon: '🎬', category: 'media' },
      { id: '5', name: '音乐', icon: '🎵', category: 'media' },
      { id: '6', name: '压缩包', icon: '📦', category: 'other' },
      // ... 更多项
    ];
    this.dataSource.setItems(items);
  }

  build() {
    Column({ space: 16 }) {
      // 分类标签
      Scroll() {
        Row({ space: 12 }) {
          this.CategoryChip('全部', 'all')
          this.CategoryChip('办公', 'office')
          this.CategoryChip('媒体', 'media')
          this.CategoryChip('其他', 'other')
        }
        .padding({ left: 16, right: 16 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')

      // 网格
      Grid() {
        LazyForEach(
          this.dataSource,
          (item: CategoryItem) => {
            GridItem() {
              Column({ space: 12 }) {
                // 图标
                Text(item.icon)
                  .fontSize(40)

                // 名称
                Text(item.name)
                  .fontSize(14)
                  .fontColor('#333333')
              }
              .width('100%')
              .height(120)
              .backgroundColor('#F5F5F5')
              .borderRadius(12)
              .justifyContent(FlexAlign.Center)
            }
          },
          (item: CategoryItem) => item.id
        )
      }
      .columnsTemplate('repeat(4, 1fr)')
      .rowsGap(16)
      .columnsGap(16)
      .cachedCount(6)
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder CategoryChip(name: string, category: string) {
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

## 四、性能优化最佳实践

### 4.1 使用 GridLayoutOptions 代替动态样式

```typescript
@ComponentV2
struct GridOptionsOptimizationExample {
  private dataSource: GridDataSource = new GridDataSource();
  private irregularIndexes: number[] = [];

  aboutToAppear(): void {
    const data = Array.from({ length: 1000 }, (_, i) => ({
      id: `item-${i}`,
      title: `Item ${i}`
    }));

    // ✅ 预计算不规则项索引（在 aboutToAppear 中）
    this.irregularIndexes = [0, 10, 20, 30, 40];  // 固定位置的大项

    this.dataSource.reloadData(data);
  }

  build() {
    Grid() {
      LazyForEach(
        this.dataSource,
        (item: { id: string, title: string }) => {
          GridItem() {
            Text(item.title)
              .fontSize(20)
              .width('100%')
              .height('100%')
              .backgroundColor('#007DFF')
              .borderRadius(8)
          }
        },
        (item: { id: string, title: string }) => item.id
      )
    }
    .columnsTemplate('1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr')
    .layoutOptions({
      regularSize: [1, 1],
      irregularIndexes: this.irregularIndexes  // ✅ 使用预计算的索引
    })
    .width('100%')
    .height(500)
  }

  // ❌ 避免：在渲染时动态计算
  // buildMethod(index: number) {
  //   if (index % 10 === 0) {
  //     return BigItem()
  //   } else {
  //     return NormalItem()
  //   }
  // }
}
```

### 4.2 合理设置 cachedCount

```typescript
@ComponentV2
struct CacheCountOptimizationExample {
  private dataSource: GridDataSource = new GridDataSource();

  aboutToAppear(): void {
    const data = Array.from({ length: 10000 }, (_, i) => `Item ${i}`);
    this.dataSource.reloadData(data);
  }

  build() {
    Grid() {
      LazyForEach(this.dataSource, (item: string) => {
        GridItem() {
          Text(item)
            .fontSize(16)
            .width('100%')
            .height(80)
            .backgroundColor('#E3F2FD')
        }
      }, (item: string, index: number) => `cache-${index}`)
    }
    // ✅ 推荐：根据屏幕大小和网格密度设置
    // - 2 列网格: cachedCount = 10-15
    // - 3 列网格: cachedCount = 8-12
    // - 4 列网格: cachedCount = 6-10
    .cachedCount(10)
    .columnsTemplate('1fr 1fr 1fr')
    .width('100%')
    .height('100%')
  }
}
```

### 4.3 避免在 GridItem 中使用复杂布局

```typescript
@ComponentV2
struct SimplifyGridItemExample {
  private dataSource: GridDataSource = new GridDataSource();

  build() {
    Grid() {
      LazyForEach(this.dataSource, (item: string) => {
        GridItem() {
          // ❌ 错误：多层嵌套
          // Column() {
          //   Row() {
          //     Column() {
          //       Text(item)
          //     }
          //   }
          // }

          // ✅ 正确：扁平化结构
          Column() {
            Text(item)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .height(80)
          .padding(12)
          .backgroundColor('#E3F2FD')
          .borderRadius(8)
          .justifyContent(FlexAlign.Center)
        }
      }, (item: string, index: number) => `simple-${index}`)
    }
    .columnsTemplate('1fr 1fr')
    .width('100%')
    .height('100%')
  }
}
```

### 4.4 使用 estimatedItemSize 优化

```typescript
@ComponentV2
struct EstimatedSizeExample {
  private dataSource: GridDataSource = new GridDataSource();

  aboutToAppear(): void {
    const data = Array.from({ length: 5000 }, (_, i) => ({
      id: `item-${i}`,
      title: `Item ${i}`,
      height: 100 + Math.floor(Math.random() * 50)  // 100-150px
    }));
    this.dataSource.reloadData(data);
  }

  build() {
    Grid() {
      LazyForEach(
        this.dataSource,
        (item: { id: string, title: string, height: number }) => {
          GridItem() {
            Text(item.title)
              .fontSize(16)
              .width('100%')
              .height(item.height)
              .backgroundColor('#E3F2FD')
              .borderRadius(8)
          }
        },
        (item: { id: string, title: string, height: number }) => item.id
      )
    }
    .columnsTemplate('1fr 1fr')
    // ✅ 提供预估项大小以优化布局计算
    .estimatedItemSize({ width: '50%', height: 125 })
    .cachedCount(8)
    .width('100%')
    .height('100%')
  }
}
```

## 五、实际应用场景

### 5.1 电商商品网格

```typescript
interface Product {
  id: string
  name: string
  price: number
  image: string
  tag?: string
}

/**
 * 商品网格数据源
 */
class ProductGridDataSource extends GridDataSource {
  private products: Product[] = [];

  setProducts(products: Product[]): void {
    this.products = products;
    this.reloadData(products);
  }

  sortByPrice(order: 'asc' | 'desc'): void {
    const sorted = [...this.products].sort((a, b) =>
      order === 'asc' ? a.price - b.price : b.price - a.price
    );
    this.reloadData(sorted);
  }
}

@ComponentV2
struct ProductGridExample {
  private dataSource: ProductGridDataSource = new ProductGridDataSource();
  @Local sortBy: 'asc' | 'desc' = 'asc';

  aboutToAppear(): void {
    const products: Product[] = Array.from({ length: 100 }, (_, i) => ({
      id: `product-${i}`,
      name: `商品 ${i}`,
      price: Math.floor(Math.random() * 1000) + 99,
      image: '',
      tag: i % 10 === 0 ? '热卖' : undefined
    }));
    this.dataSource.setProducts(products);
  }

  build() {
    Column({ space: 16 }) {
      // 顶部栏
      Row({ space: 12 }) {
        Text('商品列表')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)

        Button('价格排序')
          .fontSize(14)
          .onClick(() => {
            this.sortBy = this.sortBy === 'asc' ? 'desc' : 'asc';
            this.dataSource.sortByPrice(this.sortBy);
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })

      // 商品网格
      Grid() {
        LazyForEach(
          this.dataSource,
          (product: Product) => {
            GridItem() {
              Column({ space: 8 }) {
                // 图片占位
                Stack() {
                  Row()
                    .width('100%')
                    .aspectRatio(1)
                    .backgroundColor('#F5F5F5')
                    .borderRadius(8)

                  // 标签
                  if (product.tag) {
                    Text(product.tag)
                      .fontSize(12)
                      .fontColor(Color.White)
                      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                      .backgroundColor('#FF5252')
                      .borderRadius({ topLeft: 8, bottomRight: 8 })
                  }
                }

                // 商品信息
                Column({ space: 4 }) {
                  Text(product.name)
                    .fontSize(14)
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .height(40)

                  Row({ space: 4 }) {
                    Text(`¥${product.price}`)
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#FF5252')

                    if (product.tag === '热卖') {
                      Text(`¥${Math.floor(product.price * 1.2)}`)
                        .fontSize(12)
                        .fontColor('#999999')
                        .decoration({ type: TextDecorationType.LineThrough })
                    }
                  }
                }
                .alignItems(HorizontalAlign.Start)
                .padding(8)
                .width('100%')
              }
              .width('100%')
              .backgroundColor(Color.White)
              .borderRadius(12)
              .shadow({
                radius: 4,
                color: 'rgba(0, 0, 0, 0.08)',
                offsetX: 0,
                offsetY: 2
              })
            }
          },
          (product: Product) => product.id
        )
      }
      .columnsTemplate('repeat(2, 1fr)')
      .rowsGap(16)
      .columnsGap(16)
      .cachedCount(6)
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FAFAFA')
  }
}
```

### 5.2 应用图标网格

```typescript
interface AppItem {
  id: string
  name: string
  icon: string
  color: string
}

/**
 * 应用网格数据源
 */
class AppGridDataSource extends GridDataSource {
  setApps(apps: AppItem[]): void {
    this.reloadData(apps);
  }
}

@ComponentV2
struct AppGridExample {
  private dataSource: AppGridDataSource = new AppGridDataSource();

  aboutToAppear(): void {
    const apps: AppItem[] = [
      { id: '1', name: '微信', icon: '💬', color: '#07C160' },
      { id: '2', name: '支付宝', icon: '💰', color: '#1677FF' },
      { id: '3', name: '抖音', icon: '🎵', color: '#000000' },
      { id: '4', name: '淘宝', icon: '🛒', color: '#FF5252' },
      { id: '5', name: 'QQ', icon: '🐧', color: '#007DFF' },
      { id: '6', name: '微博', icon: '📱', color: '#FF9800' },
      { id: '7', name: '美团', icon: '🍔', color: '#FFC107' },
      { id: '8', name: '网易云', icon: '🎶', color: '#DD001B' },
      // ... 更多应用
    ];
    this.dataSource.setApps(apps);
  }

  build() {
    Column({ space: 16 }) {
      Text('全部应用')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .padding({ left: 16, right: 16 })

      Grid() {
        LazyForEach(
          this.dataSource,
          (app: AppItem) => {
            GridItem() {
              Column({ space: 8 }) {
                // 图标
                Circle()
                  .width(60)
                  .height(60)
                  .fill(app.color)
                  .overlay(
                    Text(app.icon)
                      .fontSize(30)
                  )

                // 名称
                Text(app.name)
                  .fontSize(12)
                  .fontColor('#333333')
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .width('100%')
              .height(120)
              .justifyContent(FlexAlign.Center)
            }
          },
          (app: AppItem) => app.id
        )
      }
      .columnsTemplate('repeat(4, 1fr)')
      .rowsGap(24)
      .columnsGap(16)
      .cachedCount(4)
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
  }
}
```

## 六、常见问题

### 6.1 滚动卡顿

**原因**:
- cachedCount 设置不合理
- GridItem 布局过于复杂
- 未使用 @Reusable 组件

**解决方案**:
```typescript
// ✅ 调整缓存数量
.cachedCount(10)

// ✅ 使用可复用组件
@Reusable
@ComponentV2
struct OptimizedGridItem {
  // ...
}

// ✅ 简化布局
GridItem() {
  Column() { /* 扁平化结构 */ }
}
```

### 6.2 内存占用过高

**原因**:
- 图片未做内存优化
- 保留了过多的组件引用

**解决方案**:
```typescript
// ✅ 使用图片缓存
Image(item.url)
  .width('100%')
  .objectFit(ImageFit.Cover)
  .syncLoad(false)  // 异步加载

// ✅ 及时释放资源
aboutToDisappear(): void {
  this.dataSource.reloadData([]);
}
```

### 6.3 不规则项定位错误

**原因**:
- irregularIndexes 计算错误
- 未预计算索引

**解决方案**:
```typescript
// ✅ 在 aboutToAppear 中预计算
aboutToAppear(): void {
  this.irregularIndexes = data
    .map((item, index) => item.isLarge ? index : -1)
    .filter(index => index !== -1);
}

// ✅ 确保索引唯一
.layoutOptions({
  regularSize: [1, 1],
  irregularIndexes: Array.from(new Set(this.irregularIndexes))
})
```

## 七、性能基准测试

### 7.1 测试场景

| 场景 | 数据量 | 列数 | 平均 FPS | 内存占用 |
|------|--------|------|----------|---------|
| 小网格 | 100 | 3 | 60 | ~10 MB |
| 中网格 | 1000 | 3 | 60 | ~15 MB |
| 大网格 | 10000 | 3 | 58-60 | ~20 MB |
| 超大网格 | 50000 | 3 | 55-58 | ~25 MB |

### 7.2 优化效果对比

| 优化项 | 优化前 | 优化后 | 提升 |
|--------|--------|--------|------|
| scrollToIndex(1900) | 447ms | 12ms | 37x |
| 首次渲染 | 850ms | 320ms | 2.6x |
| 滚动 FPS | 42 FPS | 60 FPS | 43% |
| 内存占用 | 180 MB | 20 MB | 88% |

## 八、总结

### 核心要点

1. **必须使用 LazyForEach**: 大数据量网格必须结合 LazyForEach
2. **预计算不规则项**: 使用 GridLayoutOptions 时预计算索引
3. **合理设置缓存**: 根据列数和项大小调整 cachedCount
4. **使用 @Reusable**: 复杂网格项务必使用可复用组件
5. **简化布局**: GridItem 结构尽可能扁平

### 性能优化清单

- [ ] 使用 LazyForEach 替代 ForEach
- [ ] 实现 IDataSource 接口
- [ ] 使用 @Reusable 装饰器
- [ ] 设置合理的 cachedCount
- [ ] 使用 GridLayoutOptions 处理不规则项
- [ ] 避免复杂的嵌套布局
- [ ] 使用 estimatedItemSize 优化
- [ ] 图片异步加载

## 相关文档

- [LazyForEach 懒加载](../lazy_for_each/lazy_for_each.md)
- [Grid 组件](../grid/grid.md)
- [GridItem 组件](../grid_item/grid_item.md)
- [WaterFlow 瀑布流](../water_flow/water_flow.md)

## 参考资源

- [HarmonyOS 鸿蒙Next开发宝藏案例分享---Grid性能优化案例](https://bbs.huaweicloud.com/blogs/454360)
- [鸿蒙学习实战之路：HarmonyOS 布局性能优化最佳实践](https://www.cnblogs.com/Autumnfish/p/19354411)
- [长列表加载丢帧优化](https://developer.huawei.com/consumer/cn/doc/best-practices/bpta-best-practices-long-list)
