" get a random number using the bach $RANDOM function
" http://vi.stackexchange.com/a/819/1821
function! GetRandomNumber()
	return system("echo $RANDOM")
endfunction

" combine previous function to get a random valid tag
function! GetRandomTag()
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
	let tagValue = expand('<cWORD>')

	" move back to the previous buffer
	buffer
	" delete the previously opened buffer (the tags file)
	bdelete

	tabnew
	execute ":h " . tagValue
	" echom tagValue
endfunction

nnoremap <leader>st :call GetRandomTag()<cr>
nnoremap <Leader>ss :source %<cr>

echo "Sourced"
