namespace WordLayouts.Sales;

using Microsoft.Sales.History;

pageextension 50102 "Posted Sales Invoice Subform" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addbefore("Job No.")
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
