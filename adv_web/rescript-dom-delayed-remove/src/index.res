switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.render(<PostFeed />, root)
| None => Js.log("Error: could not find react mount element")
}

/*
  The code below help preserve your UI state changes even
  when you are editing code. Without it any code change
  will refresh the browser state. Any of your previous user
  interactions will have to be manually performed again to
  get the application back to the state you were testing
  earlier. So this saves a lot of time in development!
  
  https://www.snowpack.dev/concepts/hot-module-replacement
 */
@scope("import") @val external meta: 'a = "meta"
if meta["hot"] {
  meta["hot"]["accept"]()
}
