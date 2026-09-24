
import java.util.*;

public class Booths {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int M = sc.nextInt();
        int Q = sc.nextInt();
        int Q1 = 0;
        int A = 0;
        int count = Integer.SIZE;

        while (count > 0) {
            int qLast = Q & 1;
            if (qLast == 1 && Q1 == 0) {
                A = A - M;
            } else if (qLast == 0 && Q1 == 1) {
                A = A + M;
            }

            // [A, Q, Q1]
            Q1 = Q & 1;
            Q = (Q >>> 1) | ((A & 1) << 31);
            A = A >> 1;
            count--;
        }
        long result = ((long) A << 32) | (Q & 0xFFFFFFFFL);
        System.out.println(result);
        sc.close();
    }
}
