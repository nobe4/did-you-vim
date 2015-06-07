" get a random number using the bach $RANDOM function
" http://vi.stackexchange.com/a/819/1821
function! GetRandomNumber()
	let random  = system("echo $RANDOM")
	return random
endfunction

" get the total number tof tags in the tag file
" :h line
" http://stackoverflow.com/a/22891311/2558252
function! GetTagsNumber()
	" open the tag file in a new buffer
	view $VIMRUNTIME/doc/tags
	" save the line number of the end of file
	let tagsNumber = line('$')
	" move back to the previous buffer
	buffer
	" delete the previously opened buffer (the tags file)
	bdelete
	return tagsNumber
endfunction

" get a valid random tag number
function! GetRandomTagNumber()
	let randomNumber = GetRandomNumber()
	let tagNumber = GetTagsNumber()
	let randomTag = randomNumber % tagNumber
	return randomTag
endfunctio

function! GetRandomTag()
	let randomTag = GetRandomTagNumber()
	view $VIMRUNTIME/doc/tags
	call setpos('.', [0, randomTag, 0, 0])
	let tagValue = expand('<cWORD>')
	buffer
	bdelete
	echom tagValue
endfunction

nnoremap <leader>sr :call GetRandomNumber()<cr>
nnoremap <leader>sn :call GetTagsNumber()<cr>
nnoremap <leader>sd :call GetRandomTagNumber()<cr>
nnoremap <leader>st :call GetRandomTag()<cr>
nnoremap <Leader>ss :source %<cr>

" references
echo "sourced"
