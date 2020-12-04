from random import randint as mr

#Node Class with head and tail pointers
class Node:
    def __init__(self,data):
        self.data = data
        self.next = None
        self.prev = None


#Linked List Class
class DoublyLinkedList:
    #Initialize Linked List
    def __init__(self):
        self.head = self.tail = None
        self.__length = 0

    #Print Linked List from the head node
    def displayFromHead(self):
        current = self.head
        while current:
            print(current.data, end=" ")
            current = current.next
        print()


    #Print Linked List from the tail node
    def displayFromTail(self):
        current = self.tail
        while current:
            print(current.data, end=" ")
            current = current.prev

        print()

    #Insert a node at the End of the Linked List
    def insertDataAtEnd(self,data):
        newNode = Node(data)
        if self.head == None:
            self.head = newNode
            self.tail = newNode
            
        else:
            self.tail.next = newNode
            newNode.prev = self.tail
            self.tail = newNode
        self.__length += 1
    #Returns length of Linked List
    def getLength(self):
        return self.__length  

       
    #Sorts Linked List in ascending order
    def insertionSort(self):
        for i in range(1,self.__length):
            
            key = self.getNodeAtPos(i)

            j = i - 1

            while j >= 0 and key.data < self.getNodeAtPos(j).data:
                j -= 1

            placeToBeInserted = self.getNodeAtPos(j+1)
            placeToBeInsertedPrev = placeToBeInserted.prev


            if j+1 != i:

                if key == self.tail:
                    key.prev.next = None
                    self.tail = key.prev

                    key.prev = None
                    key.next = None
                elif  key == self.head:
                    self.head = key.next
                    key.next.prev = None


                    

                else:
                    key.prev.next = key.next
                    key.next.prev = key.prev
                    

                
                if placeToBeInserted == self.head:
                    key.next = placeToBeInserted
                    placeToBeInserted.prev = key
                    self.head = key
                
                elif placeToBeInserted == self.tail:
                    placeToBeInserted.next = key
                    key.prev = placeToBeInserted
                    self.tail = key
                    break


                else:
                    
                    placeToBeInsertedPrev.next = key
                    key.prev = placeToBeInsertedPrev

                    placeToBeInserted.prev = key
                    key.next = placeToBeInserted
    #Return Node at a certain position
    def getNodeAtPos(self,pos):
        current = self.head
        track = 0
        while current.next:
            if track == pos:
                break
            current = current.next
            track += 1
            
            
        return current


myDoublyLinkedList = DoublyLinkedList()

for i in range(10):
   
    myDoublyLinkedList.insertDataAtEnd(10-i)
   


myDoublyLinkedList.displayFromHead()
myDoublyLinkedList.insertionSort()
myDoublyLinkedList.displayFromHead()