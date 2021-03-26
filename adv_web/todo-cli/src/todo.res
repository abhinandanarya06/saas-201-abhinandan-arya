module Fs = {
  @bs.module("fs")
  external readFile: (string, string) => string = "readFileSync"
  @bs.module("fs")
  external appendFile: (string, string) => unit = "appendFileSync"
  @bs.module("fs")
  external writeFile: (string, string) => unit = "writeFileSync"
  @bs.module("fs")
  external exists: string => bool = "existsSync"
}

@bs.module("os")
external eol: string = "EOL"

@val @scope("process") external argv: array<string> = "argv"

let helpString = `Usage :-
$ ./todo add "todo item"  # Add a new todo
$ ./todo ls               # Show remaining todos
$ ./todo del NUMBER       # Delete a todo
$ ./todo done NUMBER      # Complete a todo
$ ./todo help             # Show usage
$ ./todo report           # Statistics`

let getToday: unit => string = %raw(`
function() {
  let date = new Date();
  return new Date(date.getTime() - (date.getTimezoneOffset() * 60000))
    .toISOString()
    .split("T")[0];
}
  `)

module Todos: {
  type t =
    | Todo // => "./todo.txt"
    | Done // => "./done.txt"
  let toFileName: t => string
  let readTodosFrom: string => array<string>
  let getTodosFrom: t => array<string>
  let addTodosTo: (t, string) => unit
  let overwriteTodosTo: (t, array<string>) => unit
} = {
  type t =
    | Todo
    | Done

  let toFileName = file =>
    switch file {
    | Todo => "./todo.txt"
    | Done => "./done.txt"
    }

  let readTodosFrom = filename => {
    if !Fs.exists(filename) {
      []
    } else {
      let text = Fs.readFile(filename, "utf-8")
      let lines = Js.String.split(eol, text)
      Js.Array.filter(todo => todo !== "", lines)
    }
  }

  let getTodosFrom = file => readTodosFrom(file->toFileName)

  let addTodosTo = (file, todo) => Fs.appendFile(file->toFileName, todo)

  let overwriteTodosTo = (file, todos) => {
    Fs.writeFile(file->toFileName, "")
    Js.Array.forEach(todo => addTodosTo(file, todo ++ "\n"), todos)
  }
}

module TodoCommands: {
  type t =
    | Help
    | Ls
    | Add(option<string>)
    | Del(option<int>)
    | Done(option<int>)
    | Report
  let command: (option<string>, option<string>) => t
} = {
  type t =
    | Help
    | Ls
    | Add(option<string>)
    | Del(option<int>)
    | Done(option<int>)
    | Report

  let command = (arg, cmd) => {
    switch cmd {
    | Some("help") => Help
    | Some("ls") => Ls
    | Some("add") => Add(arg)
    | Some("del") => Del(Belt.Option.flatMap(arg, Belt.Int.fromString))
    | Some("done") => Done(Belt.Option.flatMap(arg, Belt.Int.fromString))
    | Some("report") => Report
    | Some(_) => Help
    | None => Help
    }
  }
}

module TodoManager: {
  let do: TodoCommands.t => unit
  let help: unit => unit
  let ls: unit => unit
  let add: option<string> => unit
  let del: option<int> => unit
  let done: option<int> => unit
  let report: unit => unit
} = {
  let help = () => Js.log(helpString)

  let ls = () => {
    let todos = Todos.getTodosFrom(Todos.Todo)
    let size = Js.Array.length(todos)
    if size > 0 {
      todos
      ->Belt.Array.reverse
      ->Belt.Array.reduceWithIndex("", (acc, x, i) =>
        acc ++ `[${(size - i)->Belt.Int.toString}] ${x}\n`
      )
      ->Js.log
    } else {
      Js.log("There are no pending todos!")
    }
  }

  let add = todo => {
    switch todo {
    | Some(todoString) => {
        Todos.addTodosTo(Todos.Todo, todoString ++ "\n")
        Js.log(`Added todo: "${todoString}"`)
      }
    | None => Js.log(`Error: Missing todo string. Nothing added!`)
    }
  }

  let del = todoId => {
    switch todoId {
    | Some(todo_id) => {
        let todos = Todos.getTodosFrom(Todos.Todo)
        if todo_id > 0 && todo_id <= Js.Array.length(todos) {
          let _ = Js.Array.spliceInPlace(~pos=todo_id - 1, ~remove=1, todos, ~add=[])
          Todos.overwriteTodosTo(Todos.Todo, todos)
          Js.log(`Deleted todo #${Sys.argv[3]}`)
        } else {
          Js.log(`Error: todo #${Sys.argv[3]} does not exist. Nothing deleted.`)
        }
      }
    | None => Js.log(`Error: Missing NUMBER for deleting todo.`)
    }
  }

  let done = todoId => {
    switch todoId {
    | Some(todo_id) => {
        let todos = Todos.getTodosFrom(Todos.Todo)
        if todo_id > 0 && todo_id <= Js.Array.length(todos) {
          Todos.addTodosTo(Todos.Done, `x ${getToday()} ${todos[todo_id - 1]}\n`)
          let _ = Js.Array.spliceInPlace(~pos=todo_id - 1, ~remove=1, todos, ~add=[])
          Todos.overwriteTodosTo(Todos.Todo, todos)
          Js.log(`Marked todo #${Sys.argv[3]} as done.`)
        } else {
          Js.log(`Error: todo #${Sys.argv[3]} does not exist.`)
        }
      }
    | None => Js.log(`Error: Missing NUMBER for marking todo as done.`)
    }
  }

  let report = () =>
    Js.log(
      `${getToday()} Pending : ${Belt.Int.toString(
          Js.Array.length(Todos.getTodosFrom(Todos.Todo)),
        )} Completed : ${Belt.Int.toString(Js.Array.length(Todos.getTodosFrom(Todos.Done)))}`,
    )

  let do = cmd =>
    switch cmd {
    | TodoCommands.Help => help()
    | Ls => ls()
    | Add(todo) => add(todo)
    | Del(todoId) => del(todoId)
    | Done(todoId) => done(todoId)
    | Report => report()
    }
}

/* ***------     MAIN EXECUTION POINT     ------*** */
let command: option<string> = argv->Belt.Array.get(2)
let arg = argv->Belt.Array.get(3)
arg->TodoCommands.command(command)->TodoManager.do
