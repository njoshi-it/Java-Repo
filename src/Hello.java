// src/Main.java

import java.util.ArrayList;
import java.util.Scanner;

public class Hello {
    public static void main(String[] args) {
        ArrayList<Student> students = new ArrayList<>();
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("\n--- Student Manager ---");
            System.out.println("1. Add Student");
            System.out.println("2. View Students");
            System.out.println("3. Exit");
            System.out.print("Choose option: ");

            int choice = scanner.nextInt();
            scanner.nextLine(); // consume newline

            switch (choice) {
                case 1 -> {
                    System.out.print("Enter student name: ");
                    String name = scanner.nextLine();
                    System.out.print("Enter student age: ");
                    int age = scanner.nextInt();
                    scanner.nextLine(); // consume newline
                    students.add(new Student(name, age));
                    System.out.println("Student added!");
                }
                case 2 -> {
                    if (students.isEmpty()) {
                        System.out.println("No students found.");
                    } else {
                        System.out.println("List of Students:");
                        for (Student s : students) {
                            s.displayInfo();
                        }
                    }
                }
                case 3 -> {
                    System.out.println("Exiting...");
                    return;
                }
                default -> System.out.println("Invalid choice!");
            }
        }
    }
}
