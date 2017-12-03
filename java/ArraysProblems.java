public class ArraysProblems {
	public void rotate(ArrayList<ArrayList<Integer>> a) {
	    int len = a.size();
	    int i = 0;
	    int r = 0; 
	    int c = len - 1 ;
	    int j = 0, k = 0;
        while ( i < len ) {
            j = i;
            ArrayList<Integer> row = a.get(i);
            while ( j < len ) {
                 ArrayList<Integer> col = a.get(j);
                 //swap
                 Integer temp = row.get(j);
                 row.set(j++, col.get(i));
                 col.set(i, temp);
            }
            i++;
        }
        
        for (i=0;i<len;i++) {
            ArrayList<Integer> row = a.get(i);
            j = 0;
            k = len - 1;
            while (j < k) {
                //swap
                Integer temp = row.get(j);
                row.set(j++, row.get(k));
                row.set(k--, temp);
            }
        }
	}

// Rotate matrix

public void rotate(ArrayList<ArrayList<Integer>> a) {
	    int len = a.size();
	    int i = 0;
	    int r = 0; 
	    int c = len - 1 ;
	    int j = 0, k = 0;
        while ( i < len ) {
            j = i;
            ArrayList<Integer> row = a.get(i);
            while ( j < len ) {
                 ArrayList<Integer> col = a.get(j);
                 //swap
                 Integer temp = row.get(j);
                 row.set(j++, col.get(i));
                 col.set(i, temp);
            }
            i++;
        }
        
        for (i=0;i<len;i++) {
            ArrayList<Integer> row = a.get(i);
            j = 0;
            k = len - 1;
            while (j < k) {
                //swap
                Integer temp = row.get(j);
                row.set(j++, row.get(k));
                row.set(k--, temp);
            }
        }
}

}

