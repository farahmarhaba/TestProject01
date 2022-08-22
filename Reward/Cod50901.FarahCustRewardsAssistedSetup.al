/// <summary>
/// Codeunit FarahCust.RewardsAssistedSetup (ID 50901).
/// </summary>
codeunit 50901 "FarahCust.RewardsAssistedSetup"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assisted Setup", 'OnRegister', '', false, false)]
    local procedure AddExtensionAssistedSetup_OnRegisterAssistedSetup();
    var
        AssistedSetup: Codeunit "Assisted Setup";
        CurrentGlobalLanguage: Integer;
        myAppInfo: ModuleInfo;
        WizardTxt: Label 'Customer Rewards assisted setup guide';
    begin
        NavApp.GetCurrentModuleInfo(myAppInfo);
        CurrentGlobalLanguage := GlobalLanguage();
        AssistedSetup.Add(myAppInfo.Id, Page::"Farah Customer Rewards Wizard", WizardTxt, "Assisted Setup Group"::Extensions);
        GLOBALLANGUAGE(1033);
        AssistedSetup.AddTranslation(Page::"Farah Customer Rewards Wizard", 1033, WizardTxt);
    end;
    
}
