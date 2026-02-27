# ArkUI Component Guide

ArkUI is the declarative UI framework for HarmonyOS applications. This guide covers both V1 and V2 component patterns, with emphasis on ComponentV2 for HarmonyOS 6.0+.

## Built-in Components

### Basic Components

```typescript
// Text
Text('Hello World')
  .fontSize(24)
  .fontWeight(FontWeight.Bold)
  .fontColor('#333333')
  .maxLines(2)
  .textOverflow({ overflow: TextOverflow.Ellipsis })

// Image
Image($r('app.media.icon'))
  .width(100)
  .height(100)
  .objectFit(ImageFit.Cover)
  .borderRadius(8)

// Button
Button('Click Me')
  .type(ButtonType.Capsule)
  .width(200)
  .height(48)
  .fontSize(16)
  .onClick(() => {
    console.info('Button clicked');
  })

// TextInput
TextInput({ placeholder: 'Enter text' })
  .width('100%')
  .height(48)
  .type(InputType.Normal)
  .onChange((value: string) => {
    this.inputValue = value;
  })

// TextArea
TextArea({ placeholder: 'Enter multiple lines' })
  .width('100%')
  .height(100)
  .placeholderColor('#999999')

// Toggle
Toggle({ type: ToggleType.Switch, isOn: false })
  .onChange((isOn: boolean) => {
    this.isEnabled = isOn;
  })

// CheckBox / Radio
CheckBox({ name: 'check1', group: 'group1' })
  .select(true)
  .onChange((isChecked: boolean) => {
    console.info(`Checked: ${isChecked}`);
  })

// Progress
Progress({ value: 50, total: 100, type: ProgressType.Linear })
  .width('100%')
  .color('#007AFF')

// LoadingProgress
LoadingProgress()
  .width(50)
  .height(50)
  .color('#007AFF')
```

## Layout Containers

### Column - Vertical Layout

```typescript
Column() {
  Text('Header')
    .fontSize(24)
    .fontWeight(FontWeight.Bold)

  Text('Content goes here')
    .fontSize(16)
    .margin({ top: 12 })

  Button('Action')
    .margin({ top: 24 })
}
.width('100%')
.padding(16)
.alignItems(HorizontalAlign.Center)  // Horizontal alignment
.justifyContent(FlexAlign.SpaceBetween)  // Vertical spacing
.height('100%')
```

### Row - Horizontal Layout

```typescript
Row() {
  Image($r('app.media.avatar'))
    .width(48)
    .height(48)
    .borderRadius(24)

  Column() {
    Text('Username')
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
    Text('user@example.com')
      .fontSize(14)
      .fontColor('#8E8E93')
      .margin({ top: 4 })
  }
  .margin({ left: 12 })
  .alignItems(HorizontalAlign.Start)
  .layoutWeight(1)  // Take remaining space

  Image($r('app.media.arrow_right'))
    .width(16)
    .height(16)
}
.width('100%')
.padding(16)
.backgroundColor(Color.White)
.borderRadius(12)
.onClick(() => {
  // Handle click
})
```

### Flex - Flexible Layout

```typescript
Flex({
  direction: FlexDirection.Row,
  wrap: FlexWrap.Wrap,
  justifyContent: FlexAlign.SpaceAround,
  alignItems: ItemAlign.Center
}) {
  ForEach(this.items, (item: Item) => {
    Text(item.name)
      .padding(12)
      .backgroundColor('#F0F0F0')
      .borderRadius(8)
      .margin(4)
  })
}
.width('100%')
.padding(16)
```

### Stack - Overlapping Layout

```typescript
Stack({ alignContent: Alignment.TopEnd }) {
  // Background image
  Image($r('app.media.card_bg'))
    .width('100%')
    .height(200)
    .objectFit(ImageFit.Cover)

  // Content overlay
  Column() {
    Text('Card Title')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.White)
    Text('Subtitle')
      .fontSize(14)
      .fontColor('#E0E0E0')
      .margin({ top: 8 })
  }
  .width('100%')
  .padding(16)
  .alignItems(HorizontalAlign.Start)

  // Badge on top right
  Text('NEW')
    .fontSize(12)
    .fontColor(Color.White)
    .backgroundColor('#FF3B30')
    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
    .borderRadius(12)
    .margin(12)
}
.width('100%')
.height(200)
.borderRadius(12)
```

### Relative - Relative Layout

```typescript
RelativeContainer() {
  // Anchor element
  Rectangle()
    .width(100)
    .height(100)
    .fill('#007AFF')
    .id('anchor')

  // Position relative to anchor
  Rectangle()
    .width(50)
    .height(50)
    .fill('#FF3B30')
    .alignRules({
      top: { anchor: 'anchor', align: VerticalAlign.Bottom },
      left: { anchor: 'anchor', align: HorizontalAlign.End }
    })
}
.width('100%')
.height(200)
```

## Scroll Components

### Scroll - Single Direction Scroll

```typescript
@ComponentV2
struct ScrollDemo {
  @Local scroller: Scroller = new Scroller();
  @Local scrollOffset: number = 0;

  build() {
    Column() {
      Scroll(this.scroller) {
        Column() {
          ForEach(Array.from({ length: 50 }, (_, i) => i), (item: number) => {
            Text(`Item ${item}`)
              .width('100%')
              .height(80)
              .backgroundColor(item % 2 === 0 ? '#F5F5F5' : '#FFFFFF')
              .textAlign(TextAlign.Center)
          })
        }
        .width('100%')
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)
      .onScroll((xOffset: number, yOffset: number) => {
        this.scrollOffset = yOffset;
      })
      .onScrollEdge((side: Edge) => {
        if (side === Edge.Bottom) {
          console.info('Scrolled to bottom');
        }
      })

      // Scroll to top button
      if (this.scrollOffset > 500) {
        Button('Top')
          .position({ x: '80%', y: '85%' })
          .onClick(() => {
            this.scroller.scrollToIndex(0);
          })
      }
    }
    .width('100%')
    .height('100%')
  }
}
```

### Grid - Two-dimensional Layout

```typescript
@ComponentV2
struct GridDemo {
  @Local columnsNum: number = 3;

  @Computed
  get columnsTemplate(): string {
    return `1fr `.repeat(this.columnsNum).trim();
  }

  build() {
    Grid() {
      ForEach(this.products, (product: Product) => {
        GridItem() {
          ProductCard({ product: product })
        }
      }, (product: Product) => product.id)
    }
    .columnsTemplate(this.columnsTemplate)  // '1fr 1fr 1fr'
    .rowsTemplate('1fr 1fr')
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
    .height('100%')
    .padding(12)
  }
}

// Responsive Grid with breakpoints
@ComponentV2
struct ResponsiveGrid {
  @StorageProp('currentBreakpoint') breakpoint: string = 'sm';

  @Computed
  get columnsTemplate(): string {
    switch (this.breakpoint) {
      case 'sm':
        return '1fr 1fr';
      case 'md':
        return '1fr 1fr 1fr';
      case 'lg':
        return '1fr 1fr 1fr 1fr';
      default:
        return '1fr 1fr';
    }
  }

  build() {
    Grid() {
      ForEach(this.items, (item: Item) => {
        GridItem() {
          ItemCard({ item: item })
        }
      }, (item: Item) => item.id)
    }
    .columnsTemplate(this.columnsTemplate)
    .columnsGap(8)
    .rowsGap(8)
  }
}
```

### List - Vertical List

```typescript
@ComponentV2
struct ListDemo {
  @Local dataSource: BasicDataSource<Item> = new BasicDataSource();

  aboutToAppear(): void {
    this.loadData();
  }

  private loadData(): void {
    const items = Array.from({ length: 100 }, (_, i) => ({
      id: `${i}`,
      name: `Item ${i}`
    }));
    this.dataSource.setData(items);
  }

  build() {
    List() {
      LazyForEach(this.dataSource, (item: Item) => {
        ListItem() {
          Row() {
            Text(item.name)
              .fontSize(16)
            Blank()
            Image($r('app.media.arrow_right'))
              .width(16)
              .height(16)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(8)
          .onClick(() => {
            console.info(`Clicked ${item.name}`);
          })
        }
      }, (item: Item) => item.id)
    }
    .width('100%')
    .height('100%')
    .divider({
      strokeWidth: 1,
      color: '#E8E8E8',
      startMargin: 16,
      endMargin: 16
    })
    .cachedCount(10)  // Cache 10 items for smooth scrolling
    .edgeEffect(EdgeEffect.Spring)
  }
}
```

### WaterFlow - Waterfall Layout

```typescript
@ComponentV2
struct WaterFlowDemo {
  @Local scroller: Scroller = new Scroller();

  build() {
    WaterFlow({ scroller: this.scroller }) {
      ForEach(this.images, (image: ImageData) => {
        FlowItem() {
          Image(image.url)
            .width('100%')
            .objectFit(ImageFit.Cover)
            .borderRadius(8)
        }
        .width('48%')
        .height(image.height * 1.5)  // Dynamic height
        .margin({ bottom: 8 })
      }, (image: ImageData) => image.id)
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(8)
    .rowsGap(8)
    .width('100%')
    .height('100%')
    .padding(8)
    .backgroundColor('#F5F5F5')
  }
}
```

### Swiper - Carousel

```typescript
@ComponentV2
struct SwiperDemo {
  @Local currentIndex: number = 0;
  @Local swiperController: SwiperController = new SwiperController();

  build() {
    Column() {
      Swiper(this.swiperController) {
        ForEach(this.banners, (banner: Banner) => {
          Image(banner.imageUrl)
            .width('100%')
            .height(200)
            .objectFit(ImageFit.Cover)
            .borderRadius(12)
            .onClick(() => {
              console.info(`Banner ${banner.id} clicked`);
            })
        }, (banner: Banner) => banner.id)
      }
      .loop(true)
      .autoPlay(true)
      .interval(3000)
      .indicator(true)  // Show indicator dots
      .indicatorStyle({
        color: '#E0E0E0',
        selectedColor: '#007AFF'
      })
      .duration(300)  // Animation duration
      .curve(Curve.EaseInOut)
      .onChange((index: number) => {
        this.currentIndex = index;
      })

      // Custom indicator
      Row({ space: 8 }) {
        ForEach(this.banners, (banner: Banner, index: number) => {
          Circle()
            .width(8)
            .height(8)
            .fill(this.currentIndex === index ? '#007AFF' : '#E0E0E0')
        }, (banner: Banner, index: number) => `${banner.id}_${index}`)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: 16 })
    }
    .padding(16)
  }
}
```

## Tabs Component

### Basic Tabs

```typescript
@ComponentV2
struct TabsDemo {
  @Local currentIndex: number = 0;
  @Local tabController: TabsController = new TabsController();

  @Builder
  TabBuilder(title: string, targetIndex: number, icon: Resource) {
    Column() {
      Image(icon)
        .width(24)
        .height(24)
        .opacity(this.currentIndex === targetIndex ? 1 : 0.6)
      Text(title)
        .fontSize(12)
        .fontColor(this.currentIndex === targetIndex ? '#007AFF' : '#8E8E93')
        .fontWeight(this.currentIndex === targetIndex ? FontWeight.Medium : FontWeight.Normal)
        .margin({ top: 4 })
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.tabController.changeIndex(targetIndex);
    })
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabController }) {
      TabContent() {
        HomePage()
      }
      .tabBar(this.TabBuilder('Home', 0, $r('app.media.home')))

      TabContent() {
        DiscoverPage()
      }
      .tabBar(this.TabBuilder('Discover', 1, $r('app.media.discover')))

      TabContent() {
        ProfilePage()
      }
      .tabBar(this.TabBuilder('Profile', 2, $r('app.media.profile')))
    }
    .barMode(BarMode.Fixed)  // or BarMode.Scrollable
    .barHeight(56)
    .animationDuration(300)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
  }
}
```

### Custom Tab Bar

```typescript
@ComponentV2
struct CustomTabs {
  @Local currentIndex: number = 0;

  build() {
    Tabs({ index: this.currentIndex }) {
      TabContent() {
        HomePage()
      }

      TabContent() {
        DiscoverPage()
      }

      TabContent() {
        MessagesPage()
      }

      TabContent() {
        ProfilePage()
      }
    }
    .barPosition(BarPosition.End)
    .scrollable(false)
    .barHeight(0)  // Hide default tab bar
    .onChange((index: number) => {
      this.currentIndex = index;
    })
    .overlay(
      // Custom tab bar
      Row() {
        ForEach([0, 1, 2, 3], (index: number) => {
          Column() {
            Image(this.getIcon(index))
              .width(24)
              .height(24)
            Text(this.getTitle(index))
              .fontSize(12)
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .opacity(this.currentIndex === index ? 1 : 0.6)
          .onClick(() => {
            this.currentIndex = index;
          })
        }, (index: number) => `${index}`)
      }
      .width('100%')
      .height(56)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      , { align: Alignment.Bottom }
    )
  }

  private getIcon(index: number): Resource {
    const icons = [
      $r('app.media.home'),
      $r('app.media.discover'),
      $r('app.media.messages'),
      $r('app.media.profile')
    ];
    return icons[index];
  }

  private getTitle(index: number): string {
    const titles = ['Home', 'Discover', 'Messages', 'Profile'];
    return titles[index];
  }
}
```

## Navigation Component

### Basic Navigation

```typescript
@Entry
@ComponentV2
struct NavigationDemo {
  @Local navPathStack: NavPathStack = new NavPathStack();

  @Builder
  PageBuilder(name: string, params: Object) {
    if (name === 'home') {
      HomePage()
    } else if (name === 'detail') {
      DetailPage({ params: params as DetailParams })
    } else if (name === 'settings') {
      SettingsPage()
    }
  }

  build() {
    Navigation(this.navPathStack) {
      Column() {
        Button('Go to Detail')
          .onClick(() => {
            this.navPathStack.pushPathByName('detail', { id: '123' });
          })

        Button('Go to Settings')
          .margin({ top: 12 })
          .onClick(() => {
            this.navPathStack.pushPathByName('settings', null);
          })

        Button('Back')
          .margin({ top: 12 })
          .onClick(() => {
            this.navPathStack.pop();
          })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .navDestination(this.PageBuilder)
    .title('Navigation Demo')
    .mode(NavigationMode.Stack)  // or NavigationMode.Single
  }
}

@ComponentV2
struct DetailPage {
  @Consumer('navPathStack') navPathStack: NavPathStack;
  @Param params: DetailParams = new DetailParams();

  build() {
    NavDestination() {
      Column() {
        Text(`Detail: ${this.params.id}`)
          .fontSize(24)
        Button('Back')
          .margin({ top: 24 })
          .onClick(() => {
            this.navPathStack.pop();
          })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title('Detail Page')
    .hideBackButton(false)
  }
}
```

## Media Components

### Video Player

```typescript
@ComponentV2
struct VideoPlayer {
  @Local videoController: VideoController = new VideoController();
  @Local isPlaying: boolean = false;
  @Local currentTime: number = 0;
  @Local duration: number = 0;

  build() {
    Column() {
      Video({
        src: 'https://example.com/video.mp4',
        controller: this.videoController
      })
        .width('100%')
        .height(200)
        .autoPlay(false)
        .controls(true)
        .loop(false)
        .muted(false)
        .objectFit(ImageFit.Contain)
        .onStart(() => {
          this.isPlaying = true;
          console.info('Video playback started');
        })
        .onPause(() => {
          this.isPlaying = false;
          console.info('Video paused');
        })
        .onFinish(() => {
          this.isPlaying = false;
          console.info('Video finished');
        })
        .onError((error: number) => {
          console.error(`Video error: ${error}`);
        })
        .onPrepared((duration: number) => {
          this.duration = duration;
          console.info(`Video prepared, duration: ${duration}`);
        })
        .onSeeking((time: number) => {
          console.info(`Seeking to: ${time}`);
        })
        .onSeeked((time: number) => {
          this.currentTime = time;
          console.info(`Seeked to: ${time}`);
        })
        .onUpdate((time: number) => {
          this.currentTime = time;
        })

      // Custom controls
      Row() {
        Button(this.isPlaying ? 'Pause' : 'Play')
          .onClick(() => {
            if (this.isPlaying) {
              this.videoController.pause();
            } else {
              this.videoController.start();
            }
          })

        Slider({
          value: this.currentTime,
          min: 0,
          max: this.duration
        })
          .layoutWeight(1)
          .margin({ left: 16, right: 16 })
          .onChange((value: number) => {
            this.videoController.setCurrentTime(value);
          })

        Text(`${this.formatTime(this.currentTime)} / ${this.formatTime(this.duration)}`)
          .fontSize(12)
      }
      .width('100%')
      .padding(16)
    }
  }

  private formatTime(seconds: number): string {
    const mins = Math.floor(seconds / 60);
    const secs = Math.floor(seconds % 60);
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  }
}
```

### Image with Animation

```typescript
@ComponentV2
struct AnimatedImage {
  @Local scale: number = 1;
  @Local opacity: number = 1;

  build() {
    Image($r('app.media.photo'))
      .width(200)
      .height(200)
      .borderRadius(12)
      .scale({ x: this.scale, y: this.scale })
      .opacity(this.opacity)
      .animation({
        duration: 300,
        curve: Curve.EaseInOut
      })
      .onClick(() => {
        // Animate on click
        this.scale = this.scale === 1 ? 1.2 : 1;
        this.opacity = this.opacity === 1 ? 0.8 : 1;
      })
  }
}
```

## Form Components

### Form with Validation

```typescript
@ComponentV2
struct FormDemo {
  @Local formData: FormData = new FormData();
  @Local errors: FormErrors = new FormErrors();
  @Local isSubmitting: boolean = false;

  async handleSubmit(): Promise<void> {
    this.isSubmitting = true;

    // Validate
    if (!this.formData.username) {
      this.errors.username = 'Username is required';
      this.isSubmitting = false;
      return;
    }

    if (!this.formData.email || !this.isValidEmail(this.formData.email)) {
      this.errors.email = 'Invalid email';
      this.isSubmitting = false;
      return;
    }

    try {
      await this.submitForm(this.formData);
      // Success
    } catch (error) {
      console.error('Submit failed:', error);
    } finally {
      this.isSubmitting = false;
    }
  }

  private isValidEmail(email: string): boolean {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  }

  build() {
    Column() {
      TextInput({ placeholder: 'Username' })
        .width('100%')
        .onChange((value: string) => {
          this.formData.username = value;
          this.errors.username = '';
        })

      if (this.errors.username) {
        Text(this.errors.username)
          .fontSize(12)
          .fontColor(Color.Red)
          .width('100%')
      }

      TextInput({ placeholder: 'Email' })
        .width('100%')
        .type(InputType.Email)
        .margin({ top: 16 })
        .onChange((value: string) => {
          this.formData.email = value;
          this.errors.email = '';
        })

      if (this.errors.email) {
        Text(this.errors.email)
          .fontSize(12)
          .fontColor(Color.Red)
          .width('100%')
      }

      Button(this.isSubmitting ? 'Submitting...' : 'Submit')
        .width('100%')
        .margin({ top: 24 })
        .enabled(!this.isSubmitting)
        .onClick(() => {
          this.handleSubmit();
        })
    }
    .padding(24)
  }
}

@ObservedV2
class FormData {
  @Trace username: string = '';
  @Trace email: string = '';
  @Trace password: string = '';
}

@ObservedV2
class FormErrors {
  @Trace username: string = '';
  @Trace email: string = '';
  @Trace password: string = '';
}
```

## Custom Components (ComponentV2)

### Basic ComponentV2

```typescript
@ComponentV2
export struct ProductCard {
  // Read-only parameter
  @Param product: Product = new Product();

  // Two-way binding parameter
  @Param @Require quantity: number = 0;

  // Event callback
  @Event onAddToCart: (product: Product, quantity: number) => void = () => {};

  // Local state
  @Local isExpanded: boolean = false;

  // Computed property
  @Computed
  get totalPrice(): number {
    return this.product.price * this.quantity;
  }

  // Monitor changes
  @Monitor('quantity')
  onQuantityChange(prevQuantity: number) {
    console.info(`Quantity changed from ${prevQuantity} to ${this.quantity}`);
  }

  build() {
    Column() {
      Image(this.product.imageUrl)
        .width('100%')
        .aspectRatio(1)
        .objectFit(ImageFit.Cover)
        .borderRadius(8)

      Text(this.product.name)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 8 })

      Text(`¥${this.product.price.toFixed(2)}`)
        .fontSize(14)
        .fontColor('#FF6B00')
        .margin({ top: 4 })

      if (this.isExpanded) {
        Text(this.product.description)
          .fontSize(12)
          .fontColor('#8E8E93')
          .margin({ top: 8 })
      }

      Row() {
        Button('-')
          .onClick(() => {
            if (this.quantity > 0) {
              this.quantity--;
            }
          })

        Text(`${this.quantity}`)
          .margin({ left: 16, right: 16 })

        Button('+')
          .onClick(() => {
            this.quantity++;
          })

        Blank()

        Button(`¥${this.totalPrice.toFixed(2)}`)
          .onClick(() => {
            this.onAddToCart(this.product, this.quantity);
          })
      }
      .width('100%')
      .margin({ top: 12 })

      Button('Toggle Description')
        .margin({ top: 8 })
        .onClick(() => {
          this.isExpanded = !this.isExpanded;
        })
    }
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(12)
  }
}
```

## Performance Best Practices

### LazyForEach for Long Lists

```typescript
@ComponentV2
struct OptimizedList {
  @Local dataSource: LazyDataSource = new LazyDataSource();

  build() {
    List() {
      LazyForEach(this.dataSource, (item: Item, index: number) => {
        ListItem() {
          ItemRow({ item: item })
        }
      }, (item: Item) => item.id)  // Key function is important
    }
    .cachedCount(10)  // Cache items
    .width('100%')
    .height('100%')
  }
}

class LazyDataSource implements IDataSource {
  private items: Item[] = [];
  private listeners: DataChangeListener[] = [];

  totalCount(): number {
    return this.items.length;
  }

  getData(index: number): Item {
    return this.items[index];
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

  setData(items: Item[]): void {
    this.items = items;
    this.listeners.forEach(listener => {
      listener.onDataReload();
    });
  }
}
```

### GridRow and GridCol for Responsive Design

```typescript
@ComponentV2
struct ResponsiveLayout {
  @StorageProp('currentBreakpoint') breakpoint: string = 'sm';

  build() {
    GridRow({
      columns: { sm: 4, md: 8, lg: 12 },
      gutter: { x: 12, y: 12 }
    }) {
      GridCol({ span: { sm: 4, md: 4, lg: 3 } }) {
        // Sidebar - full width on phone, 1/3 on desktop
        Sidebar()
      }

      GridCol({ span: { sm: 4, md: 4, lg: 9 } }) {
        // Main content - full width on phone, 2/3 on desktop
        MainContent()
      }
    }
    .width('100%')
    .height('100%')
  }
}

---

## See Also

When documenting or learning about ArkUI components, if you understand the usage principles of a component, you should reference its detailed documentation in the `component/` directory.

### Layout Components
- [Column](component/column/column.md) — Vertical layout container with alignment and spacing options
- [Row](component/row/row.md) — Horizontal layout container with alignment and spacing options
- [Flex](component/flex/flex.md) — Flexible layout with wrap and alignment
- [Stack](component/stack/stack.md) — Overlapping layout for layered content
- [Grid](component/grid/grid.md) — Two-dimensional grid layout
- [List](component/list/list.md) — Vertical list with lazy loading support
- [Scroll](component/scroll/scroll.md) — Single-direction scroll container

### Navigation Components
- [Navigation](component/navigation/navigation.md) — Navigation container for page routing
- [NavDestination](component/navigation/nav_destination.md) — Page destination component
- [Tabs](component/tabs/tabs.md) — Tab container with custom tab bars
- [TabContent](component/tab_content/tab_content.md) — Tab content wrapper

### Form Components
- [TextInput](component/text_input/text_input.md) — Single-line text input
- [TextArea](component/text_area/text_area.md) — Multi-line text input
- [Button](component/button/button.md) — Button component with various types
- [Toggle](component/toggle/toggle.md) — Toggle switch and checkbox
- [Slider](component/slider/slider.md) — Slider for value selection
- [Checkbox](component/checkbox/checkbox.md) — Checkbox for selection
- [Radio](component/radio/radio.md) — Radio button for single selection
- [Rating](component/rating/rating.md) — Rating component

### Display Components
- [Text](component/text/text.md) — Text display with styling options
- [Image](component/image/image.md) — Image display with various fit modes
- [Span](component/span/span.md) — Inline text span within Text
- [TextSpan](component/span/text_span.md) — Text span with rich formatting
- [ImageSpan](component/span/image_span.md) — Inline image within text
- [RichText](component/rich_text/rich_text.md) — Rich text display with HTML-like tags
- [RichEditor](component/rich_editor/rich_editor.md) — Rich text editor

### Dialog Components
- [AlertDialog](component/dialogs/alert_dialog.md) — Alert dialog for confirmations
- [ActionSheet](component/dialogs/action_sheet.md) — Action sheet for bottom menus
- [CustomDialog](component/dialogs/custom_dialog_controller.md) — Custom dialog controller

### Progress Components
- [Progress](component/progress/progress.md) — Linear progress indicator
- [LoadingProgress](component/loading_progress/loading_progress.md) — Loading spinner
- [Gauge](component/gauge/gauge.md) — Gauge/dial chart component

### Animation Components
- [ImageAnimator](component/image_animator/image_animator.md) — Frame-based image animation

### Picker Components
- [DatePicker](component/date_picker/date_picker.md) — Date selection picker
- [TimePicker](component/time_picker/time_picker.md) — Time selection picker
- [TextPicker](component/text_picker/text_picker.md) — Text-based picker

### Shape Components
- [Circle](component/circle/circle.md) — Circle shape
- [Ellipse](component/ellipse/ellipse.md) — Ellipse shape
- [Rect](component/rect/rect.md) — Rectangle shape
- [Line](component/line/line.md) — Line shape
- [Polygon](component/polygon/polygon.md) — Polygon shape
- [Path](component/path/path.md) — Custom path shape
- [Polyline](component/polyline/polyline.md) — Polyline shape

### Media Components
- [Video](component/video/video.md) — Video player component

### Advanced Components
- [Swiper](component/swiper/swiper.md) — Carousel/slider component
- [Refresh](component/refresh/refresh.md) — Pull-to-refresh container
- [Stepper](component/stepper/stepper.md) — Step wizard container
- [Panel](component/panel/panel.md) — Sliding panel

### State Management
- [State Management](component/state_management/state_management.md) — ComponentV2 state management patterns

### Gesture
- [Gesture](component/gesture/gesture.md) — Gesture handling and recognition
```
