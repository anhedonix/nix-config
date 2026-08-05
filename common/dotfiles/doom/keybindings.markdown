  # Keybindings defined in the main emacs.tangle.org file
  | Keys | Modifiers | Details |
  | ---- | --------- | ------- |
  | `SPC` || Hydra main leader Key |
  | `leader` `n`| | number mode |
  | | `k` `=` `+` | Increment Number |
  | | `j` `-` `_` | Decrease Number |
  | | `f` | Finish/exit mode |
  | `leader` `t`| | Toggles/Changes |
  | `leader` `t` `t`| | Interactive change Theme |
  | `leader` `t` `s`| | Font Scale Mode |
  | | `k` `=` `+` | Increase Font size |
  | | `j` `-` `_` | Decrease Font size |
  | | `0` `o` `O` | Reset Font size  |
  | | `f` | Finish/exit mode |
  | `leader` `s` | | Settings Prefix |
  |  | `e` | Open main Emacs Tangle Config |
| `M-/` || evil-comment/uncomment |
  | `g ;` or `g ,` | | go-to last change, or previous change </br> TODO add a Hydra shortcut to move between edits |
  | `C-s` | | Swiper search current buffer |
  | `leader` `b` | | Buffers |
  |  | `b` | Switch Buffers |
  |  | `q` `k` | Kill Buffer |
  | `leader` `w` || Window management |
  | | `w` | Other Window |
  | | `q` | Quit Window |
  | | `x` | Close other windows |
  | | `-` `_` | Split Window Horizontal |
  | | `\` `\|` | Split Window Vertical |
  | | `=` | Balance windows |
  | `leader` `q` || Quit Emacs |
  | | `q` | Emacs Quit All |
  | | `Q` | Emacs Save & Quit |
  | | `r` | Emacs Restarr |
  | | `n` | Emacs New Session |
  | `leader` `p` || Project |
  | | `p`         | Find Project |
  | | `i`         | Invalidate Project Cache |
  | | `d`         | Discover new projects in path |
  | | `/`         | Find in project |
  | | `b`         | Project Buffers |
  | | `f`         | Project Find File |
  | `leader` `SPC` | | Project Find File |
## Markings
  | Mark | Location                           |
  | ---- | ---------------------------------- |
  | <    | Beginning of last visual selection |
  | >    | End of last visual selection       |
  | [    | Beginning of last pasted segment   |
  | ]    | End of last pasted segment         |
  | ^    | End of last insertion              |
  | {    | Beginning of current paragraph     |
  | }    | End of current paragraph           |
