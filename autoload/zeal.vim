" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    25


if !exists('g:zeal#system')
    let g:zeal#system = has('win32') || has('win64') ? 'silent ! start %s' : 'silent !%s&'  "{{{2
endif


if !exists('g:zeal#cmd')
    let g:zeal#cmd = has('win32') || has('win64') ? 'zeal.exe' : 'zeal'   "{{{2
endif


if !exists('g:zeal#docsets')
    " You can query multiple docsets by separating names with a comma, 
    " e.g. scala,akka
    " Based on https://github.com/KabbAmine/zeavim.vim/blob/master/plugin/zeavim.vim
    "
    " Buffer-local pendant: `b:zeal_docsets`
    " Can also be configured via `g:zeal#docset_{&ft}`.
    let g:zeal#docsets = {'cpp': 'C++', 'scss': 'Sass', 'sh': 'Bash', 'tex': 'Latex'}   "{{{2
endif


function! zeal#Zeal(word, filetype) "{{{3
    " TLogVAR a:word, a:filetype
    if exists('b:zeal_docsets')
        let ds = b:zeal_docsets
    elseif exists('g:zeal#docset_'. a:filetype)
        let ds = g:zeal#docset_{a:filetype}
    elseif has_key(g:zeal#docsets, a:filetype)
        let ds = g:zeal#docsets[a:filetype]
    else
        let ds = a:filetype
    endif
    let cmd = printf("%s --query '%s:%s'", g:zeal#cmd, ds, shellescape(a:word, 1))
    exec printf(g:zeal#system, cmd)
endf

