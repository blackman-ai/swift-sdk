# Blackman AI Swift SDK

Official Swift client for [Blackman AI](https://www.useblackman.ai) - The AI API proxy that optimizes token usage to reduce costs.

## Features

- 🚀 Drop-in replacement for OpenAI, Anthropic, and other LLM APIs
- 💰 Automatic token optimization (save 20-40% on costs)
- 📊 Built-in analytics and cost tracking
- 🔒 Enterprise-grade security with SSO support
- ⚡ Low latency overhead (<50ms)
- 🎯 Semantic caching for repeated queries
- ⚙️ Swift Concurrency (async/await)
- 📱 iOS, macOS, tvOS, watchOS support

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/blackman-ai/swift-sdk.git", from: "0.0.9")
]
```

Or in Xcode:
1. File → Add Package Dependencies
2. Enter: `https://github.com/blackman-ai/swift-sdk.git`
3. Select version: `0.0.9`

## Quick Start

```swift
import BlackmanClient

// Configure client
BlackmanClientAPI.basePath = "https://app.useblackman.ai"
BlackmanClientAPI.customHeaders = [
    "Authorization": "Bearer sk_your_blackman_api_key"
]

// Create completion request
let message = Message(
    role: "user",
    content: "Explain quantum computing in simple terms"
)

let request = CompletionRequest(
    provider: "OpenAI",
    model: "gpt-4o",
    messages: [message]
)

// Send request
Task {
    do {
        let response = try await CompletionsAPI.completions(completionRequest: request)
        print(response.choices[0].message.content)
        print("Tokens used: \(response.usage.totalTokens)")
    } catch {
        print("Error: \(error)")
    }
}
```

## Authentication

Get your API key from the [Blackman AI Dashboard](https://app.useblackman.ai/settings/api-keys).

```swift
BlackmanClientAPI.basePath = "https://app.useblackman.ai"
BlackmanClientAPI.customHeaders = [
    "Authorization": "Bearer sk_your_blackman_api_key"
]
```

## Framework Integration

### SwiftUI App

```swift
import SwiftUI
import BlackmanClient

@main
struct MyApp: App {
    init() {
        // Configure Blackman client
        BlackmanClientAPI.basePath = "https://app.useblackman.ai"
        BlackmanClientAPI.customHeaders = [
            "Authorization": "Bearer \(ProcessInfo.processInfo.environment["BLACKMAN_API_KEY"] ?? "")"
        ]
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var userMessage = ""
    @State private var response = ""
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter your message", text: $userMessage)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button("Send") {
                sendMessage()
            }
            .disabled(isLoading || userMessage.isEmpty)

            if isLoading {
                ProgressView()
            }

            Text(response)
                .padding()
        }
        .padding()
    }

    func sendMessage() {
        isLoading = true

        let message = Message(
            role: "user",
            content: userMessage
        )

        let request = CompletionRequest(
            provider: "OpenAI",
            model: "gpt-4o",
            messages: [message]
        )

        Task {
            do {
                let result = try await CompletionsAPI.completions(completionRequest: request)
                await MainActor.run {
                    response = result.choices[0].message.content
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    response = "Error: \(error.localizedDescription)"
                    isLoading = false
                }
            }
        }
    }
}
```

### ViewModel Pattern

```swift
import Foundation
import BlackmanClient

@MainActor
class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var isLoading = false
    @Published var error: String?

    func sendMessage(_ content: String) async {
        isLoading = true
        error = nil

        // Add user message
        messages.append(ChatMessage(role: "user", content: content))

        let message = Message(role: "user", content: content)
        let request = CompletionRequest(
            provider: "OpenAI",
            model: "gpt-4o",
            messages: [message]
        )

        do {
            let response = try await CompletionsAPI.completions(completionRequest: request)
            let assistantMessage = response.choices[0].message.content
            messages.append(ChatMessage(role: "assistant", content: assistantMessage))
        } catch {
            self.error = error.localizedDescription
        }

        isLoading = false
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let role: String
    let content: String
}
```

### UIKit Integration

```swift
import UIKit
import BlackmanClient

class ChatViewController: UIViewController {
    private let textView = UITextView()
    private let inputField = UITextField()
    private let sendButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @objc private func sendMessage() {
        guard let text = inputField.text, !text.isEmpty else { return }

        let message = Message(role: "user", content: text)
        let request = CompletionRequest(
            provider: "OpenAI",
            model: "gpt-4o",
            messages: [message]
        )

        Task {
            do {
                let response = try await CompletionsAPI.completions(completionRequest: request)
                await MainActor.run {
                    textView.text = response.choices[0].message.content
                }
            } catch {
                await MainActor.run {
                    textView.text = "Error: \(error.localizedDescription)"
                }
            }
        }
    }

    private func setupUI() {
        // Setup UI components...
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
}
```

## Advanced Usage

### Custom Timeout

```swift
BlackmanClientAPI.requestBuilderFactory = AlamofireRequestBuilderFactory(
    configuration: URLSessionConfiguration.default.apply {
        $0.timeoutIntervalForRequest = 60
        $0.timeoutIntervalForResource = 120
    }
)
```

### Error Handling

```swift
do {
    let response = try await CompletionsAPI.completions(completionRequest: request)
    print(response.choices[0].message.content)
} catch let error as ErrorResponse {
    print("API Error: \(error.localizedDescription)")
} catch {
    print("Unexpected error: \(error)")
}
```

### Retry Logic

```swift
func completionsWithRetry(
    request: CompletionRequest,
    maxRetries: Int = 3
) async throws -> CompletionResponse {
    var lastError: Error?

    for attempt in 0..<maxRetries {
        do {
            return try await CompletionsAPI.completions(completionRequest: request)
        } catch {
            lastError = error
            if attempt < maxRetries - 1 {
                // Exponential backoff
                let delay = UInt64(pow(2.0, Double(attempt)) * 1_000_000_000)
                try await Task.sleep(nanoseconds: delay)
            }
        }
    }

    throw lastError ?? NSError(domain: "Retry failed", code: -1)
}
```

### Concurrent Requests

```swift
let messages = ["Message 1", "Message 2", "Message 3"]

await withTaskGroup(of: CompletionResponse?.self) { group in
    for messageContent in messages {
        group.addTask {
            let message = Message(role: "user", content: messageContent)
            let request = CompletionRequest(
                provider: "OpenAI",
                model: "gpt-4o",
                messages: [message]
            )

            return try? await CompletionsAPI.completions(completionRequest: request)
        }
    }

    for await response in group {
        if let response = response {
            print(response.choices[0].message.content)
        }
    }
}
```

### Cancellation

```swift
let task = Task {
    try await CompletionsAPI.completions(completionRequest: request)
}

// Cancel after 5 seconds
Task {
    try await Task.sleep(nanoseconds: 5_000_000_000)
    task.cancel()
}

do {
    let response = try await task.value
    print(response.choices[0].message.content)
} catch is CancellationError {
    print("Request was cancelled")
}
```

## Documentation

- [Full API Reference](https://app.useblackman.ai/docs)
- [Getting Started Guide](https://app.useblackman.ai/docs/getting-started)
- [Swift Examples](https://github.com/blackman-ai/swift-sdk/tree/main/examples)

## Requirements

- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
- Swift 5.9+
- Xcode 15.0+

## Support

- 📧 Email: [support@blackman.ai](mailto:support@blackman.ai)
- 💬 Discord: [Join our community](https://discord.gg/blackman-ai)
- 🐛 Issues: [GitHub Issues](https://github.com/blackman-ai/swift-sdk/issues)

## License

MIT © Blackman AI
