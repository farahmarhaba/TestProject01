/// <summary>
/// Table FarahBook (ID 50901).
/// </summary>
table 50901 FarahBook
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

        }
        field(2; Title; Text[50])
        {
            DataClassification = ToBeClassified;

        }

        field(3; Author; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(4; Hardcover; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Page Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


}