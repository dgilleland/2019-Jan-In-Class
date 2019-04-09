using System;

namespace AdHocSchool.BLL
{
    public class Text
    {
        public readonly string Message;
        private Text(string message)
        {
            Message = message ?? throw new ArgumentNullException("Should Never Happen");
        }
        public static implicit operator Text(string message)
        {
            if (!string.IsNullOrWhiteSpace(message))
                return new Text(message.Trim()); // Good example of trimming
            else
                return null;
        }
    }
}
