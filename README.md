#SHFSignature

It's a simple class that provide to draw a signature and result in UIImage.

![demo_signature](http://imageshack.com/a/img924/8009/7VMsEu.png)

#How to use ?

Implement a protocol SHFSignatureProtocol in your UIViewController class or extension

```<swift>
protocol SHFSignatureProtocol {    
    func drawingSignature ()
    func image (_ signature: UIImage?) -> ()
}
```

In SHFSignatureProtocol there are two functions, the first method is returned during to drawing and second method returns the UIimage signature when you finished drawing.
#and
In your Storbyboard add UIView with subclass of SHFSignatureView, this class responds to protocol.
<br>
<br>
#That's simple and useful
