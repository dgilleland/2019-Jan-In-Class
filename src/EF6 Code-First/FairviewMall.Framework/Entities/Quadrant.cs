using System;

namespace FairviewMall.Framework.Entities
{
    [Flags]
    public enum Quadrant
    {
        NorthWest = 1,
        NorthEast = 2,
        SouthEast = 4,
        SouthWest = 8
    }
}
