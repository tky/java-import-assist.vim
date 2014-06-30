function! jimpassist#import_package()
  let a:import_class = jimpassist#find_import_class(expand("<cword>"))
  if !empty(a:import_class)
    let a:line = jimpassist#find_insert_position(a:import_class)
    call jimpassist#insert_import(a:line - 1, a:import_class)
  endif
endfunction

function! jimpassist#find_import_class(target_class)
  let a:file_list = jimpassist#find_file_in_current_project(a:target_class)
  if len(a:file_list) > 0
    return jimpassist#format_package(a:file_list[0])
  else
    return "" 
  endif
endfunction

function! jimpassist#find_file_in_current_project(target_class)
  let a:file_list = glob("**/" . a:target_class . ".java")
  return split(a:file_list, "\n")
endfunction

function! jimpassist#insert_import(line, package)
  call append(a:line, "import " . a:package . ";")
endfunction

function! jimpassist#format_package(filename)
  let a:splitted = split(a:filename, "[/.]")

  let a:index = 0
  for p in a:splitted
    if (p =~ '\v(com|org)')
      return join(a:splitted[a:index : -2], ".")
    endif
    let a:index = a:index + 1
  endfor
  return a:filename
endfunction

function! jimpassist#find_insert_position(import_class)
  let i = jimpassist#find_last_import_position()
  while i > 0
    let i = i - 1
      return i
  endwhile
  return 0
endfunction

function! jimpassist#read_import(line_number)
  if (line =~# "^import")
    return split(getline(line_number)[:-1])[1]
  else
    return ""
  endif
endfunction

function! jimpassist#find_first_import_position()
  let lastlineno = line("$")
  let i = 0
  while i < lastlineno
    let i = i + 1
    let line = getline(i)
    if (line =~# "^import")
      return i
    endif
  endwhile
  return 0
endfunction

function! jimpassist#find_last_import_position()
  let lastlineno = line("$")
  let i = jimpassist#find_first_import_position()
  while i < lastlineno
    let i = i + 1
    let line = getline(i)
    if (line !~# "^import" && line !~# "^$" )
      return i
    endif
  endwhile
  return lastlineno
endfunction
