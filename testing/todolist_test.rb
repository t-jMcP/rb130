require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < Minitest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"
  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
  end

  def test_add_raise_error
    assert_raises(TypeError) { @list.add("Wash dishes") }
    assert_raises(TypeError) { @list.add(226257) }
  end

  def test_shovel
    todo_4 = Todo.new("Wash dishes")
    @list << todo_4
    assert_equal([@todo1, @todo2, @todo3, todo_4], @list.to_a)
  end

  def test_add
    todo_4 = Todo.new("Wash dishes")
    @list.add(todo_4)
    assert_equal([@todo1, @todo2, @todo3, todo_4], @list.to_a)
  end

  def test_item_at
    assert_equal(@todo2, @list.item_at(1))
    assert_raises(IndexError) { @list.item_at(3) }
  end

  def test_mark_done_at
    @list.mark_done_at(2)
    refute(@list.item_at(0).done?)
    refute(@list.item_at(1).done?)
    assert(@list.item_at(2).done?)
    assert_raises(IndexError) { @list.mark_done_at(10) }
  end

  def test_mark_undone_at
    @list.mark_done_at(0)
    @list.mark_undone_at(0)
    refute(@list.item_at(0).done?)
    assert_raises(IndexError) { @list.mark_undone_at(7) }
  end

  def test_done!
    @list.done!
    assert(@todo1.done?)
    assert(@todo2.done?)
    assert(@todo3.done?)
    assert(@list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(3) }
    @list.remove_at(1)
    assert_equal([@todo1, @todo3], @list.to_a)
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
  
    assert_equal(output, @list.to_s)
  end

  def test_to_s_2
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    @list.mark_done_at(0)
    assert_equal(output, @list.to_s)
  end

  def test_to_s_3
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.done!
    assert_equal(output, @list.to_s)
  end

  def test_each
    todos = []
    @list.each { |todo| todos << todo }
    assert_equal([@todo1, @todo2, @todo3], todos)
  end

  def test_each2
    assert_equal(@list, @list.each { nil })
  end

  def test_select
    @list.mark_done_at(1)
    remaining_tasks = @list.select { |todo| !todo.done? }
    assert_equal([@todo1, @todo3], remaining_tasks.to_a)
  end
end
