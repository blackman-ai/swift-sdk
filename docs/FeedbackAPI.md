# FeedbackAPI

All URIs are relative to *https://app.useblackman.ai/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**submitFeedback**](FeedbackAPI.md#submitfeedback) | **POST** /v1/feedback | Submit feedback for a completion response


# **submitFeedback**
```swift
    open class func submitFeedback(submitFeedbackRequest: SubmitFeedbackRequest, completion: @escaping (_ data: SubmitFeedbackResponse?, _ error: Error?) -> Void)
```

Submit feedback for a completion response

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import BlackmanClient

let submitFeedbackRequest = SubmitFeedbackRequest(isPositive: false, metadata: 123, responseId: "responseId_example") // SubmitFeedbackRequest | 

// Submit feedback for a completion response
FeedbackAPI.submitFeedback(submitFeedbackRequest: submitFeedbackRequest) { (response, error) in
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
 **submitFeedbackRequest** | [**SubmitFeedbackRequest**](SubmitFeedbackRequest.md) |  | 

### Return type

[**SubmitFeedbackResponse**](SubmitFeedbackResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

