@val external document: {..} = "document"

module Counter: {
  type t

  let make: (~initialValue: int) => t

  let update: (t, ~step: int) => t

  let currentValue: t => int
} = {
  type t = int

  let make = (~initialValue) => initialValue

  let update = (t, ~step) => t + step

  let currentValue = t => t
}

module CounterView: {
  type t

  let make: Counter.t => t

  let renderHTML: (
    t,
    ~element: {@set "innerHTML": string, @set "className": string},
    ~getInnerHTML: int => string,
    ~getCssClassName: int => string,
  ) => unit
} = {
  type t = Counter.t

  let make = t => t

  let renderHTML = (t, ~element, ~getInnerHTML, ~getCssClassName) => {
    let currentValue = t->Counter.currentValue
    element["innerHTML"] = getInnerHTML(currentValue)
    element["className"] = getCssClassName(currentValue)
  }
}

/*
  The `Counter` module by itself is immutable. But it is used in a
  situation where a `ref` value is necessary. The `Counter` interface
  is suitable for this use case because it provides:
    - an ability to make a counter value `make`,
    - update an existing counter value `update(~step)` and,
    - get the current value of from the counter type `currentValue`

  The `Counter.t` is opaque.
 */
let count = ref(Counter.make(~initialValue=0))

let element = document["getElementById"]("count")

/*
  Inversion of control
  --------------------

  The call-site passes a lambda `getCssClassName` which knows which
  CSS class names should be applied. This lambda gets called with the
  current value of the count.

  We also pass another lambda `getInnerHTML` with the current value
  of the count to return the text(or innerHTML) that should be displayed.

  The `Counter` & `CounterView` modules are devoid of any specific
  rendering logic. This gives you the freedom to configure the UI from
  the call-site. This is the inversion of control to the caller or the
  call-site, rather than the callee.
 */
let renderView = count => {
  let getCssClassName = n =>
    if n == 0 {
      "count count-zero"
    } else if n > 0 {
      "count count-positive"
    } else {
      "count count-negative"
    }

  let getInnerHTML = n => `Count is ${n->Belt.Int.toString}`

  count.contents
  ->CounterView.make
  ->CounterView.renderHTML(~element, ~getInnerHTML, ~getCssClassName)
}

renderView(count) // <-- Initial render

let updateCount = (count, ~step) => count := count.contents->Counter.update(~step)

let plusOneButton = document["getElementById"]("plus-one")
plusOneButton["addEventListener"]("click", _mouseEvt => {
  count->updateCount(~step=1)
  count->renderView
})

let minusOneButton = document["getElementById"]("minus-one")
minusOneButton["addEventListener"]("click", _mouseEvt => {
  count->updateCount(~step=-1)
  count->renderView
})
