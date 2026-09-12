using System;

class PrecisionTest
{
    static void Main()
    {
        double a = 0.1;
        double b = 0.2;
        double expected = 0.3;

        Console.WriteLine($"0.1 + 0.2 = {a + b:G17}");
        Console.WriteLine($"0.1 + 0.2 == 0.3 -> {a + b == expected}");
    }
}