/// <summary>
/// Codeunit Customer Rewards Ext. Mgt. (ID 50900).
/// </summary>
codeunit 50900 "Farah Cust Rewards Ext. Mgt."
{
    EventSubscriberInstance = StaticAutomatic;
 // Determines if the extension is activated 
    /// <summary>
    /// IsCustomerRewardsActivated.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsCustomerRewardsActivated(): Boolean;
    var
        ActivationCodeInfo: Record FarahActivationCodeInformation;
    begin
        if not ActivationCodeInfo.FindFirst then
            exit(false);

        if (ActivationCodeInfo."Date Activated" <= Today) and (Today <= ActivationCodeInfo."Expiration Date") then
            exit(true);
        exit(false);
    end;

    // Opens the Customer Rewards Assisted Setup Guide 
    /// <summary>
    /// OpenCustomerRewardsWizard.
    /// </summary>
    procedure OpenCustomerRewardsWizard();
    var
        CustomerRewardsWizard: Page "Farah Customer Rewards Wizard";
    begin
        CustomerRewardsWizard.RunModal;
    end;

    // Opens the Reward Level page 
    /// <summary>
    /// OpenRewardsLevelPage.
    /// </summary>
    procedure OpenRewardsLevelPage();
    var
        RewardsLevelPage: Page FarahRewardsLevelList;
    begin
        RewardsLevelPage.Run;
    end;

    // Determines the corresponding reward level and returns it 
    /// <summary>
    /// GetRewardLevel.
    /// </summary>
    /// <param name="RewardPoints">Integer.</param>
    /// <returns>Return variable RewardLevelTxt of type Text.</returns>
    procedure GetRewardLevel(RewardPoints: Integer) RewardLevelTxt: Text;
    var
        RewardLevelRec: Record FarahRewardLevel;
        MinRewardLevelPoints: Integer;
    begin
        RewardLevelTxt := NoRewardlevelTxt;

        if RewardLevelRec.IsEmpty then
            exit;
        RewardLevelRec.SetRange(MinimumRewardPoints, 0, RewardPoints);
        RewardLevelRec.SetCurrentKey(MinimumRewardPoints); // sorted in ascending order 

        if not RewardLevelRec.FindFirst then
            exit;
        MinRewardLevelPoints := RewardLevelRec.MinimumRewardPoints;

        if RewardPoints >= MinRewardLevelPoints then begin
            RewardLevelRec.Reset;
            RewardLevelRec.SetRange(MinimumRewardPoints, MinRewardLevelPoints, RewardPoints);
            RewardLevelRec.SetCurrentKey(MinimumRewardPoints); // sorted in ascending order 
            RewardLevelRec.FindLast;
            RewardLevelTxt := RewardLevelRec.Level;
        end;
    end;

    // Activates Customer Rewards if activation code is validated successfully  
    /// <summary>
    /// ActivateCustomerRewards.
    /// </summary>
    /// <param name="ActivationCode">Text.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure ActivateCustomerRewards(ActivationCode: Text): Boolean;
    var
        ActivationCodeInfo: Record FarahActivationCodeInformation;
    begin
        // raise event 
        OnGetActivationCodeStatusFromServer(ActivationCode);
        exit(ActivationCodeInfo.Get(ActivationCode));
    end;

    // publishes event 
    /// <summary>
    /// OnGetActivationCodeStatusFromServer.
    /// </summary>
    /// <param name="ActivationCode">Text.</param>
    [IntegrationEvent(false, false)]
    procedure OnGetActivationCodeStatusFromServer(ActivationCode: Text);
    begin
    end;

    // Subscribes to OnGetActivationCodeStatusFromServer event and handles it when the event is raised 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Farah Cust Rewards Ext. Mgt.", 'OnGetActivationCodeStatusFromServer', '', false, false)]
    local procedure OnGetActivationCodeStatusFromServerSubscriber(ActivationCode: Text);
    var
        ActivationCodeInfo: Record FarahActivationCodeInformation;
        ResponseText: Text;
        Result: JsonToken;
        JsonRepsonse: JsonToken;
    begin
        if not CanHandle then
            exit; // use the mock 

        // Get response from external service and update activation code information if successful 
        if (GetHttpResponse(ActivationCode, ResponseText)) then begin
            JsonRepsonse.ReadFrom(ResponseText);

            if (JsonRepsonse.SelectToken('ActivationResponse', Result)) then begin

                if (Result.AsValue().AsText() = 'Success') then begin

                    if (ActivationCodeInfo.FindFirst()) then
                        ActivationCodeInfo.Delete;

                    ActivationCodeInfo.Init;
                    ActivationCodeInfo.ActivationCode := ActivationCode;
                    ActivationCodeInfo."Date Activated" := Today;
                    ActivationCodeInfo."Expiration Date" := CALCDATE('<1Y>', Today);
                    ActivationCodeInfo.Insert;

                end;
            end;
        end;
    end;

    // Helper method to make calls to a service to validate activation code 
    local procedure GetHttpResponse(ActivationCode: Text; var ResponseText: Text): Boolean;
    begin
        // You will typically make external calls / http requests to your service to validate the activation code 
        // here but for the sample extension we simply return a successful dummy response 
        if ActivationCode = '' then
            exit(false);

        ResponseText := DummySuccessResponseTxt;
        exit(true);
    end;

    // Subscribes to the OnAfterReleaseSalesDoc event and increases reward points for the sell to customer in posted sales order 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure OnAfterReleaseSalesDocSubscriber(VAR SalesHeader: Record "Sales Header"; PreviewMode: Boolean; LinesWereModified: Boolean);
    var
        Customer: Record Customer;
    begin
        if SalesHeader.Status <> SalesHeader.Status::Released then
            exit;

        Customer.Get(SalesHeader."Sell-to Customer No.");
        Customer.RewardPoints += 1; // Add a point for each new sales order 
        Customer.Modify;
    end;

    // Checks if the current codeunit is allowed to handle Customer Rewards Activation requests rather than a mock. 
    local procedure CanHandle(): Boolean;
    var
        CustomerRewardsExtMgtSetup: Record FarahCustomerRewardsMgtSetup;
    begin
        if CustomerRewardsExtMgtSetup.Get then
            exit(CustomerRewardsExtMgtSetup."Cust. Rew. Ext. Mgt. Cod. ID" = CODEUNIT::"Farah Cust Rewards Ext. Mgt.");
        exit(false);
    end;

    var
        DummySuccessResponseTxt: Label '{"ActivationResponse": "Success"}', Locked = true;
        NoRewardlevelTxt: TextConst ENU = 'NONE';
}