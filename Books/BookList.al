/// <summary>
/// Page FarahBookList (ID 50902).
/// </summary>
page 50902 FarahBookList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FarahBook;
    CardPageId = FarahBookCard;
    editable = false;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field(Title; Title)
                {
                    ApplicationArea = All;
                }
                field(Author; Author)
                {
                    ApplicationArea = All;
                }
            }
        }

    }


}