using System;
using System.Text;

class Converter
{
    // Функція-конвертер цілого числа в систему з основою 2-16
    public static string ConvertInt(int n, int targetBase)
    {
        if (n == 0) return "0";
        string digits = "0123456789ABCDEF";
        StringBuilder result = new StringBuilder();
        
        while (n > 0)
        {
            result.Insert(0, digits[n % targetBase]);
            n /= targetBase;
        }
        return result.ToString();
    }

    // Функція для дробової частини
    public static string ConvertFrac(double f, int precision = 6)
    {
        StringBuilder result = new StringBuilder("0.");
        double curr = f;
        
        for (int i = 0; i < precision; i++)
        {
            curr *= 2;
            int bit = (int)curr;
            result.Append(bit);
            curr -= bit;
        }
        return result.ToString();
    }

    static void Main()
    {
        int N = 123;
        double F = 0.15;

        Console.WriteLine($"123 у двійковій: {ConvertInt(N, 2)}");
        Console.WriteLine($"123 у вісімковій: {ConvertInt(N, 8)}");
        Console.WriteLine($"123 у 16-ричній: {ConvertInt(N, 16)}");
        Console.WriteLine($"0.15 у двійковій (6 знаків): {ConvertFrac(F, 6)}");
    }
}