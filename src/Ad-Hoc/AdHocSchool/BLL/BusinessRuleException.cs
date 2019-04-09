using System;
using System.Collections.Generic;
using System.Linq;

namespace AdHocSchool.BLL
{
    public class BusinessRuleException : Exception
    {
        public readonly ICollection<Exception> Errors;
        public readonly Text ExecutionContext;

        public BusinessRuleException(Text context) : this(context, new List<Exception>())
        { }

        public BusinessRuleException(Text context, ICollection<Exception> errors)
        {
            ExecutionContext = context ?? "No context supplied";
            Errors = errors ?? new List<Exception>();
        }

        public override string ToString()
        {
            string message = "Business rule violation for the following: ";
            var errorMessages = Errors.Select(x => x.Message).ToList();
            message += $"{string.Join(", ", errorMessages)}";
            return message;
        }
    }
}
