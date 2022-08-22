/// <summary>
/// PageExtension Farah Cust. Card With Rec Item (ID 50901) extends Record Customer Card.
/// </summary>
pageextension 50901 "Farah Cust. Card With Rec Item" extends "Customer Card"
{
    actions
    {

        addafter("Item References")
        {

            action("Farah Customer Preferred Items")
            {   
                CAption = 'Farah Customer Preferrd Items';
                ApplicationArea = All;
                image = Action;
                RunObject = Page "FarahCustomerRecurringItemsPag";
                RunPageLink = "Customer No." = field("No.");
              

            }

        }
    }
}
