# SecurityComponent 安全组件 HarmonyOS 6.0 开发 Skill

## 概述

SecurityComponent 是 HarmonyOS 6.0 (API 12+) 中提供安全相关功能的组件集合，包括生物识别认证（指纹、人脸）、证书管理、加密存储等安全能力。这些组件帮助开发者构建安全可靠的应用，保护用户数据和隐私。

## 重要说明

- **API 版本要求**: API 12+ (HarmonyOS 6.0)
- **模块迁移**: 旧的 `@ohos.biometric` 模块已废弃，必须使用新的 `@ohos.security.biometric` 模块
- **权限要求**: 需要申请相关安全权限
- **HUKS 集成**: 硬件统一密钥存储（HUKS）提供底层加密支持
- **Star Shield**: HarmonyOS 6.0 引入的星盾安全架构

## 模块信息

- **功能名称**: 安全组件 (Security Components)
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**:
  - SystemCapability.Security.BiometricAuth
  - SystemCapability.Security.Huks
  - SystemCapability.Security.CertManager
- **更新日期**: 2026-02-24
- **官方文档**:
  - [证书管理开发指导 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/certmanager-guidelines-V5)
  - [服务器端开发 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/device-attestation-servers-V5)

## 一、生物识别认证

### 1.1 导入模块

```typescript
// API 12+ 使用新的安全模块
import { biometricAuth } from '@kit.BiometricAuthKit'
import { BusinessError } from '@kit.BasicServicesKit'
```

### 1.2 权限配置

在 `module.json5` 中声明所需权限：

```json5
{
  "module": {
    "requestPermissions": [
      {
        "name": "ohos.permission.USE_BIOMETRIC",
        "reason": "$string:biometric_permission_reason",
        "usedScene": {
          "abilities": ["EntryAbility"],
          "when": "inuse"
        }
      },
      {
        "name": "ohos.permission.MANAGE_SECURE_SETTINGS",
        "reason": "$string:secure_settings_permission_reason",
        "usedScene": {
          "abilities": ["EntryAbility"],
          "when": "inuse"
        }
      }
    ]
  }
}
```

### 1.3 指纹认证

```typescript
@ComponentV2
struct FingerprintAuthExample {
  @Local authResult: string = '等待认证'

  async authenticateFingerprint() {
    try {
      // 获取认证器实例
      const authInstance = biometricAuth.getAuthInstance(
        biometricAuth.AuthType.FINGERPRINT,
        biometricAuth.AuthTrustLevel.ATL1
      )

      // 执行认证
      authInstance.auth('验证指纹以继续', async (result: biometricAuth.AuthResult) => {
        if (result.result === biometricAuth.AuthResultType.SUCCESS) {
          this.authResult = '认证成功'
          console.info('Fingerprint authentication succeeded')
        } else {
          this.authResult = `认证失败: ${result.result}`
          console.error('Fingerprint authentication failed')
        }
      })

    } catch (error) {
      const err = error as BusinessError
      this.authResult = `认证错误: ${err.message}`
      console.error(`Authentication error: code=${err.code}, message=${err.message}`)
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('指纹认证示例')
        .fontSize(24)

      Text(this.authResult)
        .fontSize(16)

      Button('验证指纹')
        .onClick(() => {
          this.authenticateFingerprint()
        })
    }
    .padding(20)
  }
}
```

### 1.4 人脸识别

```typescript
@ComponentV2
struct FaceAuthExample {
  @Local authResult: string = '等待认证'

  async authenticateFace() {
    try {
      // 获取人脸认证器
      const authInstance = biometricAuth.getAuthInstance(
        biometricAuth.AuthType.FACE,
        biometricAuth.AuthTrustLevel.ATL2
      )

      // 执行认证
      authInstance.auth('验证人脸以继续', async (result: biometricAuth.AuthResult) => {
        if (result.result === biometricAuth.AuthResultType.SUCCESS) {
          this.authResult = '认证成功'
          console.info('Face authentication succeeded')
        } else {
          this.authResult = `认证失败: ${result.result}`
          console.error('Face authentication failed')
        }
      })

    } catch (error) {
      const err = error as BusinessError
      this.authResult = `认证错误: ${err.message}`
      console.error(`Authentication error: code=${err.code}, message=${err.message}`)
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('人脸识别示例')
        .fontSize(24)

      Text(this.authResult)
        .fontSize(16)

      Button('验证人脸')
        .onClick(() => {
          this.authenticateFace()
        })
    }
    .padding(20)
  }
}
```

### 1.5 认证类型枚举

```typescript
enum AuthType {
  FINGERPRINT = 1,    // 指纹认证
  FACE = 2           // 人脸认证
}

enum AuthTrustLevel {
  ATL1 = 10000,      // 安全级别 1（最低）
  ATL2 = 20000,      // 安全级别 2
  ATL3 = 30000,      // 安全级别 3
  ATL4 = 40000       // 安全级别 4（最高）
}

enum AuthResultType {
  SUCCESS = 0,               // 认证成功
  FAILURE = 1,               // 认证失败
  LOCKED = 2,                // 认证已锁定
  NOT_ENROLLED = 3,          // 未注册生物特征
  CANCELED = 4,              // 用户取消
  TIMEOUT = 5,               // 超时
  TYPE_NOT_SUPPORT = 6,      // 不支持的类型
  BUSY = 7,                  // 认证服务忙
  INVALID_PARAMETERS = 8,    // 无效参数
  LACK_SECURENESS = 9        // 安全级别不足
}
```

### 1.6 检查认证可用性

```typescript
@ComponentV2
struct CheckBiometricAvailability {
  @Local fingerprintAvailable: boolean = false
  @Local faceAvailable: boolean = false

  aboutToAppear() {
    this.checkAvailability()
  }

  async checkAvailability() {
    try {
      // 检查指纹是否可用
      const fingerprintAuth = biometricAuth.getAuthInstance(
        biometricAuth.AuthType.FINGERPRINT,
        biometricAuth.AuthTrustLevel.ATL1
      )
      this.fingerprintAvailable = await fingerprintAuth.isAvailable()

      // 检查人脸是否可用
      const faceAuth = biometricAuth.getAuthInstance(
        biometricAuth.AuthType.FACE,
        biometricAuth.AuthTrustLevel.ATL1
      )
      this.faceAvailable = await faceAuth.isAvailable()

    } catch (error) {
      console.error('Check availability error:', error)
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('生物识别可用性检查')
        .fontSize(24)

      Row({ space: 8 }) {
        Text('指纹识别:')
        Text(this.fingerprintAvailable ? '可用' : '不可用')
          .fontColor(this.fingerprintAvailable ? Color.Green : Color.Red)
      }

      Row({ space: 8 }) {
        Text('人脸识别:')
        Text(this.faceAvailable ? '可用' : '不可用')
          .fontColor(this.faceAvailable ? Color.Green : Color.Red)
      }

      Button('重新检查')
        .onClick(() => {
          this.checkAvailability()
        })
    }
    .padding(20)
  }
}
```

## 二、HUKS 加密存储

### 2.1 导入模块

```typescript
import { huks } from '@kit.UniApplicationKit'
```

### 2.2 生成密钥

```typescript
@ComponentV2
struct HuksKeyGeneration {
  @Local keyAlias: string = 'my_app_key'
  @Local keyResult: string = '未生成密钥'

  async generateKey() {
    const keyProperties: huks.HuksKeyProperties = {
      keyAlias: this.keyAlias,
      keySize: huks.HuksKeySize.HUKS_AES_KEY_SIZE_256,
      keyPurpose: huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_ENCRYPT |
                   huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_DECRYPT,
      keyAlg: huks.HuksKeyAlg.HUKS_ALG_AES,
      keyGenerateType: huks.HuksKeyGenerateType.HUKS_KEY_GENERATE_TYPE_DEFAULT,
      keyAuthPurpose: huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_ENCRYPT |
                      huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_DECRYPT,
      padding: huks.HuksKeyPadding.HUKS_PADDING_PKCS7,
      blockMode: huks.HuksKeyBlockMode.HUKS_MODE_CBC,
      divisor: null,
      keyStorageLevel: huks.HuksKeyStorageLevel.HUKS_STORAGE_L0
    }

    try {
      await huks.generateKey(keyProperties)
      this.keyResult = '密钥生成成功'
      console.info('Key generated successfully')
    } catch (error) {
      const err = error as BusinessError
      this.keyResult = `密钥生成失败: ${err.message}`
      console.error(`Key generation error: code=${err.code}, message=${err.message}`)
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('HUKS 密钥生成')
        .fontSize(24)

      Text(this.keyResult)
        .fontSize(16)

      Button('生成 AES 密钥')
        .onClick(() => {
          this.generateKey()
        })
    }
    .padding(20)
  }
}
```

### 2.3 加密数据

```typescript
@ComponentV2
struct HuksEncryption {
  @Local keyAlias: string = 'my_app_key'
  @Local plaintext: string = 'Hello, HarmonyOS!'
  @Local ciphertext: string = ''
  @Local encryptResult: string = ''

  async encryptData() {
    const encryptOptions: huks.HuksOptions = {
      properties: new Array<huks.HuksParam>(),
      inData: new Uint8Array(Buffer.from(this.plaintext).buffer)
    }

    try {
      const result = await huks.encrypt(this.keyAlias, encryptOptions)
      this.ciphertext = Buffer.from(result.outData).toString('base64')
      this.encryptResult = '加密成功'
      console.info('Data encrypted successfully')
    } catch (error) {
      const err = error as BusinessError
      this.encryptResult = `加密失败: ${err.message}`
      console.error(`Encryption error: code=${err.code}, message=${err.message}`)
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('HUKS 数据加密')
        .fontSize(24)

      TextInput({ placeholder: '输入明文', text: $$this.plaintext })
        .width('100%')

      if (this.ciphertext) {
        Text('密文:')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)

        Text(this.ciphertext)
          .fontSize(14)
          .fontFamily('monospace')
      }

      Text(this.encryptResult)
        .fontColor(this.encryptResult.includes('成功') ? Color.Green : Color.Red)

      Button('加密')
        .onClick(() => {
          this.encryptData()
        })
    }
    .padding(20)
  }
}
```

### 2.4 解密数据

```typescript
@ComponentV2
struct HuksDecryption {
  @Local keyAlias: string = 'my_app_key'
  @Local ciphertext: string = ''
  @Local decryptedText: string = ''
  @Local decryptResult: string = ''

  async decryptData() {
    const decryptOptions: huks.HuksOptions = {
      properties: new Array<huks.HuksParam>(),
      inData: new Uint8Array(Buffer.from(this.ciphertext, 'base64').buffer)
    }

    try {
      const result = await huks.decrypt(this.keyAlias, decryptOptions)
      this.decryptedText = Buffer.from(result.outData).toString('utf-8')
      this.decryptResult = '解密成功'
      console.info('Data decrypted successfully')
    } catch (error) {
      const err = error as BusinessError
      this.decryptResult = `解密失败: ${err.message}`
      console.error(`Decryption error: code=${err.code}, message=${err.message}`)
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('HUKS 数据解密')
        .fontSize(24)

      TextInput({ placeholder: '输入密文（Base64）', text: $$this.ciphertext })
        .width('100%')

      if (this.decryptedText) {
        Text('解密结果:')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)

        Text(this.decryptedText)
          .fontSize(16)
      }

      Text(this.decryptResult)
        .fontColor(this.decryptResult.includes('成功') ? Color.Green : Color.Red)

      Button('解密')
        .onClick(() => {
          this.decryptData()
        })
    }
    .padding(20)
  }
}
```

### 2.5 带生物识别的加密密钥

```typescript
@ComponentV2
struct BiometricKeyExample {
  @Local keyAlias: string = 'biometric_key'
  @Local operationResult: string = ''

  async generateBiometricKey() {
    const keyProperties: huks.HuksKeyProperties = {
      keyAlias: this.keyAlias,
      keySize: huks.HuksKeySize.HUKS_AES_KEY_SIZE_256,
      keyPurpose: huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_ENCRYPT |
                   huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_DECRYPT,
      keyAlg: huks.HuksKeyAlg.HUKS_ALG_AES,
      keyGenerateType: huks.HuksKeyGenerateType.HUKS_KEY_GENERATE_TYPE_DEFAULT,
      // 启用生物识别认证
      userAuthType: huks.HuksUserAuthType.HUKS_USER_AUTH_TYPE_FINGERPRINT,
      userAuthTimeout: 60,  // 认证超时时间（秒）
      authTimeout: 300      // 操作超时时间（秒）
    }

    try {
      await huks.generateKey(keyProperties)
      this.operationResult = '生物识别密钥生成成功，需要指纹才能使用'
      console.info('Biometric key generated successfully')
    } catch (error) {
      const err = error as BusinessError
      this.operationResult = `密钥生成失败: ${err.message}`
      console.error(`Key generation error: code=${err.code}, message=${err.message}`)
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('生物识别密钥')
        .fontSize(24)

      Text('生成的密钥需要生物识别认证才能使用')
        .fontSize(14)
        .fontColor(Color.Gray)

      Text(this.operationResult)
        .fontColor(this.operationResult.includes('成功') ? Color.Green : Color.Red)

      Button('生成生物识别密钥')
        .onClick(() => {
          this.generateBiometricKey()
        })
    }
    .padding(20)
  }
}
```

## 三、证书管理

### 3.1 导入模块

```typescript
import { certManager } from '@kit.UniApplicationKit'
```

### 3.2 安装证书

```typescript
@ComponentV2
struct CertificateInstallation {
  @Local certPath: string = ''
  @Local installResult: string = ''

  async installCertificate() {
    try {
      // 读取证书文件
      const certData = await this.readCertificateFile(this.certPath)

      // 安装证书
      const result = await certManager.installAppCert(
        certData,
        certManager.CertEntryType.PEM
      )

      this.installResult = `证书安装成功: ${result}`
      console.info('Certificate installed successfully')
    } catch (error) {
      const err = error as BusinessError
      this.installResult = `证书安装失败: ${err.message}`
      console.error(`Certificate installation error: code=${err.code}, message=${err.message}`)
    }
  }

  private async readCertificateFile(path: string): Promise<Uint8Array> {
    // 读取证书文件的实现
    return new Uint8Array()
  }

  build() {
    Column({ space: 16 }) {
      Text('证书安装')
        .fontSize(24)

      TextInput({ placeholder: '证书文件路径', text: $$this.certPath })
        .width('100%')

      Text(this.installResult)
        .fontColor(this.installResult.includes('成功') ? Color.Green : Color.Red)

      Button('安装证书')
        .onClick(() => {
          this.installCertificate()
        })
    }
    .padding(20)
  }
}
```

### 3.3 使用证书签名

```typescript
@ComponentV2
struct CertificateSigning {
  @Local data: string = 'Hello, HarmonyOS!'
  @Local signature: string = ''
  @Local signResult: string = ''

  async signWithCertificate() {
    try {
      const dataBytes = new Uint8Array(Buffer.from(this.data).buffer)

      // 使用证书签名
      const result = await certManager.signWithCert(
        dataBytes,
        certManager.SignatureAlgorithm.RSA_PKCS1_WITH_SHA256
      )

      this.signature = Buffer.from(result).toString('base64')
      this.signResult = '签名成功'
      console.info('Data signed successfully')
    } catch (error) {
      const err = error as BusinessError
      this.signResult = `签名失败: ${err.message}`
      console.error(`Signing error: code=${err.code}, message=${err.message}`)
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('证书签名')
        .fontSize(24)

      TextInput({ placeholder: '输入数据', text: $$this.data })
        .width('100%')

      if (this.signature) {
        Text('签名结果:')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)

        Text(this.signature)
          .fontSize(14)
          .fontFamily('monospace')
          .maxLines(5)
      }

      Text(this.signResult)
        .fontColor(this.signResult.includes('成功') ? Color.Green : Color.Red)

      Button('签名')
        .onClick(() => {
          this.signWithCertificate()
        })
    }
    .padding(20)
  }
}
```

## 四、安全最佳实践

### 4.1 敏感数据加密存储

```typescript
@ObservedV2
export class SecureStorage {
  @Trace keyAlias: string = 'secure_storage_key'

  async saveSensitiveData(data: string): Promise<boolean> {
    try {
      // 使用 HUKS 加密数据
      const encryptOptions: huks.HuksOptions = {
        properties: new Array<huks.HuksParam>(),
        inData: new Uint8Array(Buffer.from(data).buffer)
      }

      const result = await huks.encrypt(this.keyAlias, encryptOptions)

      // 存储加密后的数据
      const encryptedData = Buffer.from(result.outData).toString('base64')
      Preferences.setData('sensitive_data', encryptedData)

      return true
    } catch (error) {
      console.error('Failed to save sensitive data:', error)
      return false
    }
  }

  async getSensitiveData(): Promise<string | null> {
    try {
      // 读取加密数据
      const encryptedData = await Preferences.getData('sensitive_data')
      if (!encryptedData) {
        return null
      }

      // 使用 HUKS 解密数据
      const decryptOptions: huks.HuksOptions = {
        properties: new Array<huks.HuksParam>(),
        inData: new Uint8Array(Buffer.from(encryptedData, 'base64').buffer)
      }

      const result = await huks.decrypt(this.keyAlias, decryptOptions)
      return Buffer.from(result.outData).toString('utf-8')
    } catch (error) {
      console.error('Failed to get sensitive data:', error)
      return null
    }
  }
}
```

### 4.2 生物识别认证包装器

```typescript
export class BiometricAuthenticator {
  private authType: biometricAuth.AuthType
  private authTrustLevel: biometricAuth.AuthTrustLevel

  constructor(
    authType: biometricAuth.AuthType = biometricAuth.AuthType.FINGERPRINT,
    authTrustLevel: biometricAuth.AuthTrustLevel = biometricAuth.AuthTrustLevel.ATL1
  ) {
    this.authType = authType
    this.authTrustLevel = authTrustLevel
  }

  async authenticate(reason: string = '验证身份以继续'): Promise<boolean> {
    return new Promise((resolve) => {
      try {
        const authInstance = biometricAuth.getAuthInstance(
          this.authType,
          this.authTrustLevel
        )

        authInstance.auth(reason, (result: biometricAuth.AuthResult) => {
          resolve(result.result === biometricAuth.AuthResultType.SUCCESS)
        })

      } catch (error) {
        console.error('Biometric authentication error:', error)
        resolve(false)
      }
    })
  }

  async isAvailable(): Promise<boolean> {
    try {
      const authInstance = biometricAuth.getAuthInstance(
        this.authType,
        this.authTrustLevel
      )
      return await authInstance.isAvailable()
    } catch (error) {
      console.error('Check availability error:', error)
      return false
    }
  }
}

// 使用示例
@ComponentV2
struct SecureActionExample {
  private authenticator: BiometricAuthenticator = new BiometricAuthenticator()

  async performSecureAction() {
    const isAuthenticated = await this.authenticator.authenticate('验证指纹以执行操作')

    if (isAuthenticated) {
      // 执行敏感操作
      console.info('User authenticated, performing secure action')
    } else {
      // 认证失败
      console.error('Authentication failed')
    }
  }

  build() {
    Column() {
      Button('执行安全操作')
        .onClick(() => {
          this.performSecureAction()
        })
    }
  }
}
```

### 4.3 双因素认证

```typescript
@ComponentV2
struct TwoFactorAuthExample {
  @Local step: number = 1
  @Local biometricSuccess: boolean = false
  @Local pinCode: string = ''

  async authenticateBiometric() {
    const authenticator = new BiometricAuthenticator(
      biometricAuth.AuthType.FINGERPRINT,
      biometricAuth.AuthTrustLevel.ATL2
    )

    const success = await authenticator.authenticate('验证指纹')
    if (success) {
      this.biometricSuccess = true
      this.step = 2
    }
  }

  verifyPin() {
    // 验证 PIN 码
    if (this.pinCode === '123456') {
      console.info('Two-factor authentication successful')
      // 执行操作
    } else {
      console.error('Invalid PIN code')
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('双因素认证')
        .fontSize(24)

      if (this.step === 1) {
        // 第一步：生物识别
        Text('第一步：验证指纹')
          .fontSize(16)

        Button('验证指纹')
          .onClick(() => {
            this.authenticateBiometric()
          })
      } else if (this.step === 2) {
        // 第二步：PIN 码
        Text('第二步：输入 PIN 码')
          .fontSize(16)

        TextInput({ placeholder: 'PIN 码', text: $$this.pinCode })
          .type(InputType.Number)
          .maxLength(6)
          .width('100%')

        Button('验证')
          .onClick(() => {
            this.verifyPin()
          })
      }
    }
    .padding(20)
  }
}
```

## 五、常见问题

### Q1: 生物识别认证失败？

**可能原因和解决方案**:

```typescript
// 1. 检查设备是否支持
async checkBiometricSupport() {
  const authInstance = biometricAuth.getAuthInstance(
    biometricAuth.AuthType.FINGERPRINT,
    biometricAuth.AuthTrustLevel.ATL1
  )

  const available = await authInstance.isAvailable()
  if (!available) {
    console.error('Device does not support fingerprint authentication')
    return false
  }

  // 2. 检查用户是否注册了生物特征
  const enrolled = await authInstance.hasEnrolled()
  if (!enrolled) {
    console.error('No fingerprint enrolled')
    return false
  }

  return true
}

// 3. 降低安全级别
const authInstance = biometricAuth.getAuthInstance(
  biometricAuth.AuthType.FINGERPRINT,
  biometricAuth.AuthTrustLevel.ATL1  // 使用较低的安全级别
)
```

### Q2: HUKS 密钥生成失败？

**解决方案**:

```typescript
// 确保使用正确的密钥属性
const keyProperties: huks.HuksKeyProperties = {
  keyAlias: 'my_key',
  keySize: huks.HuksKeySize.HUKS_AES_KEY_SIZE_256,
  keyPurpose: huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_ENCRYPT |
               huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_DECRYPT,
  keyAlg: huks.HuksKeyAlg.HUKS_ALG_AES,
  // 确保设置正确的存储级别
  keyStorageLevel: huks.HuksKeyStorageLevel.HUKS_STORAGE_L0
}

try {
  await huks.generateKey(keyProperties)
} catch (error) {
  const err = error as BusinessError
  console.error(`Key generation failed: ${err.code} - ${err.message}`)

  // 处理常见错误
  if (err.code === 120004) {
    console.error('Key already exists, delete first')
    await huks.deleteKey(keyProperties)
    await huks.generateKey(keyProperties)
  }
}
```

### Q3: 如何处理生物识别认证超时？

```typescript
async authenticateWithTimeout(timeoutMs: number = 30000): Promise<boolean> {
  return Promise.race([
    new Promise<boolean>((resolve) => {
      const authInstance = biometricAuth.getAuthInstance(
        biometricAuth.AuthType.FINGERPRINT,
        biometricAuth.AuthTrustLevel.ATL1
      )

      authInstance.auth('验证指纹', (result: biometricAuth.AuthResult) => {
        resolve(result.result === biometricAuth.AuthResultType.SUCCESS)
      })
    }),
    new Promise<boolean>((resolve) => {
      setTimeout(() => {
        console.error('Authentication timeout')
        resolve(false)
      }, timeoutMs)
    })
  ])
}
```

### Q4: 如何在后台使用生物识别？

```typescript
// HarmonyOS 要求在前台使用生物识别
// 如需后台认证，使用服务通知

async requestBackgroundAuth() {
  // 发送服务通知，用户点击后返回应用
  const notificationRequest = {
    id: 1,
    content: {
      contentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
      normal: {
        title: '需要身份验证',
        text: '点击此处验证身份',
        additionalText: '为了保护您的安全'
      }
    }
  }

  await notificationManager.publish(notificationRequest)

  // 用户点击通知后，返回应用进行生物识别
}
```

## 六、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9-11 | ⚠️ | 使用旧的 `@ohos.biometric` 模块 |
| API 12+ | ✅ | 使用新的 `@ohos.security.biometric` 模块 |
| API 13+ | ✅ | 增强的 HUKS 功能 |
| API 14+ | ✅ | 星盾安全架构支持 |

## 七、参考资料

- [证书管理开发指导 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/certmanager-guidelines-V5)
- [服务器端开发 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/device-attestation-servers-V5)
- [HarmonyOS生物识别认证深度解析：从指纹到人脸的安全实践](https://blog.csdn.net/u013176440/article/details/153914988)
- [React Native鸿蒙：BiometricAuth指纹解锁实现](https://blog.csdn.net/IRpickstars/article/details/157282037)

## 八、总结

HarmonyOS 6.0 提供了完整的安全组件体系：

**核心安全能力**:
- 生物识别认证（指纹、人脸）
- HUKS 硬件级加密存储
- 证书管理和签名
- 星盾安全架构

**最佳实践**:
- 始终验证认证失败原因
- 为敏感操作提供多重认证
- 合理选择安全级别
- 妥善处理认证超时和错误

**安全注意事项**:
- 不要在代码中硬编码密钥
- 使用 HUKS 存储敏感数据
- 定期更新和轮换密钥
- 遵循最小权限原则

通过合理使用安全组件，可以为用户提供安全可靠的使用体验，保护用户数据和隐私。
