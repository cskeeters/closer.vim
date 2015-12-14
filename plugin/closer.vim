if exists("loaded_closer")
    finish
endif
let loaded_closer = 1

function! s:CloseLine()
    let curlinenum = line(".")
    let m = matchlist(getline("."), '\v([0-9]+) .*')
    if len(m) > 0
        let bn = eval(m[1])
        let bname = bufname(bn)

        "TagBar won't come back if bdelete is called
        if "__TagBar__" != bname
            execute "bdelete ".bn

            setl modifiable
            let lastlinenum = line("$")
            let i = curlinenum
            while i<lastlinenum
                call setline(i, getline(i+1))
                let i += 1
            endwhile
            call cursor(lastlinenum, 1)
            normal dd
            call cursor(curlinenum, 1)
            "call setline(lastlinenum, "")
            setl nomodifiable
        endif
    else
        bdelete
    endif
endfunction

function! s:OpenCloser()
    "Open the Window
    botright edit __CLOSER__
    setl modifiable

    "Modify the lines

    let last_buffer = bufnr("$")
    let line_number = 1
    let bn = 1
    while bn <= last_buffer
        if bufloaded(bn)
            if buflisted(bn)
                if bufname(bn) != "__CLOSER__"
                    call setline(line_number, bn." ".bufname(bn))
                    let line_number += 1
                endif
            endif
        endif
        let bn = bn + 1
    endwhile

    "Set properties
    normal gg
    setl buftype=nofile
    setl noswapfile
    setl nomodifiable
    setf diff
    nmap <buffer> x :call <SID>CloseLine()<cr>
    nmap <buffer> q :bdelete<CR>
endfunction

noremap <unique> <script> <Plug>OpenCloser <SID>OpenCloser
noremap <SID>OpenCloser :call <SID>OpenCloser()<cr>
noremenu <script> Plugin.OpenCloser <SID>OpenCloser
command! -nargs=0 OpenCloser call s:OpenCloser()
