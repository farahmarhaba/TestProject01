/// <summary>
/// Page FarahCustomerRecurringItemsPag (ID 50906).
/// </summary>
page 50906 FarahCustomerRecurringItemsPag
{
    Caption = 'FarahCustomerRecurringItemsPag';
    PageType = List;
    SourceTable = FarahCustomerRecurringItems;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(FarahImport)
            {
                Caption = 'Farah Import from Excel';
                ApplicationArea = all;
                Image = Import;
                InFooterBar = true;

                trigger OnAction()
                var
                    X: Codeunit "Excel Tools";
                    Buffer: Record "Excel Buffer" temporary;
                    Ins: InStream;
                    Filename: Text;
                    Row: Integer;
                    FirstRow: Integer;
                    LastRow: Integer;
                    FirstColumn: Integer;
                    LastColumn: Integer;
                    Data: REcord FarahCustomerRecurringItems;
                  
                begin
                    Data.DeleteAll();
                    if (UploadIntoStream('Import Excel File', '', '', Filename, Ins)) then begin
                        Buffer.OpenBookStream(Ins, 'Sheet1');
                        Buffer.ReadSheet();
                        Buffer.FindFirst();
                        FirstRow := Buffer."Row No.";
                        FirstColumn := Buffer."Column No.";
                        Buffer.FindLast();
                        LastRow := Buffer."Row No.";
                        LastColumn := Buffer."Column No.";
                        Buffer.Reset();

                        for Row := FirstRow to LastRow do begin
                            Rec.Init();
                            Rec."Customer No." := X.GetCustomerNo(Buffer, FirstColumn, Row);
                            Rec."Item No." := X.GetItemNo(Buffer, FirstColumn + 1, Row);
                            Rec.Description := X.GetDescription(Buffer, FirstColumn + 2, Row);
                            Rec."Unit of Measure Code" := X.GetUnitofMeasureCode(Buffer, FirstColumn + 3, Row);
                            Rec.Quantity := X.GetQuantity(Buffer, FirstColumn + 4, Row);
                            Rec.Insert();

                        end;
                    end;


                end;


            }
            action(FarahExport)
            {
                Caption = 'Farah Export to Excel';
                ApplicationArea = all;
                Image = Export;
                //Promoted = true;
                //PromotedCategory = process;


                trigger OnAction()
                var
                    X: Codeunit "Excel Tools";
                    RecurringItems: Record FarahCustomerRecurringItems;
                begin
                    x.ExportRcurringItems(RecurringItems);
                end;

            }
            action(FarahRefreshFromItemCard)
            {
                Caption = 'Farah Refresh from Item Card';
                ApplicationArea = all;
                Image = Refresh;
                // InFooterBar = true;

                trigger OnAction()
                var
                    Item: Record Item;
                    recurringItems: Record FarahCustomerRecurringItems;
                begin
                    recurringItems.init();
                    recurringItems.SetRange("Customer No.", rec."Customer No.");
                    if (recurringItems.FindSet()) then
                        repeat
                            // Message(recurringItems."Customer No.");
                            //Message(recurringItems."Item No.");
                          //  Item.setRange("No.", recurringItems."Item No.");
                            if (Item.Get(recurringItems."Item No.")) then
                            begin
                                recurringItems.Description := Item.Description;
                                //Message(Item.Description);
                            end;
                            recurringItems.Modify(true);
                        until recurringItems.Next() = 0;
                end;


            }

        }

    }
}

