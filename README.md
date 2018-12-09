# The promised land

Demo project demonstrating how to build a service layer with promises, request behaviours and child view controllers.

# Motivation

Writing asynchronous code in Swift can be a cumbersome process when chaining requests, adding proper error handling and indicating status of network operation.

When chaining two or more request or functions invoked asynchronosuly, what we do frequently is nesting completion handlers and adding invocation of same error handler in several places, same with handling network activity indicator:

```swift

    func trigger() {
    	showActivityIndicator()
        send(completion: { [weak self] (model) in
            self?.ack(model: model, completion: {
                self?.hideActivityIndicator()
            }, error: { (error) in
                self?.hideActivityIndicator()
                self?.handle(error: error)
            })
        }) { (error) in
            self?.hideActivityIndicator()
            self?.handle(error: error)
        }
    }

```

What if this code, could be simply transformed to:

```swift

   func trigger() {
        send().then { [weak self] (model) in
            return self?.ack(model: model)
        }.then { (_) in
           ...
        }
    }

```

# How to compile?

```
carthage update --platform iOS
```

and then using Xcode 10 +


# References

This Demo project demonstrates a design pattern based on Promises, Request Behaviours and Child View Controllers.

Inspired and based on great work from [Soroush Khanlou]: http://khanlou.com
[http://khanlou.com/2017/01/request-behaviors/]: http://khanlou.com/2017/01/request-behaviors/]
[http://khanlou.com/2016/02/many-controllers/]: http://khanlou.com/2016/02/many-controllers/
[https://github.com/khanlou/Promise]: https://github.com/khanlou/Promise