namespace WordLayouts.Sales;

using Microsoft.Sales.History;

tableextension 50102 "Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        field(50100; "Style"; Enum "Line Format Style")
        {
            Caption = 'Style';
            DataClassification = CustomerContent;
        }
        field(50101; "New Page"; Boolean)
        {
            Caption = 'New Page';
            DataClassification = CustomerContent;
        }
    }
}
