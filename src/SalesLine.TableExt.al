namespace WordLayouts.Sales;

using Microsoft.Sales.Document;

tableextension 50101 "Sales Line" extends "Sales Line"
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
