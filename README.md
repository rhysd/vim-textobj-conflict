Text Object for Conflicts on Merge
==================================

## Installation

Please use your favorite plugin manager and follow the instruction of it.  Below is an example for [neobundle.vim](https://github.com/Shougo/neobundle.vim).

```vim
NeoBundle 'rhysd/vim-textobj-conflict'
```

## Dependency

This plugin depends on [vim-textobj-user](https://github.com/kana/vim-textobj-user).  Please install it in advance.

## Usage

`i=` and `a=` operator-pending mappings are available.  `i=` selects the inner lines of either ours or theirs of the conflict.  `a=` selects the whole lines of either ours or theirs of the conflict (including markers).

Try `va=`, `vi=`, `da=` and so on.

## TODO(s)

- Implementation
- Tests
- Documentation

## License

This software is distributed under [the MIT License](http://opensource.org/licenses/MIT).
