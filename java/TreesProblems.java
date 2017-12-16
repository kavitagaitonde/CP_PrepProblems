
class TreeNode {
      int val;
      TreeNode left;
      TreeNode right;
      TreeNode(int x) { val = x; }
}
 
public class TreesProblems {

//Populate Next Right Pointers Tree

public void connect(TreeLinkNode root) {
        
        TreeLinkNode node1 = root;
        node1.next = null;
        
        while (node1 != null) {
            System.out.println ("node1 = "+node1.val);
            TreeLinkNode node2 = node1;
            while (node2 != null) {
                System.out.println ("node2 = "+node2.val);
                if (node2.left != null && node2.right != null) {
                    node2.left.next = node2.right;    
                }else if (node2.left != null) {
                    node2.left.next = findNextRightFor(node2);
                }else if (node2.right != null) {
                    node2.right.next = findNextRightFor(node2);
                }
                node2 = node2.next;
            }
            /*if (node1.left != null) {
                node1 = node1.left;
            }else if (node1.right != null) {
                node1 = node1.right;
            }else if () {*/
                node1 = findNextRightFor(node1);
            //}
        }
    }
    
    public TreeLinkNode findNextRightFor(TreeLinkNode node) {
        while (node != null) {
            if (node.left != null) {
                node = node.left;
                break;
            }else if (node.right != null) {
                node = node.right;
                break;
            }else{
                node = node.next;
            }
        }
        return node;
    }

//Flatten Binary Tree to Linked List
	public TreeNode flatten(TreeNode a) {
	    
	    if ( a == null) {
	        return a;
	    }
	    
	    TreeNode leftNode = flatten (a.left);
	    TreeNode rightNode = flatten (a.right);
	    if (leftNode != null) {
	        a.right = leftNode;
	        while (leftNode.right != null) {
	            leftNode = leftNode.right;
	        }
	        leftNode.right = rightNode;
	    }
	    
	    return a;
	}

//Find value from a sorted but rotated array

public int search(final List<Integer> a, int b) {
	    
	    if (a ==null || a.size()==0) {
	        return -1;
	    }
	    
	    int index = 0, lstart =0, lend = 0, rstart = 0, rend = 0; 
	    lstart = minValueIndex(a, 0, a.size()-1);
	    if (lstart > 0) {//rotated array
	        lend = a.size()-1;
	        rstart = index+1;
	        rend = lstart-1;
	    } else {// not rotated array
	        index = a.size()/2;
	        lend = index-1;
	        rstart = index +1 ;
	        rend = a.size()-1;
	    }
	    
	    if (a.get(index) == b) {
	        return index;
	    }
	    if (a.get(index) > b) {
	        return findValue(a, lstart, lend, b);
	    } else {
	        return findValue(a, rstart, rend, b);
	    }
	}
	
	public int findValue(final List<Integer> a, int start, int end, int b) {
	    if (start > end) {
	        return -1;
	    }
	    int mid = (start+end)/2;
	    if (a.get(mid) == b) {
	        return mid;
	    }
	    if (a.get(mid) > b)  {
	        return findValue(a, start, mid-1, b);   
	    } else {
	        return findValue(a, mid+1, end, b); 
	    }
    }
	 
	public int minValueIndex(final List<Integer> a, int start, int end) {
	    //not rotate
	    if (a.get(start) < a.get(end)) {
	        return start;
	    }
	    
	    //rotated
	    int mid = (end+start)/2;
	    
	    if (a.get(mid) > a.get(mid+1)) {
	        return mid+1;
	    }
	    if (a.get(mid-1) > a.get(mid)) {
	        return mid;
	    }
	    if (a.get(mid) < a.get(end)) { //min is on the left
	        return minValueIndex(a, start, mid-1);
	    } else {//min is on the right
	        return minValueIndex(a, mid+1, end);
	    }
	}

//Given a sorted array and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.
public int searchInsert(ArrayList<Integer> a, int b) {
	    if (a == null || a.size() == 0) {
	        return 0;
	    }
	    int index = findIndex(a, b, 0, a.size()-1);
	    return index;
	}
	
	public int findIndex(ArrayList<Integer> a, int b, int start, int end) {
	    if (start > end) {
	        //not found
	        return start;
	    }
	    
	    int mid = (start + end)/2;
	    if (a.get(mid) == b) {
	        return mid;
	    } else if (a.get(mid) < b) {
	        return findIndex(a, b, mid+1, end);
	    } else {
	        return findIndex(a, b, start, mid-1);
	    }
	}
}

