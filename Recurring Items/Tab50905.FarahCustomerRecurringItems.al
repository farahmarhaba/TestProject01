/// <summary>
/// Table FarahCustomerRecurringItems (ID 50905).
/// </summary>
table 50905 FarahCustomerRecurringItems
{
    Caption = 'FarahCustomerRecurringItems';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }

        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";

            trigger OnValidate()
            var
            Item: Record Item;

            begin
                    if(Item.Get(rec."Item No.")) then begin
                rec."Unit of Measure Code" := Item."Sales Unit of Measure";
                rec.Description := Item.Description;
                    end;
            end;

        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Unit of Measure Code"; Code[20])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Unit of Measure".Code where ("Item No." = field("Item No."));
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Customer No.", "Item No.")
        {
            Clustered = true;
        }
    }

}
