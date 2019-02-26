using Bogus;

namespace BackEnd.DataModels.School
{
    internal class Student
    {
        public int StudentID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }
    internal class StudentFaker : Faker<Student>
    {
        static StudentFaker()
        {
            Faker.GlobalUniqueIndex = 20151000;
        }
        public StudentFaker()
        {
            RuleFor(x => x.FirstName, f => f.Name.FirstName());
            RuleFor(x => x.LastName, f => f.Name.LastName());
            RuleFor(x => x.StudentID, f => f.IndexGlobal);
        }
    }
}
