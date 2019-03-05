using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp.FormSamples.Classes
{
    public class BankAccount
    {
        public string AccountHolder { get; set; }
        public long AccountNumber { get; set; }
        public decimal OpeningBalance { get; set; }
        public decimal? OverdraftLimit { get; set; }
        public string AccountType { get; set; }
    }
}