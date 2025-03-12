# Azure Service Bus Lab

此專案示範如何使用 Azure Service Bus 的佇列(Queue)功能來進行訊息的發送與接收。

## 專案結構

- `az204svcbusSend`: 訊息發送端程式
- `az204svcbusRec`: 訊息接收端程式

## 前置需求

1. Azure 訂閱帳號
2. Azure Service Bus 命名空間
3. .NET Core SDK 3.1 或更新版本
4. Visual Studio 2019 或 VS Code

## 安裝步驟

1. 複製此專案
2. 更新 `ServiceBusConnectionString` 為您的連接字串
3. 在 Visual Studio 中開啟方案或使用 `dotnet run` 執行

## 發送端程式說明 (az204svcbusSend)

發送端程式具有以下功能：
- 建立與 Service Bus Queue 的連線
- 發送 10 條測試訊息
- 每條訊息包含序號
- 支援非同步發送
- 包含例外處理機制

主要程式碼：
```csharp
static async Task SendMessagesAsync(int numberOfMessagesToSend)
{
    for (var i = 0; i < numberOfMessagesToSend; i++)
    {
        string messageBody = $"Message {i}";
        var message = new Message(Encoding.UTF8.GetBytes(messageBody));
        await queueClient.SendAsync(message);
    }
}
```

## 接收端程式說明 (az204svcbusRec)

接收端程式具有以下功能：
- 建立與 Service Bus Queue 的連線
- 註冊訊息處理程序
- 支援並行訊息處理
- 自動確認訊息接收
- 完整的例外處理機制

主要程式碼：
```csharp
static void RegisterOnMessageHandlerAndReceiveMessages()
{
    var messageHandlerOptions = new MessageHandlerOptions(ExceptionReceivedHandler)
    {
        MaxConcurrentCalls = 1,
        AutoComplete = false
    };
    queueClient.RegisterMessageHandler(ProcessMessagesAsync, messageHandlerOptions);
}
```

## 注意事項

1. 連接字串請妥善保管，不要上傳至版本控制系統
2. 實際運作時建議使用配置檔管理連接字串
3. 在生產環境中應適當調整 MaxConcurrentCalls 的值

## 相關資源

- [Azure Service Bus 文件](https://docs.microsoft.com/azure/service-bus-messaging/)
- [Microsoft.Azure.ServiceBus SDK](https://www.nuget.org/packages/Microsoft.Azure.ServiceBus/)
