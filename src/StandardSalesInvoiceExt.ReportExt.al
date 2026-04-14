namespace WordLayouts.Sales;

using Microsoft.Sales.History;
using System.Utilities;

reportextension 50100 "Standard Sales Invoice Ext." extends "Standard Sales - Invoice"
{
    dataset
    {
        add(Line)
        {
            column(LineFormatStyle; Format(Line."Style", 0, 2))
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                if Line."Attached to Line No." > 0 then
                    CurrReport.Skip();
                if Line."New Page" then
                    PageGroupNo += 1;
            end;

            trigger OnAfterPreDataItem()
            begin
                PageGroupNo := 1;
            end;
        }
        addfirst(Line)
        {
            dataitem(LineNormal; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(DescriptionNormal; Line.Description) { }
                column(QuantityNormal; FormattedQuantity) { }
                column(UnitPriceNormal; FormattedUnitPrice) { }
                column(LineAmountNormal; FormattedLineAmount) { }
                column(ShipmentDateNormal; Format(Line."Shipment Date")) { }
                column(ItemNoNormal; Line."No.") { }
                trigger OnPreDataItem()
                begin
                    if (Line."Style" <> Line."Style"::Normal) or Line."New Page" then
                        CurrReport.Break();
                end;
            }
            dataitem(LineNormalNewPage; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(DescriptionNormalNewPage; Line.Description) { }
                column(QuantityNormalNewPage; FormattedQuantity) { }
                column(UnitPriceNormalNewPage; FormattedUnitPrice) { }
                column(LineAmountNormalNewPage; FormattedLineAmount) { }
                column(ShipmentDateNormalNewPage; Format(Line."Shipment Date")) { }
                column(ItemNoNormalNewPage; Line."No.") { }
                trigger OnPreDataItem()
                begin
                    if (Line."Style" <> Line."Style"::Normal) or not Line."New Page" then
                        CurrReport.Break();
                end;
            }
            dataitem(LineItalic; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(DescriptionItalic; Line.Description) { }
                column(QuantityItalic; FormattedQuantity) { }
                column(UnitPriceItalic; FormattedUnitPrice) { }
                column(LineAmountItalic; FormattedLineAmount) { }
                column(ShipmentDateItalic; Format(Line."Shipment Date")) { }
                column(ItemNoItalic; Line."No.") { }
                trigger OnPreDataItem()
                begin
                    if (Line."Style" <> Line."Style"::Italic) or Line."New Page" then
                        CurrReport.Break();
                end;
            }
            dataitem(LineItalicNewPage; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(DescriptionItalicNewPage; Line.Description) { }
                column(QuantityItalicNewPage; FormattedQuantity) { }
                column(UnitPriceItalicNewPage; FormattedUnitPrice) { }
                column(LineAmountItalicNewPage; FormattedLineAmount) { }
                column(ShipmentDateItalicNewPage; Format(Line."Shipment Date")) { }
                column(ItemNoItalicNewPage; Line."No.") { }
                trigger OnPreDataItem()
                begin
                    if (Line."Style" <> Line."Style"::Italic) or not Line."New Page" then
                        CurrReport.Break();
                end;
            }
            dataitem(LineBold; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(DescriptionBold; Line.Description) { }
                column(QuantityBold; FormattedQuantity) { }
                column(UnitPriceBold; FormattedUnitPrice) { }
                column(LineAmountBold; FormattedLineAmount) { }
                column(ShipmentDateBold; Format(Line."Shipment Date")) { }
                column(ItemNoBold; Line."No.") { }
                trigger OnPreDataItem()
                begin
                    if (Line."Style" <> Line."Style"::Bold) or Line."New Page" then
                        CurrReport.Break();
                end;
            }
            dataitem(LineBoldNewPage; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(DescriptionBoldNewPage; Line.Description) { }
                column(QuantityBoldNewPage; FormattedQuantity) { }
                column(UnitPriceBoldNewPage; FormattedUnitPrice) { }
                column(LineAmountBoldNewPage; FormattedLineAmount) { }
                column(ShipmentDateBoldNewPage; Format(Line."Shipment Date")) { }
                column(ItemNoBoldNewPage; Line."No.") { }
                trigger OnPreDataItem()
                begin
                    if (Line."Style" <> Line."Style"::Bold) or not Line."New Page" then
                        CurrReport.Break();
                end;
            }
            dataitem(AttachedLine; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("Document No."), "Attached to Line No." = field("Line No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(AttachedDescription; Description) { }
            }
        }
    }

    rendering
    {
        layout("ModernSalesInvoice.docx")
        {
            Type = Word;
            LayoutFile = './src/ModernSalesInvoice.docx';
            Caption = 'Modern Sales Invoice (Word)';
            Summary = 'Modern Word layout for the Standard Sales Invoice.';
        }
        layout("ModernSalesInvoice.rdl")
        {
            Type = RDLC;
            LayoutFile = './src/ModernSalesInvoice.rdl';
            Caption = 'Modern Sales Invoice (RDLC)';
            Summary = 'Modern RDLC layout for the Standard Sales Invoice.';
        }
    }

    protected var
        PageGroupNo: Integer;
}
