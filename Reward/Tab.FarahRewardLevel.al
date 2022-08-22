/// <summary>
/// Table Farah Reward Level (ID 50902).
/// </summary>
table 50902 FarahRewardLevel
{
    Caption = 'Farah Reward Level';
    TableType = Normal;
    DataClassification = CustomerContent;

    fields
    {
        field(1; Level; Text[20])
        {
            Caption = 'Level';
            DataClassification = CustomerContent;
        }

        field(2; MinimumRewardPoints; Integer)
        {
            Caption = 'Minimum Reward Points';
            DataClassification = CustomerContent;
            MinValue = 0;
            NotBlank = true;

            trigger OnValidate();
            var
                tempPoints: Integer;
                RewardLevel: Record FarahRewardLevel;
            begin
                tempPoints := MinimumRewardPoints;
                RewardLevel.SetRange(MinimumRewardPoints, tempPoints);
                if RewardLevel.FindFirst then
                    Error('Minimum Reward Points must be unique');
            end;
        }
    }

    keys
    {
        key(PK; Level)
        {
            Clustered = true;
        }
        key(MinimumRewardPoints; MinimumRewardPoints) { }
    }

    trigger OnInsert();
    begin

        Validate(MinimumRewardPoints);
    end;

    trigger OnModify();
    begin
        Validate(MinimumRewardPoints);
    end;
}