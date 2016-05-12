" load plugin only once
" && verify vim is nocompatible
if exists("g:did_you_vim_version") || &cp
	  finish
endif

" plugin version
let g:did_you_vim_version = 0.1

" get a random number using the bach $RANDOM function
" http://vi.stackexchange.com/a/819/1821
function! GetRandomNumber()
    if has('win32')
        return system("echo %RANDOM%")
    else
        return system("echo $RANDOM")
    endif
endfunction

let g:selectedTag = ""

" this function will save the current article to a specified file for a next
" read
function! SaveTag()
	echomsg g:selectedTag
	" todo
endfunction

" get a random documentation tag and save it
function! s:GetRandomTag()
	" open the tag file in a new buffer
	" http://stackoverflow.com/a/22891311/2558252
	sview $VIMRUNTIME/doc/tags

	" get the total number tof tags in the tag file
	" :h line
	let tagsNumber = line('$')

	" get a valid random tag number
	let randomTag = GetRandomNumber() % tagsNumber

	" move to the corresponding line
	call setpos('.', [0, randomTag, 0, 0])
	
	" get the current WORD in the tag
	let g:selectedTag = expand('<cWORD>')

	" move back to the previous buffer
	buffer
	" delete the previously opened buffer (the tags file)
	bdelete
endfunction

" display the documentation corresponding to the saved tag
function! s:DisplayRandomTag()

	" open a new tab and display the help inside it
	tabnew
	execute ":h " . g:selectedTag

	" resize the help to full size
	execute ":res"

	" map for the new buffer the q command to quit
	nnoremap <buffer> q :tabclose<CR>
	" map for the new buffer the s key to save the current tag
	nnoremap <buffer> s :call SaveTag()<CR>
endfunction

function! s:DidYouVim()
	" load this session tag
	silent call <SID>GetRandomTag()
	" display this session tag's documentation
	silent call <SID>DisplayRandomTag()
endfunction

" Autoload only on user demand
if exists("g:did_you_vim_autoload")
	silent call <SID>DidYouVim()
endif


" define user-accessible command
command! DYV silent call <SID>DidYouVim()
