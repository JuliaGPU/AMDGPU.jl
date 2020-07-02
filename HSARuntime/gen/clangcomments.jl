
function get_raw_comment(cursor::CLCursor)
    stringptr = clang_Cursor_getRawCommentText(cursor.cursor)
    if stringptr.data == C_NULL
        return nothing
    else
        cstring = clang_getCString(stringptr)
        return unsafe_string(cstring)
    end
end

function get_comment(obj::CLCursor)
    clang_Cursor_getParsedComment(obj.cursor)
end 

function Clang.children(c::CXComment)

    num_children = Int(clang_Comment_getNumChildren(c))
    list = CXComment[]
    for i in 1:num_children
        child = clang_Comment_getChild(c, i-1)
        clang_Comment_isWhitespace(child) == UInt32(0) && push!(list, child)
    end
    return list
end

function Clang.name(c::CXComment)
end

function Clang.kind(c::CXComment)
    clang_Comment_getKind(c)
end


