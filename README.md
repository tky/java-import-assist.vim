
## Add import sentence easy for java.

This is a plugin which insert import sentennce for java.  
This plugin find file in your project and insert import sentence.

## Configuration

This is an example `~/.vimrc` configuration for NeoBundle.

  * `:imp` to insert package sentence to the first line in your file.

```vim
" Plugin key-mappings."
NeoBundleLazy 'tky/java-import-assist.vim' ,{
  \ 'filetypes' : 'java',
\}
let s:hooks = neobundle#get_hooks('java-import-assist.vim')
function! s:hooks.on_source(bundle)
  nnoremap :imp :JavaImportPackage<CR>
endfunction
```
