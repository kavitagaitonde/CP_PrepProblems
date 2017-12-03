public class StringsProblems {

	// Palindrome String
	public int isPalindrome(String a) {
	    int start = 0;
	    int end = a.length() -1;
	    a = a.toLowerCase();
	    int ret = 1;
	    while (start <= end) {
	        if (!Character.isLetterOrDigit(a.charAt(start))) {
	            start++;
	            continue;
	        }
	        if (!Character.isLetterOrDigit(a.charAt(end))) {
	            end--;
	            continue;
	        }
	        if (a.charAt(start) != a.charAt(end)) {
	            ret = 0;
	            break;
	        }
	        start++;
	        end--;
	    }
	    return ret;
	}

	// Reverse the string word by word.
	public String reverseWords(String a) {
	    int i = 0;
	    int start = 0;
	    StringBuffer sBuf = new StringBuffer();
	    String reverseA = reverseString(a);
	    //System.out.println("reversed :"+reverseA);
	    while (i<reverseA.length()) {
	        while(i<reverseA.length() && reverseA.charAt(i) != ' ') {
	            i++;
	        }
	        
	        //System.out.println("start :"+start);
	        //System.out.println("ii :"+i);
	        String x = reverseA.substring(start, i);
            //System.out.println("x :"+x);
	        String b = reverseString(x);
	        //System.out.println("b :"+b);
	        sBuf.append(b);
	        start = i+1;
	        if(i != reverseA.length()) {
	            sBuf.append(' ');
	            i++;
	        }
	        //System.out.println("buf :"+sBuf);
	        //System.out.println("i :"+i);
	    }
	    return sBuf.toString();
	}
	
	public String reverseString(String a) {
	    StringBuffer sBuf = new StringBuffer();
	    for(int i=a.length()-1;i>=0;i--) {
	        sBuf.append(a.charAt(i));
	    }
	    return sBuf.toString();
	}

	//Length of last word
	public int lengthOfLastWord(final String a) {
	    int len = 0, lastLen = 0;
	    for(int i=0;i<a.length();i++) {
	        if (a.charAt(i) != ' ') {
	            len++;
	        } else if(len != 0) {
	            lastLen = len;
	            len = 0;
	        }
	    }
	    if (len > 0) {
	        lastLen = len;
	    }
	    return lastLen;
	}
}

