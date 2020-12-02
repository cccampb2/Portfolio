from random import randint as mr


class Node:
    def __init__(self,data):
        self.data = data
        self.next = None
        self.prev = None



class DoublyLinkedList:

    def __init__(self):
        self.head = self.tail = None
        self.__length = 0

    def reverseLinkedList(self):
        prev = None
        curr = self.head

        while(curr is not None):
            next = curr.next
            curr.next = prev
            prev = curr
            curr = next
        self.head = prev

    def displayFromHead(self):
        current = self.head
        while current:
            print(current.data, end=" ")
            current = current.next
        print()

    def displayFromTail(self):
        current = self.tail
        while current:
            print(current.data, end=" ")
            current = current.prev

        print()

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
    
    def getLength(self):
        return self.__length     

    def inserionSort(self):
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
   
    myDoublyLinkedList.insertDataAtEnd(i)
   





 

myDoublyLinkedList.displayFromHead()
myDoublyLinkedList.reverseLinkedList()
myDoublyLinkedList.displayFromHead()


#myDoublyLinkedList.displayFromTail()