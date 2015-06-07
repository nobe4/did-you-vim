" get a random number using the bach $RANDOM function
" http://vi.stackexchange.com/a/819/1821
function! GetRandomNumber()
	let random  = system("echo $RANDOM")
	return random
endfunction

" open tag file
function! OpenTagsFile()
	" open the tag file in a new buffer
	sview $VIMRUNTIME/doc/tags
endfunction

" close file
function! CloseTagsFile()
	" move back to the previous buffer
	buffer
	" delete the previously opened buffer (the tags file)
	bdelete
endfunction

" get the total number tof tags in the tag file
" :h line
" http://stackoverflow.com/a/22891311/2558252
function! GetTagsNumber()
	" save the line number of the end of file
	let tagsNumber = line('$')
	return tagsNumber
endfunction

" get a valid random tag number
function! GetRandomTagNumber()
	let randomNumber = GetRandomNumber()
	let tagNumber = GetTagsNumber()
	let randomTag = randomNumber % tagNumber
	return randomTag
endfunctio

" combine previous function to get a random valid tag
function! GetRandomTag()
	call OpenTagsFile()
	let randomTag = GetRandomTagNumber()
	call setpos('.', [0, randomTag, 0, 0])
	let tagValue = expand('<cWORD>')
	call CloseTagsFile()
	echom tagValue
endfunction

" custom mapping for plugin testing
" nnoremap <leader>sr :call GetRandomNumber()<cr>
" nnoremap <leader>sn :call GetTagsNumber()<cr>
" nnoremap <leader>sd :call GetRandomTagNumber()<cr>
nnoremap <leader>pt :call GetRandomTag()<cr>
nnoremap <Leader>ps :source %<cr>

echo "Sourced"
