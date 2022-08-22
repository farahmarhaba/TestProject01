/// <summary>
/// Page FarahRewardsLevelList (ID 50903).
/// </summary>
page 50903 FarahRewardsLevelList
{
    PageType = List;
    ContextSensitiveHelpPage = 'sales-rewards';
    SourceTable = FarahRewardLevel;
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTableView = sorting(MinimumRewardPoints) order(ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Level; Level)
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the level of reward that the customer has at this point.';
                }

                field("Minimum Reward Points"; MinimumRewardPoints)
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the number of points that customers must have to reach this level.';
                }
            }
        }
    }


}