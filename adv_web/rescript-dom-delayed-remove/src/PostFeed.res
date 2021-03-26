let s = React.string

open Belt

type state = {
  posts: array<Post.t>,
  forDeletion: Map.String.t<Js.Global.timeoutId>,
}

type action =
  | DeleteLater(Post.t, Js.Global.timeoutId)
  | DeleteAbort(Post.t)
  | DeleteNow(Post.t)

let reducer = (state, action) =>
  switch action {
  | DeleteLater(post, timeoutId) => {
      posts: state.posts,
      forDeletion: state.forDeletion->Map.String.set(post.id, timeoutId),
    }
  | DeleteAbort(post) => {
      posts: state.posts,
      forDeletion: state.forDeletion->Map.String.remove(post.id),
    }
  | DeleteNow(post) => {
      posts: state.posts->Js.Array2.filter(e => Post.id(e) != post.id),
      forDeletion: state.forDeletion->Map.String.remove(post.id),
    }
  }

let initialState = {posts: Post.examples, forDeletion: Map.String.empty}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState)

  let handleDeleteAbort = (post, _evt) => {
    switch state.forDeletion->Map.String.get(post->Post.id) {
    | Some(timeoutID) => Js.Global.clearTimeout(timeoutID)
    | None => Js.log("Can\'t find timeout ID, Post will be deleted or already deleted")
    }
    DeleteAbort(post)->dispatch
  }

  let handleDeleteNow = (post, _evt) => DeleteNow(post)->dispatch

  let handleDeleteLater = (post, _evt) => {
    let timeoutId = Js.Global.setTimeout(() => {
      DeleteNow(post)->dispatch
    }, 10_000)
    DeleteLater(post, timeoutId)->dispatch
  }

  <div className="max-w-3xl mx-auto mt-8 relative">
    {state.posts
    ->Belt.Array.map(post => {
      if state.forDeletion->Map.String.has(post.id) {
        <DeletedPost key={post.id} post={post} handleDeleteAbort handleDeleteNow />
      } else {
        <PostView key={post.id} post={post} handleDeleteLater />
      }
    })
    ->React.array}
  </div>
}
