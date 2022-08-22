/// <summary>
/// TableExtension CustomerTableExt. (ID 50900) extends Record Customer.
/// </summary>
tableextension 50900 "CustomerTableExt." extends Customer
{
    fields
    {
        field(50900; RewardPoints; Integer)
        {
            Caption = 'RewardPoints';
            DataClassification = CustomerContent;
            MinValue=0;
        }
    }
}
