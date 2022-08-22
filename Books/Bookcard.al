/// <summary>
/// Page MyPage (ID 50901).
/// </summary>
page 50901 FarahBookCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = FarahBook;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(title; title)
                {
                    ApplicationArea = All;
                }

            }
            group(Details)
            {
                Caption = 'Details';
                field(Author; Author)
                {
                    ApplicationArea = All;
                }
                field(Hardcover; Hardcover)
                {
                    ApplicationArea = All;
                }
                field("Page Count"; "Page Count")
                {
                    ApplicationArea = All;
                }

            }
        }
    }


}