let s = React.string

@react.component
let make = (~post: Post.t, ~handleDeleteLater) => {
  let paragraphs = Belt.Array.reduce(post.text, <> </>, (acc, text) => <>
    {acc} <p className="mb-1 text-sm"> {s(text)} </p>
  </>)

  <div className="bg-green-700 hover:bg-green-900 text-gray-300 hover:text-gray-100 px-8 py-4 mb-4">
    <h2 className="text-2xl mb-1"> {s(post.title)} </h2>
    <h3 className="mb-4"> {s(post.author)} </h3>
    {paragraphs}
    <button
      className="mr-4 mt-4 bg-red-500 hover:bg-red-900 text-white py-2 px-4"
      onClick={post->handleDeleteLater}>
      {s("Remove this post")}
    </button>
  </div>
}
