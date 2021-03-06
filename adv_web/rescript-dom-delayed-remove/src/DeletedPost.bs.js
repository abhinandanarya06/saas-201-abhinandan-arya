// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "bs-platform/lib/es6/curry.js";
import * as React from "react";

function s(prim) {
  return prim;
}

function DeletedPost(Props) {
  var post = Props.post;
  var handleDeleteAbort = Props.handleDeleteAbort;
  var handleDeleteNow = Props.handleDeleteNow;
  return React.createElement("div", {
              className: "relative bg-yellow-100 px-8 py-4 mb-4 h-40"
            }, React.createElement("p", {
                  className: "text-center white mb-1"
                }, "This post from " + post.title + " by " + post.author + " will be permanently removed in 10 seconds."), React.createElement("div", {
                  className: "flex justify-center"
                }, React.createElement("button", {
                      className: "mr-4 mt-4 bg-yellow-500 hover:bg-yellow-900 text-white py-2 px-4",
                      onClick: Curry._1(handleDeleteAbort, post)
                    }, "Restore"), React.createElement("button", {
                      className: "mr-4 mt-4 bg-red-500 hover:bg-red-900 text-white py-2 px-4",
                      onClick: Curry._1(handleDeleteNow, post)
                    }, "Delete Immediately")), React.createElement("div", {
                  className: "bg-red-500 h-2 w-full absolute top-0 left-0 progress"
                }));
}

var make = DeletedPost;

export {
  s ,
  make ,
  
}
/* react Not a pure module */
