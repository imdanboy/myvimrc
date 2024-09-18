function! EchoPinyin2(word)
    let l:pinyin = system('print_pinyin2 ' . a:word)
    " exclude NL by slicing
    echo l:pinyin[:-2]
endfunction

function! OpenDict(word)
    let l:a = system('open -a ' . '/Applications/Google\ Chrome.app ' . 'https://zh.dict.naver.com/#/search\?query=' . a:word)
endfunction

function! ToNumberList()
    let l:cnt = 1
    for i in range(1, line('$'))
        let l:line = getline(i)
        if l:line =~# '^- '
            let l:modified_line = substitute(l:line, '^- ', l:cnt . '. ', "")
            call setline(i, l:modified_line)
            let l:cnt += 1
        endif
    endfor
endfunction

function! ToHypenList()
    for i in range(1, line('$'))
        let l:line = getline(i)
        if l:line =~# '\v[0-9]+. '
            let l:modified_line = substitute(l:line, '\v[0-9]+. ', '- ', '')
            call setline(i, l:modified_line)
        endif
    endfor
endfunction

function! TextToSpeech(line)
    let l:a = system('say -v ' . 'Tingting ' . a:line) 
endfunction
