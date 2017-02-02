class LinkedList
	attr_accessor :head, :tail, :size

	def initialize
		@head = nil
		@tail = nil
		@size = 0
	end

	def append(node)
		if @size == 0
			@head = node
			@tail = node
			node.next_node = nil
			@size = 1
		else
			@tail.next_node = node
			@tail = node
			node.next_node = nil
			@size += 1
		end
	end

	def prepend(node)
		if @size == 0
			@head = node
			@tail = node
			node.next_node = nil
			@size = 1
		else
			node.next_node = @head
			@head = node
			@size += 1
		end
	end

	def at(index)
		return nil if (index < 0 || index >= @size)
		node = @head
		count = 0
		loop do
			return node if count == index
			node = node.next_node
			count += 1
		end
	end

	def pop
		if @size <= 0
			return nil
		elsif @size == 1
			node = @head
			@head = nil
			@tail = nil
			@size = 0
			return node
		else
			node = @head
			while node != @tail do
			 	node = node.next_node
			end
			@tail = node
			node.next_node = nil
			return node
		end
	end

	def contains?(data)
		node = @head
		loop do
			return true if node.value == data
			node = node.next_node
			break if node == nil
		end
		false
	end

	def find(data)
		index = 0
		node = @head
		loop do
			return index if node.value == data
			node = node.next_node
			index += 1
			break if node == nil
		end
		nil
	end

	def to_s
		ary = []
		node = @head
		loop do
			ary.push("( #{node.value} )")
			node = node.next_node
			break if node == nil
		end
		ary.join(' -> ') + ' -> nil'
	end

	def insert_at(index)
		# todo
	end

	def remove_at(index)
		if @size < 1
			return nil
		elsif @size == 1
			@size = 0
			@head = nil
			@tail = nil
		else
			if index == 0
				# remove head of list
				@head = @head.next_node
			elsif index == @size-1
				# remove tail of list
				node = @head
				while node.next_node != @tail
					node = node.next_node
				end
				@tail = node
				node.next_node = nil
			else
				# remove middle element of list, head and tail remain the same
				count = 0
				node = @head
				loop do
					node = node.next_node
					count += 1
					if count == index - 1
						break
					end
				end
				removed_node = node.next_node
				node.next_node = removed_node.next_node
				removed_node.next_node = nil
			end
			@size -= 1
		end
	end

	def insert_at(data, index=0)
		new_node = Node.new(data)
		if @size == 0
			@size = 1
			@head = new_node
			@tail = new_node
		else
			if index <= 0
				# inserting at head of linked list
				self.prepend(new_node)
			elsif index >= @size
				# inserting at tail of linked list
				self.append(new_node)
			else
				# inserting in middle of linked list
				node = @head
				count = 1
				while count < index do
					node = node.next_node
					count += 1
				end
				new_node.next_node = node.next_node
				node.next_node = new_node
				@size += 1
			end
		end
	end

end

