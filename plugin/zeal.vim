" @Author:      Tom Link (micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @GIT:         http://github.com/tomtom/zeal_vim
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    35
" GetLatestVimScripts: 0 0 :AutoInstall: zeal.vim

if &cp || exists("loaded_zeal")
    finish
endif
let loaded_zeal = 1

let s:save_cpo = &cpo
set cpo&vim


if !exists('g:zeal_set_keywordprg')
    " If 0, don't set |keywordprg|.
    " If 1, set |keywordprg| if no buffer-local value for |keywordprg| 
    " was set.
    " if 2, always set |keywordprg|.
    " CAUTION: The variable must be set before loading the plugin.
    " NOTE: This doesn't actually set |keywordprg| but it defines a 
    " buffer-local map for K.
    let g:zeal_set_keywordprg = 1   "{{{2
endif


if !exists('g:zeal_map')
    " Map for normal & visual mode to call |:Zeal|.
    let g:zeal_map = '<F1>'   "{{{2
endif


if !exists('g:zeal_imap')
    " Map for insert & selecttion mode to call |:Zeal|.
    " NOTE: In insert mode, the map will return to normal mode.
    let g:zeal_imap = '<F1>'   "{{{2
endif


" :display: :Zeal [WORD]
" Call |zeal#Zeal()| with WORD or the word under cursor.
command! -nargs=? Zeal call zeal#Zeal(empty(<q-args>) ? expand("<cword>") : <q-args>, &filetype)


if !empty(g:zeal_map)
    exec 'nnoremap <silent>' g:zeal_map ':Zeal<cr>'
    exec 'xnoremap <silent>' g:zeal_map '""y:Zeal <c-r>"<cr>gv'
    exec 'inoremap <silent>' g:zeal_imap '<esc>:Zeal<cr>'
    exec 'snoremap <silent>' g:zeal_imap '<c-g>""y:Zeal <c-r>"<cr>gv<c-g>'
endif


if g:zeal_set_keywordprg > 0
    augroup Zeal
        autocmd!
        autocmd Filetype * call zeal#SetKeywordPrg(g:zeal_set_keywordprg == 2)
    augroup END
    if !has('vim_starting')
        call zeal#SetKeywordPrg(g:zeal_set_keywordprg == 2)
    endif
endif


let &cpo = s:save_cpo
unlet s:save_cpo
