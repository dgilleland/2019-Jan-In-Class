namespace WestWindSystem.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BuildVersion")]
    internal partial class BuildVersion
    {
        public int Id { get; set; }

        public int Major { get; set; }

        public int Minor { get; set; }

        public int Build { get; set; }

        public DateTime ReleaseDate { get; set; }
    }
}
