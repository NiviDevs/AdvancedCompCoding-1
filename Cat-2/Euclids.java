
import java.util.*;

public class Euclids {

    public static int GCD(int a, int b) {
        if (b == 0) {
            return a;
        }
        return GCD(b, a % b);
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int a = sc.nextInt();
        int b = sc.nextInt();
        int result = GCD(a, b);
        System.out.println(result);

        sc.close();

    }
}
