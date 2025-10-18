# SemanticCacheAPI

All URIs are relative to *https://app.useblackman.ai/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getConfig**](SemanticCacheAPI.md#getconfig) | **GET** /v1/semantic-cache/config | Get semantic cache configuration for the current account
[**getStats**](SemanticCacheAPI.md#getstats) | **GET** /v1/semantic-cache/stats | Get semantic cache statistics including hit rate and savings
[**invalidateAll**](SemanticCacheAPI.md#invalidateall) | **DELETE** /v1/semantic-cache/invalidate | Invalidate all cache entries for the current account
[**updateConfig**](SemanticCacheAPI.md#updateconfig) | **PUT** /v1/semantic-cache/config | Update semantic cache configuration for the current account


# **getConfig**
```swift
    open class func getConfig(completion: @escaping (_ data: SemanticCacheConfig?, _ error: Error?) -> Void)
```

Get semantic cache configuration for the current account

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import BlackmanClient


// Get semantic cache configuration for the current account
SemanticCacheAPI.getConfig() { (response, error) in
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
This endpoint does not need any parameter.

### Return type

[**SemanticCacheConfig**](SemanticCacheConfig.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStats**
```swift
    open class func getStats(completion: @escaping (_ data: SemanticCacheStats?, _ error: Error?) -> Void)
```

Get semantic cache statistics including hit rate and savings

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import BlackmanClient


// Get semantic cache statistics including hit rate and savings
SemanticCacheAPI.getStats() { (response, error) in
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
This endpoint does not need any parameter.

### Return type

[**SemanticCacheStats**](SemanticCacheStats.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **invalidateAll**
```swift
    open class func invalidateAll(completion: @escaping (_ data: InvalidateResponse?, _ error: Error?) -> Void)
```

Invalidate all cache entries for the current account

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import BlackmanClient


// Invalidate all cache entries for the current account
SemanticCacheAPI.invalidateAll() { (response, error) in
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
This endpoint does not need any parameter.

### Return type

[**InvalidateResponse**](InvalidateResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateConfig**
```swift
    open class func updateConfig(semanticCacheConfig: SemanticCacheConfig, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Update semantic cache configuration for the current account

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import BlackmanClient

let semanticCacheConfig = SemanticCacheConfig(enabled: false, similarityThreshold: 123, ttlSeconds: 123) // SemanticCacheConfig | 

// Update semantic cache configuration for the current account
SemanticCacheAPI.updateConfig(semanticCacheConfig: semanticCacheConfig) { (response, error) in
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
 **semanticCacheConfig** | [**SemanticCacheConfig**](SemanticCacheConfig.md) |  | 

### Return type

Void (empty response body)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

