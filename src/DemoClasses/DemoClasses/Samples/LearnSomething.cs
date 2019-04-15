namespace DemoClasses.Samples
{
    public class LearnSomething
    {
        private int _SomeNumber = 5;
        public int SomeNumber
        {
            get { return _SomeNumber; }
            set
            {
                if (value < 0)
                    _SomeNumber = 0;
                else
                    _SomeNumber = value;
            }
        }

        public string AMessage { get; private set; }

        public LearnSomething() // Parameterless Constructor
        {
        }

        public LearnSomething(string message)
        {
            AMessage = message;
        }

        public LearnSomething(string message, int number)
        {
            AMessage = message;
            SomeNumber = number;
        }
    }
}
