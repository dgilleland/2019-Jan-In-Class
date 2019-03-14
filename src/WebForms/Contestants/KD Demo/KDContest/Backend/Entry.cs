using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KDContest.Backend
{
    public class Entry
    {
        public string EntryCode { get; set; }
        public string Email { get; set; }

        // Greedy constructor
        public Entry(string code, string email)
        {
            EntryCode = code;
            Email = email;
        }
    }

    public class Entrant
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string City { get; set; }
        public string Province { get; set; }
        public string PostalCode { get; set; }
        public int Age { get; set; }

        public Entrant(string firstName, string lastName, string email, string city, string prov, string postalCode, int age)
        {
            FirstName = firstName;
            LastName = lastName;
            Email = email;
            City = city;
            Province = prov;
            PostalCode = postalCode;
            Age = age;
        }
    }
}