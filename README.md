![kandinsky](/Assets/kandinsky.png)

## A Swift Layout DSL
<p align="left">
<a href="https://travis-ci.org/mislavjavor/Kandinsky"><img src="https://travis-ci.org/mislavjavor/Kandinsky.svg?branch=master" alt="Build status" /></a>
<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift3-compatible-4BC51D.svg?style=flat" alt="Swift 3 compatible" /></a>
<a href="https://cocoapods.org/pods/Kandinsky"><img src="https://img.shields.io/cocoapods/v/Kandinsky.svg" alt="CocoaPods compatible" /></a>
<a href="https://raw.githubusercontent.com/mislavjavor/Kandinsky/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
</p>

Author: [Mislav Javor](http://mislavjavor.com).

## Looking for contributors

This project is currently a one man operation. I've dedicated a large chuck of
my free time to this, and would be immensely grateful for any help. </br>
Thank you for contributing ❤️



## Why Kandinsky

- Storyboards are hard to maintain, obfuscate functionality, hard to reuse
and almost impossible to merge.</br>
- Writing in code is extremely verbose, time consuming and lacks a high level
overview of the layout

**Kandinsky** combines the expressiveness of storyboards with the power of Swift
language.

- Swift Powered DSL
- Easy to write and read
- Modular (build reusable components)
- Reactive (RxSwift/ReactiveCocoa) friendly
- Interactive prototyping using playgrounds
- Easy to merge
- Turing complete (`for` loops, `if` statemets, protocols, interitance etc...)
layout code

## Example

If we write this:

```swift
UIView.set {
     $0.id = "root"
     $0.view.backgroundColor = .lightGray }.add { r in

        UIButton.set {
            $0.id = "myButton"
            $0.view.setTitle(buttonTitle, for: .normal)
            $0.view.setTitleColor(.black, for: .normal)
            $0.centerInParent()
        }/r
}
```

We get this:

![preview](/Assets/preview_base.gif)

### Easily add new elements to your layout. Use playgrounds for live preview

![Basic example](/Assets/adding_new_label.gif)

### Apply behaviour to your layout while you're writing it

![Interactivity](/Assets/interactivity.gif)

### Quickly iterate over multiple versions of your layout. Use playground to visualise

![Quick Edit](/Assets/quick_edit.gif)

## Requirements

* iOS 9.0+
* Xcode 8.0+

## Getting Started

#### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects.

To install Kandinsky, simply add the following line to your Podfile:

```ruby
pod 'Kandinsky', '~> 1.0.1'
```

### Carthage

Carthage support coming soon

### Basic layout

First make sure to `import Kandinsky`.

The syntax for the DSL is really simple and intuitive. After you've imported
`Kandinsky`, any class inheriting from `UIView` (e.g. `UIButton`, `UILabel`)
will have a `set` method exposed like so:

```swift
UIView.set { (param: Kandinsky<UIView>) -> Void in
    /*
    The ID of the view, which can later be used for styling
    and querying
    */
    param.id = "<id>"

    /*
    The `view` property is the instance of the view which
    is being created (e.g. if you're creating a UIButton the `view`
    property would be a UIButton)
    */
    param.view.backgroundColor = .red
}
```

This takes care of view creation and customization. The next step is to
add subviews. We can set this by calling the `add` method (note: unlike
`set`, `add` is not static and must be called after the `set` block)

```swift
UIView.set {
    $0.id = "root"
    $0.view.backgroundColor = .black }.add { r in // calling the `add` method, `r` is placeholder for `root`

        UIButton.set {
            $0.id = "demoButton"
            $0.view.setTitle("Push me!", for: .normal)

            /*
            The framework exposes many methods for adding constraints
            like `centerInParent`, `alignParentLeading`, `under(id:)`,
            `toLeftOf(:)`. You can also easily create your own constraint
            helper methods
            */
            $0.centerInParent()


        }/r // The `/` operator adds the left side item to the right side item
            // in this case it means it adds the Kandinsky<UIButton> to the `r`
            // variable which we declared above and which is an instance of
            // Kandinsky<UIView>. The `/` operator can add any two elements
            // of type `Canvas to one another`
}
```

Here is a simple example:
```swift
let layout =
UIView.set {
    $0.view.backgroundColor = .white }.add { r in

        UILabel.set {
            $0.id = "titleLabel"
            $0.view.text = "Hello world"
            $0.fontSize = 30 // fontSize is a helper function
            $0.centerInParent()
        }/r

        UIButton.set {
            $0.view.setTitle("Push me!", for: .normal)
            $0.view.setTitleColor(.blue, for: .normal)
            $0.under("titleLabel")
            $0.centerHorizontallyInParent()
        }/r

}
```

This produces a view that looks like this:

![Simple example](/Assets/simple_example.png)

### Implementing the layout

In order to use your layout, simply make your `UIViewController` implement the
`Controller` protocol. This means adding the `didRender(ViewHolder:root:)` method
to your `UIViewController`.

Then in the `loadView` method of your `UIViewController`,
call the `setContentView` function and pass the instance of your layout

The `didRender` method will be called after all of the views have been added
and constraints set.

You can use it to extract views from the `ViewHolder` by using the

```swift
let myView = views["<view_id>"] as? UIButton // cast to your specific view
```

```swift
class DemoVC: UIViewController, Controller {

    var views: ViewHolder = [:]

    override func loadView() {
        super.loadView()
        setContentView(with: layout)
    }

    func didRender(views: ViewHolder, root: AnyCanvas) {
        self.views = views
        let button = views["pressMeButton"] as? UIButton
        button?.addTarget(self, action: #selector(didTouchButton), for: .touchUpInside)
    }

    func didTouchButton() {
        let title = views["titleLabel"] as? UILabel
        title?.text = "Pressed the button"
        PlaygroundHelper.alert(over: self, message: "Pressed the button")
    }
}
```

Note - `setContentView` only sets the `view` property of the `UIViewController` and
calls the `didRender` method. You can call it at any time, but it's recommended to
call it in the `loadView` method

### Getting the view

If you don't want to inherit the `Controller` and just want the view from your
canvas, you can do it like this:
```swift
let view = CanvasRenderer.render(demoLayout)
```

### Extending the framework

This framework is build by following the latest and greatest in the protocol
oriented world of Swift. If you wish to add additional functionality, you only
need to extend the `Canvas` protocol

```swift
extension Canvas {

    func alignParentLeadingAndTrailing(offset: Int) {
        // If you're working with constraints - you must append your code
        // to the `deferAfterRender` array. Otherwise your app will fail
        deferToAfterRender.append({ views in
            self.view.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(offset)
                make.trailing.equalToSuperview().offset(-offset)
            }
        })
    }
}
```

And after you've done that you can call it:

```swift
...
UIButton.set {
    ...
    $0.alignParentLeadingAndTrailing(offset: 20)
    ...
}
...
```

You can also be more specific:

```swift
extension Canvas where UIKitRepresentation == UITableView {

    func setDelegateAndDataSource<T>(item: T)
        where T: UITableViewDelegate, T: UITableViewDataSource {

            self.view.delegate = item
            self.view.dataSource = item
    }

}


extension Canvas where UIKitRepresentation: UILabel {

    func setTextToLoremIpsum() {
        self.view.text = "Lorem ipsum dolor sit..." // ...
    }

}
```

And then those properties will only appear on those types of `Canvas`es

```swift
UITableView.set {
    $0.setDelegateAndDataSource(item: delegate)
}

UILabel.set {
    $0.setTextToLoremIpsum()
}
```

## Getting involved

* If you **want to contribute** please feel free to **submit pull requests**.
* If you **have a feature request** please **open an issue**.
* If you **found a bug** or **need help** please **check older issues, [FAQ](#faq) and threads on [StackOverflow](http://stackoverflow.com/questions/tagged/Kandinsky) (Tag 'Kandinsky') before submitting an issue.**.

Before contribute check the [CONTRIBUTING](https://github.com/mislavjavor/Kandinsky/blob/master/CONTRIBUTING.md) file for more info.

## Examples

Follow these 3 steps to run Example project:
- Clone Kandinsky repository
- Open `Kandinsky.xcworkspace`
- Run the `Example` project

**OR**

- Open the `Example/Playground` and play around with live-preview

## Author

* [Mislav Javor](https://github.com/mislavjavor) ([@mislavjavor](https://twitter.com/mislavjavor))


# Change Log

This can be found in the [CHANGELOG.md](CHANGELOG.md) file.
