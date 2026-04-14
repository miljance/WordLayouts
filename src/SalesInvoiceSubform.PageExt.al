namespace WordLayouts.Sales;

using Microsoft.Sales.Document;

pageextension 50101 "Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        addbefore("Allow Item Charge Assignment")
        {
            field(WLStyle; Rec."Style")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the line should be printed in normal, bold, or italic style.';
            }
            field(WLNewPage; Rec."New Page")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether a new page should be started with this line.';
            }
        }
    }
}
