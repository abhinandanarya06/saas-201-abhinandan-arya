@val external document: {..} = "document"
@val external window: {..} = "window"

module FontSelect = {
  @bs.deriving(jsConverter)
  type t =
    | Small
    | Regular
    | Large

  let fonts = ["text-sm", "text-2xl", "text-6xl"]
  let fontSize = (font: t) =>
    switch font {
    | Small => fonts[tToJs(Small)]
    | Regular => fonts[tToJs(Regular)]
    | Large => fonts[tToJs(Large)]
    }
  let setFont = (textNode: 'a, newFont: string) => {
    Belt.Array.forEach(fonts, font => {
      textNode["classList"]["remove"](font)
    })
    textNode["classList"]["add"](newFont)
  }
}

module Preview = {
  type t = {
    mutable text: string,
    mutable fontSize: string,
  }
  let dom = window["textView"]
  let setState = (state: t) => {
    dom["innerText"] = state.text
    dom->FontSelect.setFont(state.fontSize)
  }
}
module Editor = {
  type t = Preview.t
  let state: t = {
    text: "",
    fontSize: Regular->FontSelect.fontSize,
  }
  let textEditor = window["textEditor"]
  let radioButtonIds: array<string> = ["selectSmall", "selectRegular", "selectLarge"]
  let handleTextEdit = event => {
    state.text = event["target"]["value"]
    Preview.setState(state)
  }
  let getFont = id =>
    switch id {
    | Some("selectSmall") => FontSelect.Small
    | Some("selectRegular") => FontSelect.Regular
    | Some("selectLarge") => FontSelect.Large
    | Some(_) => FontSelect.Regular
    | None => FontSelect.Regular
    }
  let handleRadioButton = event => {
    state.fontSize = event["target"]["id"]->getFont->FontSelect.fontSize
    Preview.setState(state)
  }

  let startApp = () => {
    let _ = textEditor["addEventListener"]("input", handleTextEdit)
    radioButtonIds->Belt.Array.forEach(id => {
      document["getElementById"](id)["addEventListener"]("change", handleRadioButton)
    })
  }
}
Editor.startApp()
