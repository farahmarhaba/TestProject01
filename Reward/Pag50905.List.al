/// <summary>
/// Page List (ID 50905).
/// </summary>
page 50905 "FarahActivationCodeInformation"
{
    ApplicationArea = All;
    Caption = 'List';
    PageType = List;
    SourceTable = FarahActivationCodeInformation;
    UsageCategory = Administration;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("ActivationCode"; ActivationCode){
                ApplicationArea = All;}
                 field("Date Activated"; "Date Activated")
        {
         ApplicationArea=All;
        }

        field("Expiration Date"; "Expiration Date")
        {
           ApplicationArea=All;
        }
            }

        }
    }
}
