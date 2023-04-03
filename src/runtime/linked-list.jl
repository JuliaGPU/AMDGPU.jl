mutable struct LinkedListNode{T}
    data::T
    @atomic next::Union{LinkedListNode{T},Nothing}
    LinkedListNode(data::T) where T = new{T}(data, nothing)
end

mutable struct LinkedList{T}
    @atomic head::Union{LinkedListNode{T},Nothing}
    LinkedList{T}() where T = new{T}(nothing)
end

function Base.push!(list::LinkedList{T}, data::T) where T
    ours = LinkedListNode(data)
    if @atomic(list.head) === nothing && @atomicreplace(list.head, nothing => ours)[2]
        return data
    end
    node = lastnode(list.head)
    while true
        if @atomic(node.next) === nothing
            # Attempt to swap with our node
            _, succ = @atomicreplace node.next nothing => ours
            if succ
                # Success, done
                return data
            end
        end
        # Advance to end
        node = last(node)::LinkedListNode{T}
    end
end
function next!(list::LinkedList)
    head = @atomic(list.head)
    isnothing(head) && throw(BoundsError())

    # N.B. We assume this is only done single-threaded
    next = @atomic(head.next)
    @atomic list.head = next
    return list
end
function Base.empty!(list::LinkedList)
    @atomic list.head = nothing
    return list
end
Base.isempty(list::LinkedList) = @atomic(list.head) !== nothing

function Base.first(list::LinkedList)
    head = @atomic(list.head)
    isnothing(head) && throw(BoundsError())
    return head.data
end

function Base.last(list::LinkedList)
    head = @atomic(list.head)
    isnothing(head) && throw(BoundsError())
    return last(head)
end

function lastnode(node::LinkedListNode)
    while true
        # Test if this is the last node
        if @atomic(node.next) === nothing
            return node
        else
            # Advance to next node
            node = @atomic node.next
        end
    end
end

Base.last(node::LinkedListNode) = lastnode(node).data

function maybelast(list::LinkedList)
    head = @atomic(list.head)
    if head === nothing
        return nothing
    end
    return last(head)
end

function Base.length(list::LinkedList)
    head = @atomic(list.head)
    isnothing(head) ? 0 : length(head)
end

function Base.length(node::LinkedListNode)
    ctr = 1
    while @atomic(node.next) !== nothing
        node = @atomic node.next
        ctr += 1
    end
    return ctr
end

function Base.show(io::IO, list::LinkedList{T}) where T
    print(io, "LinkedList{$T}($(length(list)) entries)")
end

function Base.copy(list::LinkedList{T}) where T
    new_list = LinkedList{T}()
    head = @atomic list.head
    isnothing(head) && return new_list

    @atomic new_list.head = head
    return new_list
end

function Base.Array(list::LinkedList{T}) where T
    vec = T[]
    node = @atomic(list.head)
    while node !== nothing
        push!(vec, node.data)
        node = @atomic(node.next)
    end
    return vec
end

function Base.iterate(list::LinkedList)
    head = @atomic list.head
    isnothing(head) && nothing : (head.data, head.next)
end

function Base.iterate(_::LinkedList, node)
    isnothing(node) && nothing : (node.data, node.next)
end
