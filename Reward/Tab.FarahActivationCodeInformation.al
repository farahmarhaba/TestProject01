/// <summary>
/// Table Activation Code Information (ID 50902).
/// </summary>
table 50903 FarahActivationCodeInformation
{
    Caption = 'Activation Code Information';
    DataClassification = SystemMetadata;
    fields
    {
        field(1; ActivationCode; Text[14])
        {
            Caption = 'Activation Code';
            DataClassification = SystemMetadata;
            Description = 'Activation code used to activate Customer Rewards';
        }

        field(2; "Date Activated"; Date)
        {
            Caption = 'Date Activated';
            DataClassification = SystemMetadata;
            Description = 'Date Customer Rewards was activated';
        }

        field(3; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = SystemMetadata;
            Description = 'Date Customer Rewards activation expires';
        }
    }

    keys
    {
        key(PK; ActivationCode)
        {
            Clustered = true;
        }
    }
}