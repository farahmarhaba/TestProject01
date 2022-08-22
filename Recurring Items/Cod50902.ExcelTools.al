/// <summary>
/// Codeunit Excel Tools (ID 50902).
/// </summary>
codeunit 50902 "Excel Tools"
{
    /// <summary>
    /// GetCustomerNo.
    /// </summary>
    /// <param name="Buffer">Temporary VAR Record "Excel Buffer".</param>
    /// <param name="Col">Integer.</param>
    /// <param name="Row">Integer.</param>
    /// <returns>Return value of type Code[20].</returns>
    procedure GetCustomerNo(var Buffer: Record "Excel Buffer" temporary; Col: Integer; Row: Integer): Code[20]
    begin
        if (Buffer.Get(Row, Col)) then
            exit(Buffer."Cell Value as Text");
    end;

    /// <summary>
    /// GetItemNo.
    /// </summary>
    /// <param name="Buffer">Temporary VAR Record "Excel Buffer".</param>
    /// <param name="Col">Integer.</param>
    /// <param name="Row">Integer.</param>
    /// <returns>Return value of type Code[20].</returns>
    procedure GetItemNo(var Buffer: Record "Excel Buffer" temporary; Col: Integer; Row: Integer): Code[20]
    begin
        if (Buffer.Get(Row, Col)) then
            exit(Buffer."Cell Value as Text");
    end;

    /// <summary>
    /// GetDescription.
    /// </summary>
    /// <param name="Buffer">Temporary VAR Record "Excel Buffer".</param>
    /// <param name="Col">Integer.</param>
    /// <param name="Row">Integer.</param>
    /// <returns>Return value of type Text[100].</returns>
    procedure GetDescription(var Buffer: Record "Excel Buffer" temporary; Col: Integer; Row: Integer): Text[100]
    begin
        if (Buffer.Get(Row, Col)) then
            exit(Buffer."Cell Value as Text");
    end;

    /// <summary>
    /// GetUnitofMeasureCode.
    /// </summary>
    /// <param name="Buffer">Temporary VAR Record "Excel Buffer".</param>
    /// <param name="Col">Integer.</param>
    /// <param name="Row">Integer.</param>
    /// <returns>Return value of type Code[20].</returns>
    procedure GetUnitofMeasureCode(var Buffer: Record "Excel Buffer" temporary; Col: Integer; Row: Integer): Code[20]
    begin
        if (Buffer.Get(Row, Col)) then
            exit(Buffer."Cell Value as Text");
    end;
    /// <summary>
    /// GetQuantity.
    /// </summary>
    /// <param name="Buffer">Temporary VAR Record "Excel Buffer".</param>
    /// <param name="Col">Integer.</param>
    /// <param name="Row">Integer.</param>
    /// <returns>Return value of type Decimal.</returns>
    procedure GetQuantity(var Buffer: Record "Excel Buffer" temporary; Col: Integer; Row: Integer): Decimal
    var
        D: Decimal;
    begin
        if (Buffer.Get(Row, Col)) then
            Evaluate(D, Buffer."Cell Value as Text");
        exit(D);
    end;

    /// <summary>
    /// ExportRcurringItems.
    /// </summary>
    /// <param name="RecurringItems">VAR Record FarahCustomerRecurringItems.</param>
    procedure ExportRcurringItems(var RecurringItems: Record FarahCustomerRecurringItems)
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        CustomerRecurringItemsLbl: Label 'Customer Recurring Items';
        ExcelFileName: Label 'Farah Customer Recurring Items';
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.AddColumn(RecurringItems.FieldCaption("Customer No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecurringItems.FieldCaption("Item No."), false, '', false, true, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecurringItems.FieldCaption("Description"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecurringItems.FieldCaption("Unit of Measure Code"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecurringItems.FieldCaption("Quantity"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        
        if(RecurringItems.FindSet()) then 
        repeat
        
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(RecurringItems."Customer No.", false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecurringItems."Item No.", false, '', false, true, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecurringItems."Description", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecurringItems."Unit of Measure Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecurringItems."Quantity", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.CreateNewBook(CustomerRecurringItemsLbl);
        TempExcelBuffer.WriteSheet(CustomerRecurringItemsLbl, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();

        until RecurringItems.next()=0;

    end;

}
