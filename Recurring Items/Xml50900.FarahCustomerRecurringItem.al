xmlport 50900 "Farah Customer Recurring Item"
{
    Caption = 'Farah Customer Recurring Item';
    Direction = Export;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(FarahCustomerRecurringItems; FarahCustomerRecurringItems)
            {
                fieldelement(CustomerNo; FarahCustomerRecurringItems."Customer No.") { }
                fieldelement(ItemNo; FarahCustomerRecurringItems."Item No.") { }
                fieldelement(Description; FarahCustomerRecurringItems.Description) { }
                fieldelement(Quantity; FarahCustomerRecurringItems.Quantity) { }
                fieldelement(UnitofMeasureCode; FarahCustomerRecurringItems."Unit of Measure Code") { }


            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
