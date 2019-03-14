namespace BackEnd.DataModels.School
{
    internal class Assignment
    {
        public int AssignmentID { get; set; }
        public string Name { get; set; }
        public int WeightedValue { get; set; }
        public int? TotalPossibleMarks { get; set; }

        public override string ToString()
        {
            return $"{Name} ({WeightedValue} %)";
        }
    }
}
