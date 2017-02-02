require 'spec_helper'

describe Node do
	before :each do
		@node = Node.new(10)
	end

	describe "#new" do
		it "takes one parameter and returns a Node object" do
			expect(@node).to be_an_instance_of Node
		end

		it "initializes with a value of 10" do
			expect(@node.value).to eq 10
		end

		it "initializes with a next_node of nil" do
			expect(@node.next_node).to eq nil
		end
	end
end

describe LinkedList do
	before :each do
		@list = LinkedList.new
	end

	describe "#new" do
		it "takes no parameters and returns a LinkedList object" do
			expect(@list).to be_an_instance_of LinkedList
		end
	end
	
	describe "#prepend" do
		context "applies to an empty list" do
			before :each do
				@node1 = Node.new(12)
				@list.prepend(@node1)
			end

			it "returns #size of 1" do
				expect(@list.size).to eq 1
			end

			it "returns #head value of 12" do
				expect(@list.head.value).to eq 12
			end

			it "returns #head next_node pointing to nil" do
				expect(@list.head.next_node).to be_nil
			end

			it "returns #head pointing to the new node" do
				expect(@list.head).to eq @node1
			end

			it "returns #tail pointing to the new node" do
				expect(@list.tail).to eq @node1
			end
		end

		context "applies to an non-empty list" do
			before :each do
				@node1 = Node.new(10)
				@node2 = Node.new(12)
				@node3 = Node.new(14)
				@list.prepend(@node1)
				@list.prepend(@node2)
				@list.prepend(@node3)
			end

			it "returns #size of 3" do
				expect(@list.size).to eq 3
			end

			it "returns #head value of 14" do
				expect(@list.head.value).to eq 14
			end

			it "returns #head next_node pointing to prior #head node" do
				expect(@list.head.next_node).to eq @node2
			end

			it "returns #tail pointing to last node in list" do
				expect(@list.tail).to eq @node1
			end
		end
	end

	describe "#append" do
		context "applies to an empty list" do
			before :each do
				@node1 = Node.new(20)
				@list.append(@node1)
			end

			it "returns #size of 1" do
				expect(@list.size).to eq 1
			end

			it "returns #head value of 20" do
				expect(@list.head.value).to eq 20
			end

			it "returns #head next_node pointing to nil" do
				expect(@list.head.next_node).to be_nil
			end

			it "returns #head pointing to the new node" do
				expect(@list.head).to eq @node1
			end

			it "returns #tail pointing to the new node" do
				expect(@list.tail).to eq @node1
			end
		end
		
		context "applies to an non-empty list" do
			before :each do
				@node1 = Node.new(22)
				@node2 = Node.new(24)
				@node3 = Node.new(26)
				@list.append(@node1)
				@list.append(@node2)
				@list.append(@node3)
			end

			it "returns #size of 3" do
				expect(@list.size).to eq 3
			end

			it "returns #tail value of 26" do
				expect(@list.tail.value).to eq 26
			end

			it "returns second node in list pointing to #tail" do
				expect(@node2.next_node).to eq @list.tail
			end

			it "returns #head pointing to first node in list" do
				expect(@list.head).to eq @node1
			end

			it "returns #tail next_node pointing to nil" do
				expect(@list.tail.next_node).to be_nil
			end
		end
	end

	describe "#at" do
		before :each do
			8.times { |n| @list.append(Node.new(3*n + 1)) }
		end

		it "returns node with value 1 for index 0" do
			node = @list.at(0)
			expect(node.value).to eq 1
		end

		it "returns node with value 10 for index 3" do
			node = @list.at(3)
			expect(node.value).to eq 10
		end

		it "returns node with value 22 for index 7" do
			node = @list.at(7)
			expect(node.value).to eq 22
		end
	end

	describe "#contains?" do
		before :each do
			7.times { |n| @list.append(Node.new(5*n + 2)) }
		end

		it "returns true for first value in list" do
			expect(@list.contains?(7)).to be true
		end

		it "returns true for a middle value in list" do
			expect(@list.contains?(22)).to be true
		end

		it "returns true for last value in list" do
			expect(@list.contains?(32)).to be true
		end

		it "returns false for value not found in list" do
			expect(@list.contains?(37)).to be false
		end
	end

	describe "#find" do
		before :each do
			10.times { |n| @list.prepend(Node.new(7*n + 4)) }
		end
		
		it "returns index of 0 for value of 67" do
			expect(@list.find(67)).to eq 0
		end

		it "returns index of 5 for value of 32" do
			expect(@list.find(32)).to eq 5
		end

		it "returns index of 9 for value of 4" do
			expect(@list.find(4)).to eq 9
		end

		it "returns index of nil if value is not found" do
			expect(@list.find(80)).to be_nil
		end
	end

	describe "#to_s" do
		it "returns correct string representing the list" do
			5.times { |n| @list.append(Node.new(10*n + 3)) }
			str = "( 3 ) -> ( 13 ) -> ( 23 ) -> ( 33 ) -> ( 43 ) -> nil"
			expect(@list.to_s).to eq str
		end
	end

	describe "#remove_at" do
		context "applies to a list containing a single node" do
			before :each do
				@list.append(Node.new(50))
				@list.remove_at(0)
			end

			it "#size should be zero" do
				expect(@list.size).to eq 0
			end

			it "#head should point to nil" do
				expect(@list.head).to be_nil
			end

			it "#tail should point to nil" do
				expect(@list.tail).to be_nil
			end
		end

		context "applies to first element of a list with size > 1" do
			before :each do
				5.times { |n| @list.append(Node.new(4*n)) }
				@list.remove_at(0)
			end

			it "#size should be 4" do
				expect(@list.size).to eq 4
			end

			it "#head should point to second node of original list" do
				expect(@list.head.value).to eq 4
			end

			it "results in correct string representing the list" do
				str = "( 4 ) -> ( 8 ) -> ( 12 ) -> ( 16 ) -> nil"
				expect(@list.to_s).to eq str
			end
		end

		context "applies to last element of a list with size > 1" do
			before :each do
				8.times { |n| @list.append(Node.new(6*n)) }
				@list.remove_at(7)
			end

			it "#size should be 7" do
				expect(@list.size).to eq 7
			end

			it "#tail should point to second-to-last node of original list" do
				expect(@list.tail.value).to eq 36
			end

			it "results in correct string representing the list" do
				str = "( 0 ) -> ( 6 ) -> ( 12 ) -> ( 18 ) -> ( 24 ) -> ( 30 ) -> ( 36 ) -> nil"
				expect(@list.to_s).to eq str
			end
		end

		context "applies to a middle element of a list with size > 1" do
			before :each do
				6.times { |n| @list.append(Node.new(9*n)) }
				@list.remove_at(3)
			end

			it "#size should be 5" do
				expect(@list.size).to eq 5
			end

			it "results in correct string representing the list" do
				str = "( 0 ) -> ( 9 ) -> ( 18 ) -> ( 36 ) -> ( 45 ) -> nil"
				expect(@list.to_s).to eq str
			end
		end
	end

	describe "#insert_at" do
		context "applies to a list containing a single node" do
			before :each do
				@list.insert_at(150)
			end

			it "#size should be 1" do
				expect(@list.size).to eq 1
			end

			it "#head should point to new node" do
				expect(@list.head.value).to eq 150
			end

			it "#tail should point to new node" do
				expect(@list.tail.value).to eq 150
			end
		end

		context "applies to a list containing more than one node, insert at head" do
			before :each do
				(1..5).each { |n| @list.append(Node.new(8*n + 2)) }
				@list.insert_at(100)
			end

			it "#size should be 6" do
				expect(@list.size).to eq 6
			end

			it "results in correct string representing the list" do
				str = "( 100 ) -> ( 10 ) -> ( 18 ) -> ( 26 ) -> ( 34 ) -> ( 42 ) -> nil"
				expect(@list.to_s).to eq str
			end
		end	

		context "applies to a list containing more than one node, insert at tail" do
			before :each do
				(1..5).each { |n| @list.append(Node.new(8*n + 2)) }
				@list.insert_at(100, 5)
			end

			it "#size should be 6" do
				expect(@list.size).to eq 6
			end

			it "results in correct string representing the list" do
				str = "( 10 ) -> ( 18 ) -> ( 26 ) -> ( 34 ) -> ( 42 ) -> ( 100 ) -> nil"
				expect(@list.to_s).to eq str
			end
		end	

		context "applies to a list containing more than one node, insert in middle" do
			before :each do
				(1..5).each { |n| @list.append(Node.new(8*n + 2)) }
				@list.insert_at(100, 2)
			end

			it "#size should be 6" do
				expect(@list.size).to eq 6
			end

			it "results in correct string representing the list" do
				str = "( 10 ) -> ( 18 ) -> ( 100 ) -> ( 26 ) -> ( 34 ) -> ( 42 ) -> nil"
				expect(@list.to_s).to eq str
			end
		end	

	end
end

