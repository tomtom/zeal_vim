" @Author:      Tom Link (micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @GIT:         http://github.com/tomtom/zeal_vim
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    16
" GetLatestVimScripts: 0 0 :AutoInstall: zeal.vim

if &cp || exists("loaded_zeal")
    finish
endif
let loaded_zeal = 1

let s:save_cpo = &cpo
set cpo&vim


if !exists('g:zeal_map')
    " Map for normal & visual mode to call |:Zeal|.
    let g:zeal_map = 'gz'   "{{{2
endif


" :display: :Zeal [WORD]
" Call |zeal#Zeal()| with WORD or the word under cursor.
command! -nargs=? Zeal call zeal#Zeal(empty(<q-args>) ? expand("<cword>") : <q-args>, &filetype)


if !empty(g:zeal_map)
    exec 'nnoremap <silent>' g:zeal_map ':Zeal<cr>'
    exec 'xnoremap <silent>' g:zeal_map '""y:Zeal <c-r>"<cr>'
endif


let &cpo = s:save_cpo
unlet s:save_cpo
