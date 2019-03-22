using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BackEnd.BLL
{
    public class BusinessRuleException : Exception
    {
        public readonly ICollection<Exception> Errors = new List<Exception>();
        public readonly Text ExecutionContext;

        public BusinessRuleException(Text context)
        {
            // ?? is the Null Coallation Operator
            ExecutionContext = context ?? "No context supplied";
        }

        public override string ToString()
        {
            string message = "Business rule violation for the following: ";
            var errorMessages = Errors.Select(x => x.Message).ToList();
            message += $"{string.Join(", ", errorMessages)}";
            return message;
        }
    }

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
