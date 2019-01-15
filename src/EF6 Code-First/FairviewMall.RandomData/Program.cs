using Bogus;
using FairviewMall.Framework.DAL;
using FairviewMall.Framework.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FairviewMall.RandomData
{
    class Program
    {
        static void Main(string[] args)
        {
            var data = GenerateRentalAggreements();
            foreach(var item in data)
            {
                Console.WriteLine($"{item.CompanyName}\t{item.Website}");
            }

            LoadDatabase(data);
        }

        private static void LoadDatabase(List<Rental> data)
        {
            using (var context = new MallContext())
            {
                int count = context.Rentals.Count();
                Console.WriteLine($"Starting with {count} Rentals.");
            }
        }

        private static List<Rental> GenerateRentalAggreements()
        {
            var fakeRentals = new Faker<Rental>()
                .RuleFor(r => r.CompanyName, (f, r) => f.Company.CompanyName())
                .RuleFor(r => r.PhoneNumber, (f, r) => f.Phone.PhoneNumber("###.###.####"))
                .RuleFor(r => r.ContactName, (f, r) => f.Name.FullName())
                .RuleFor(r => r.RentalTerm, (f, r) => f.Random.Number(6, 19))
                .RuleFor(r => r.StartingDate, (f, r) => f.Date.Between(DateTime.Today.AddMonths(-36), DateTime.Today.AddMonths(-5)))
                .RuleFor(r => r.Website, (f, r) => f.Internet.Url());

            var data = fakeRentals.Generate(18);
            return data;
        }
    }
}
