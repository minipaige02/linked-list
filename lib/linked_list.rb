
# Defines a node in the singly linked list
class Node
  attr_reader :data # allow external entities to read value but not write
  attr_accessor :next # allow external entities to read or write next node

  def initialize(value, next_node = nil)
    @data = value
    @next = next_node
  end
end

# Defines the singly linked list
class LinkedList
    def initialize
      @head = nil # keep the head private. Not accessible outside this class
    end

    # method to add a new node with the specific data value in the linked list
    # insert the new node at the beginning of the linked list
    def add_first(value)
      @head = Node.new(value, next_node = @head)
    end

    # method to find if the linked list contains a node with specified value
    # returns true if found, false otherwise
    def search(value)
      current = @head
      
      until current.nil?
        return true if current.data == value
        
        current = current.next
      end

      return false
    end

    # method to return the max value in the linked list
    # returns the data value and not the node
    def find_max
      return nil if @head.nil?

      max = @head.data
      current = @head

      until current.nil?
        if current.data > max
          max = current.data
        else
          current = current.next
        end
      end

      return max
    end

    # method to return the min value in the linked list
    # returns the data value and not the node
    def find_min
      return nil if @head.nil?

      min = @head.data
      current = @head

      until current.nil?
        if current.data < min
          min = current.data
        else
          current = current.next
        end
      end

      return min
    end


    # method that returns the length of the singly linked list
    def length
      length = 0
      current = @head

      until current.nil?
        length += 1
        current = current.next
      end

      return length
    end

    # method that returns the value at a given index in the linked list
    # index count starts at 0
    # returns nil if there are fewer nodes in the linked list than the index value
    def get_at_index(index)
      current = @head
      
      if current.nil?
        return nil
      elsif index > 0
        index.times do 
          current = current.next
        end
      end

      return current.data
    end

    # method to print all the values in the linked list
    def visit
      current = @head

      until current.nil?
        puts current.data
        current = current.next
      end
    end

    # method to delete the first node found with specified value
    def delete(value)
      return if @head.nil?

      previous = nil
      current = @head

      until current.nil?
        if current.data == value
          if previous == nil
            @head = current.next
          else
            previous.next = current.next
          end
        end
        previous = current
        current = current.next
      end
    end

    # method to reverse the singly linked list
    # note: the nodes should be moved and not just the values in the nodes
    def reverse
      return if @head.nil? || @head.next.nil?
      
      current = @head
      temp = nil

      until current.next.nil?
        next_node = current.next
        current.next = temp
        temp = current
        current = next_node
      end

      current.next = temp
      @head = current
    end


    ## Advanced Exercises
    # returns the value at the middle element in the singly linked list
    ### if the list has an even number of values, returns the value of
    ### the first of the two middle elements
    def find_middle_value
      length = self.length
      mid_index = length / 2
      if length.even?
        mid_index -= 1
      end
      
      return self.get_at_index(mid_index)
    end

    # find the nth node from the end and return its value
    # assume indexing starts at 0 while counting to n
    def find_nth_from_end(n)
      return nil if @head.nil?

      current = @head
      n_ahead = @head

      n.times do |i|
        n_ahead = n_ahead.next
        return if n_ahead.nil?
      end

      until n_ahead.next.nil?
        current = current.next
        n_ahead = n_ahead.next
      end

      return current.data
    end

    # checks if the linked list has a cycle. A cycle exists if any node in the
    # linked list links to a node already visited.
    # returns true if a cycle is found, false otherwise.
    def has_cycle
      return false if @head.nil? || @head.next.nil?

      slow = @head.next
      fast = @head.next.next

      while !fast.nil? && !fast.next.nil?
        if fast == slow
          return true
        else
          slow = slow.next
          fast = fast.next.next
        end
      end

      return false
    end


    # Additional Exercises 
    # returns the value in the first node
    # returns nil if the list is empty
    def get_first
      if @head.nil?
        return nil
      else 
        return @head.data
      end
    end

    # method that inserts a given value as a new last node in the linked list
    def add_last(value)
      if @head.nil?
        add_first(value)
      else
        current = @head

        until current.next.nil?
          current = current.next
        end

        current.next = Node.new(value)
      end
    end

    # method that returns the value of the last node in the linked list
    # returns nil if the linked list is empty
    def get_last
      last_node = @head

      until last_node.next.nil?
        last_node = last_node.next
      end

      return last_node.data
    end

    # method to insert a new node with specific data value, assuming the linked
    # list is sorted in ascending order
    def insert_ascending(value)
      if @head.nil?
        @list.add_first(value)
      else
        current = @head
        previous = nil

        until current.nil?
          if current.data > value
            if current == @head
              return self.add_first(value)
            else
              return previous.next = Node.new(value, current)
            end
          else
            previous = current
            current = current.next
          end
        end
        # adds value to end of linked list if it is larger than the last node
        previous.next = Node.new(value)
      end
    end

    # Helper method for tests
    # Creates a cycle in the linked list for testing purposes
    # Assumes the linked list has at least one node
    def create_cycle
      return if @head == nil # don't do anything if the linked list is empty

      # navigate to last node
      current = @head
      while current.next != nil
          current = current.next
      end

      current.next = @head # make the last node link to first node
    end
end
