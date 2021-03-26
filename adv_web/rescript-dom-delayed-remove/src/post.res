@module("nanoid") @val external nanoid: unit => string = "nanoid"

type t = {
  id: string,
  title: string,
  author: string,
  text: array<string>,
}

let make = (~title, ~author, ~text) => {id: nanoid(), title: title, author: author, text: text}
let title = t => t.title
let author = t => t.author
let text = t => t.text
let id = t => t.id

// Data
let examples = [
  make(
    ~title="The Razor's Edge",
    ~author="W. Somerset Maugham",
    ~text=[
      "\"I couldn't go back now. I'm on the threshold. I see vast lands of the spirit stretching out before me,
    beckoning, and I'm eager to travel them.\"",
      "\"What do you expect to find in them?\"",
      "\"The answers to my questions. I want to make up my mind whether God is or God is not. I want to find out why
    evil exists. I want to know whether I have an immortal soul or whether when I die it's the end.\"",
    ],
  ),
  make(
    ~title="Ship of Destiny",
    ~author="Robin Hobb",
    ~text=[
      "He suddenly recalled a callow boy telling his tutor that he dreaded the sea voyage home, because he would have
        to be among common men rather than thoughtful acolytes like himself. What had he said to Berandol?",
      "\"Good enough men, but not like us.\"",
      "Then, he had despised the sort of life where simply getting from day to day prevented a man from ever taking
        stock of himself. Berandol had hinted to him then that a time out in the world might change his image of folk
        who labored every day for their bread. Had it? Or had it changed his image of acolytes who spent so much time in
        self-examination that they never truly experienced life?",
    ],
  ),
  make(
    ~title="A Guide for the Perplexed: Conversations with Paul Cronin",
    ~author="Werner Herzog",
    ~text=[
      "Our culture today, especially television, infantilises us. The indignity of it kills our imagination. May I propose a Herzog dictum? Those who read own the world. Those who watch television lose it. Sitting at home on your own, in front of the screen, is a very different experience from being in the communal spaces of the world, those centres of collective dreaming. Television creates loneliness. This is why sitcoms have added laughter tracks which try to cheat you out of your solitude. Television is a reflection of the world in which we live, designed to appeal to the lowest common denominator. It kills spontaneous imagination and destroys our ability to entertain ourselves, painfully erasing our patience and sensitivity to significant detail.",
    ],
  ),
]
