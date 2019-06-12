package org.sang;

public class Test {

    public static void main(String[] args) {

        // 外层循环
        tag:
        for (int i = 1; i <= 5; i++) {
            // 内层循环
            for (int j = 1; j <= 3; j++) {
                System.out.println("i的值为:" + i + " j的值为:" + j);
                if (j == 2) {
                    break tag;
                }
            }
        }

    }
}
