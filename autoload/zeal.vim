" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    49


if !exists('g:zeal#system')
    " How to run a shell command.
    let g:zeal#system = has('win32') || has('win64') ? 'silent ! start %s' : 'silent !%s&'  "{{{2
endif


if !exists('g:zeal#cmd')
    " The zeal command.
    let g:zeal#cmd = has('win32') || has('win64') ? 'zeal.exe' : 'zeal'   "{{{2
endif


if !exists('g:zeal#docsets')
    " You can query multiple docsets by separating names with a comma, 
    " e.g. scala,akka
    " Based on https://github.com/KabbAmine/zeavim.vim/blob/master/plugin/zeavim.vim
    "
    " Buffer-local pendant: `b:zeal_docsets`
    " Can also be configured via `g:zeal#docset_{&ft}`.
    let g:zeal#docsets = {'cpp': 'c++', 'go': 'go', 'scss': 'sass', 'scala': 'scala,akka,java', 'sh': 'bash', 'tex': 'latex'}   "{{{2
endif


function! zeal#GetDocset(filetype) "{{{3
    if exists('g:zeal#docset_'. a:filetype)
        let ds = g:zeal#docset_{a:filetype}
    elseif has_key(g:zeal#docsets, a:filetype)
        let ds = g:zeal#docsets[a:filetype]
    else
        let ds = a:filetype
    endif
    return ds
endf


function! s:GetZealCmdf(filetype) "{{{3
    if exists('b:zeal_docsets')
        let ds = b:zeal_docsets
    else
        let ds = zeal#GetDocset(a:filetype)
    endif
    let cmd = printf("%s --query '%s:%%s'", g:zeal#cmd, ds)
    return cmd
endf


" Query zeal.
function! zeal#Zeal(word, filetype) "{{{3
    " TLogVAR a:word, a:filetype
    let cmd = printf(s:GetZealCmdf(a:filetype), shellescape(a:word, 1))
    exec printf(g:zeal#system, cmd)
endf


function! zeal#SetKeywordPrg(force) "{{{3
    " TLogVAR a:force, &g:keywordprg, &l:keywordprg, maparg('K', 'n')
    if a:force || (empty(&l:keywordprg) && empty(maparg('K', 'n')))
        " let &l:keywordprg = printf(s:GetZealCmdf(&filetype), '')
        noremap <buffer> <silent> K :call zeal#Zeal(expand("<cword>"), &filetype)<cr>
    endif
endf

