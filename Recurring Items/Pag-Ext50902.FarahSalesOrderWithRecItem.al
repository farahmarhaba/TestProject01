/// <summary>
/// PageExtension FarahSalesOrderWithRecItem (ID 50902) extends Record Sales Order.
/// </summary>
pageextension 50902 FarahSalesOrderWithRecItem extends "Sales Order"
{
    actions
    {

        addafter(CalculateInvoiceDiscount)
        {

            action("Insert Recurring Items")
            {
                CAption = 'Farah Insert Recurring Items';
                ApplicationArea = All;
                image = Action;

                trigger OnAction()
                var
                    Counter: Integer;
                    CustomerRecurringItems: Record FarahCustomerRecurringItems;
                    SalesLine: Record "Sales Line";
                    NewSaleLine : Record "Sales Line";
                    
                   LastLineNo : Integer;
                begin
                   //Counter := 0;
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                     SalesLine.SetRange("Document No.", Rec."No.");
                     if SalesLine.FindLast() then
                     LastLineNo :=SalesLine."Line No."; //we can use getrangemax
                    CustomerRecurringItems.SetRange("Customer No.", Rec."Sell-to Customer No.");
                    if (CustomerRecurringItems.FindSet()) then
                      repeat
                      LastLineNo := lastlineNo + 10000;
                      salesline.Init();
                    NewSaleLine."Document No.":= Rec."No.";
                    NewSaleLine."Document Type" := Rec."Document Type";
                    SalesLine."Line No." := LastLineNo;
                    SalesLine.Insert(true);
                    SalesLine.Validate(Type,SalesLine.type::Item);
                    SalesLine.Validate("No.",CustomerRecurringItems."Item No.");
                    salesLine.Validate(Description,CustomerRecurringItems.Description);
                    salesline.Validate(Quantity,CustomerRecurringItems.Quantity);
                    SalesLine.Validate("Unit of Measure Code",CustomerRecurringItems."Unit of Measure Code");
                    SalesLine.Modify(true);
                        until CustomerRecurringItems.Next = 0; 
                end;


            }


        }
    }
    local procedure InsertSalesLine(var LastLineNo: Integer; CustomerReccuringItems : Record "FarahCustomerRecurringItems")
    var 
    SalesLine : Record "Sales Line";
    begin
      //  LastLineNo
    end;
}

