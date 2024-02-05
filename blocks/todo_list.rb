class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def to_s
    "#{@title}\n#{@todos}"
  end

  def add(item)
    if item.class == Todo
      @todos << item
    else
      raise TypeError.new("Can only add Todo objects")
    end
  end

  def <<(item)
    add(item)
  end

  def size
    @todos.length
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def to_a
    @todos
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def item_at(index)
    @todos.fetch(index)
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  def done!
    @todos.each { |todo| todo.done! }
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    if @todos.length <= index
      raise IndexError.new("Index out of bounds")
    else
      @todos.delete_at(index)
    end
  end

  def to_s
    str = "---- Today's Todos ----\n"
    str << @todos.map(&:to_s).join("\n")
    str
  end

  def each
    @todos.each { |todo| yield(todo) }
    self
  end

  def select
    new_list = TodoList.new("Selected Todos")
    @todos.select { |todo| yield(todo) }.each { |todo| new_list << todo }
    new_list
  end

  def find_by_title(title)
    select { |todo| todo.title == title }.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(title)
    to_do = find_by_title(title)
    to_do.done!
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end
end

# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

p list.find_by_title("Clean room")
#p list.all_done
#p list.all_not_done
#p list.mark_done("Clean room")
#p list.mark_all_done
#p list.mark_all_undone

=begin
list.each do |todo|
  puts todo                   # calls Todo#to_s
end

# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

#todo1.done!
#results = list.select { |todo| todo.done? }    # you need to implement this method
#puts results.inspect


# <<
# same behavior as add

# ---- Interrogating the list -----

# size
p list.size                       # returns 3


# first
p list.first                      # returns todo1, which is the first item in the list

# last
p list.last                       # returns todo3, which is the last item in the list

#to_a
p list.to_a                      # returns an array of all items in the list


#done?
p list.done?                     # returns true if all todos in the list are done, otherwise false

# ---- Retrieving an item in the list ----

# item_at
#p list.item_at                    # raises ArgumentError
p list.item_at(1)                 # returns 2nd item in list (zero based index)
#p list.item_at(100)               # raises IndexError

# ---- Marking items in the list -----

# mark_done_at
#list.mark_done_at               # raises ArgumentError
p list.mark_done_at(1)            # marks the 2nd item ßas done
#p list.mark_done_at(100)          # raises IndexError

# mark_undone_at
#p list.mark_undone_at             # raises ArgumentError
p list.mark_undone_at(1)          # marks the 2nd item as not done,
#p list.mark_undone_at(100)        # raises IndexError

# done!
p list.done!                      # marks all items as done

# ---- Deleting from the list -----

# shift
#p list.shift                      # removes and returns the first item in list

# pop
#p list.pop                        # removes and returns the last item in list

# remove_at
#p list.remove_at                  # raises ArgumentError
p list.remove_at(1)               # removes and returns the 2nd item
#p list.remove_at(100)             # raises IndexError

# ---- Outputting the list -----

# to_s
puts list                     # returns string representation of the list

# ---- Today's Todos ----
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

# or, if any todos are done

# ---- Today's Todos ----
# [ ] Buy milk
# [X] Clean room
# [ ] Go to gym

=end
