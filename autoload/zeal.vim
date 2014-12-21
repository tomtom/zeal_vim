" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    20


if !exists('g:zeal#system')
    let g:zeal#system = has('win32') || has('win64') ? 'silent ! start %s' : 'silent !%s&'  "{{{2
endif


if !exists('g:zeal#cmd')
    let g:zeal#cmd = has('win32') || has('win64') ? 'zeal.exe' : 'zeal'   "{{{2
endif


if !exists('g:zeal#docsets')
    " Based on https://github.com/KabbAmine/zeavim.vim/blob/master/plugin/zeavim.vim
    let g:zeal#docsets = {'cpp': 'C++', 'scss': 'Sass', 'sh': 'Bash', 'tex': 'Latex'}   "{{{2
endif


function! zeal#Zeal(word, filetype) "{{{3
    " TLogVAR a:word, a:filetype
    if exists('g:zeal#docset_'. a:filetype)
        let ds = g:zeal#docset_{a:filetype}
    elseif has_key(g:zeal#docsets, a:filetype)
        let ds = g:zeal#docsets[a:filetype]
    else
        let ds = substitute(a:filetype, '^.', '\u\0', '')
    endif
    let cmd = printf("%s --query '%s:%s'", g:zeal#cmd, ds, a:word)
    exec printf(g:zeal#system, cmd)
endf

