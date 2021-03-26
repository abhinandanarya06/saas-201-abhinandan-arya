let s = React.string

@react.component
let make = (~post: Post.t, ~handleDeleteAbort, ~handleDeleteNow) => {
  <div className="relative bg-yellow-100 px-8 py-4 mb-4 h-40">
    <p className="text-center white mb-1">
      {s(
        `This post from ${post.title} by ${post.author} will be permanently removed in 10 seconds.`,
      )}
    </p>
    <div className="flex justify-center">
      <button
        onClick={post->handleDeleteAbort}
        className="mr-4 mt-4 bg-yellow-500 hover:bg-yellow-900 text-white py-2 px-4">
        {s("Restore")}
      </button>
      <button
        onClick={post->handleDeleteNow}
        className="mr-4 mt-4 bg-red-500 hover:bg-red-900 text-white py-2 px-4">
        {s("Delete Immediately")}
      </button>
    </div>
    <div className="bg-red-500 h-2 w-full absolute top-0 left-0 progress" />
  </div>
}
