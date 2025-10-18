# CompletionsAPI

All URIs are relative to *https://app.useblackman.ai/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**completions**](CompletionsAPI.md#completions) | **POST** /v1/completions | 


# **completions**
```swift
    open class func completions(completionRequest: CompletionRequest, xProviderApiKey: String? = nil, completion: @escaping (_ data: CompletionResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import BlackmanClient

let completionRequest = CompletionRequest(maxTokens: 123, stop: ["stop_example"], stream: false, temperature: 123, topP: 123, messages: [Message(content: "content_example", role: "role_example")], model: "model_example", provider: Provider()) // CompletionRequest | 
let xProviderApiKey = "xProviderApiKey_example" // String | Optional provider API key to override stored or system keys (optional)

CompletionsAPI.completions(completionRequest: completionRequest, xProviderApiKey: xProviderApiKey) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **completionRequest** | [**CompletionRequest**](CompletionRequest.md) |  | 
 **xProviderApiKey** | **String** | Optional provider API key to override stored or system keys | [optional] 

### Return type

[**CompletionResponse**](CompletionResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

