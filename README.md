# WordLayouts

A Business Central AL extension that demonstrates what is achievable with **Word layouts** compared to traditional **RDLC layouts** — using the Standard Sales Invoice as the showcase report.

Both a Word layout (`ModernSalesInvoice.docx`) and an equivalent RDLC layout (`ModernSalesInvoice.rdl`) are provided side-by-side so you can compare the capabilities and trade-offs of each approach.

---

## Background

RDLC has long been the default layout engine for Business Central reports. It is powerful but requires knowledge of Report Definition Language and is difficult to style attractively. Word layouts offer a more accessible, design-friendly alternative — but historically had significant limitations around dynamic behaviour.

This project explores how far Word layouts can be pushed to match (and in some cases exceed) the developer experience of RDLC.

---

## Features

### 1. Modern Layout Design

Both the Word and RDLC layouts were designed from scratch with a modern, professional look — clean typography, a dark navy header, subtle grid lines, and a two-column footer area. The design was generated with the help of Claude (Anthropic).

### 2. Extended Dataset for Word Layout

Word layouts cannot natively perform conditional formatting or page breaks because they lack expression support at row level. To work around this, the dataset is extended with dedicated sub-dataitems per line style and per page-break variant:

| Dataitem | When emitted |
|---|---|
| `LineNormal` | Normal style, no page break |
| `LineNormalNewPage` | Normal style, page break before |
| `LineItalic` | Italic style, no page break |
| `LineItalicNewPage` | Italic style, page break before |
| `LineBold` | Bold style, no page break |
| `LineBoldNewPage` | Bold style, page break before |

Each dataitem uses an `OnPreDataItem` trigger with `CurrReport.Break()` to emit exactly one record per line in the correct variant, giving the Word template a separate repeating region to bind to for each combination.

The fields exposed on each sub-dataitem mirror the standard line fields (`Description`, `Quantity`, `UnitPrice`, `LineAmount`, `ShipmentDate`, `No.`).

> The `AttachedLine` dataitem additionally exposes `AttachedDescription` for lines that are attached to a parent line, enabling the optional sub-description row.

### 3. Picture Positioning

The Word layout demonstrates how to position a logo or picture at a fixed location on the page and keep it anchored correctly across different data lengths — something that requires careful anchor and wrap settings in Word but is trivial once configured.

### 4. Conditional Formatting

Lines can be printed in **Normal**, **Bold**, or **Italic** style. The `Style` field (enum `Line Format Style`) is set on the sales line and carried through to the posted invoice line via table extensions on both `Sales Line` and `Sales Invoice Line`.

- In the **RDLC layout**, conditional formatting is expressed directly as RDL expressions (e.g. `=iif(Fields!LineFormatStyle.Value = 1, "Bold", "Normal")`).
- In the **Word layout**, each style has its own repeating region pre-formatted in the template, and the dataset routes the line to the correct region at runtime.

The `Style` and `New Page` fields are surfaced in both the **Sales Invoice Subform** and the **Posted Sales Invoice Subform** so users can set them directly on the document lines.

### 5. Conditional Line Page Break

Each line carries a **New Page** boolean flag. When set, a page break is inserted before that line in the printed output.

- In the **RDLC layout**, this is handled via a `PageGroupNo` column and a group-level page break between groups.
- In the **Word layout**, the same `PageGroupNo` value is used — the `*NewPage` dataitems only emit when `New Page = true`, and the corresponding Word repeating region has a page break built into the paragraph formatting of its first row.

### 6. Conditional Attached Description Row

When a sales line has attached lines (sub-lines), their description is shown as an indented italic row beneath the parent line. The row is hidden when `AttachedDescription` is empty or null:

- In the **RDLC layout**, this is achieved with a `Visibility/Hidden` expression on the inner row `TablixMember`.
- In the **Word layout**, the `AttachedLine` sub-dataitem naturally produces zero rows when there are no attached lines.

---

## Project Structure

```
src/
  LineFormatStyle.Enum.al              – Enum: Normal / Bold / Italic
  SalesLine.TableExt.al                – Adds Style + New Page to Sales Line
  SalesInvoiceLine.TableExt.al         – Adds Style + New Page to Posted Sales Invoice Line
  SalesInvoiceSubform.PageExt.al       – Exposes Style + New Page on Sales Invoice Subform
  PostedSalesInvoiceSubform.PageExt.al – Exposes Style + New Page on Posted Sales Invoice Subform
  StandardSalesInvoiceExt.ReportExt.al – Report extension: dataset, sub-dataitems, rendering layouts
  ModernSalesInvoice.rdl               – Modern RDLC layout
  ModernSalesInvoice.docx              – Modern Word layout
```

---

## Requirements

- Business Central platform **28.0** or later
- AL extension ID range **50100 – 50149**

---

## Getting Started

1. Clone the repository and open the folder in VS Code with the AL Language extension installed.
2. Run **AL: Download Symbols** and then **AL: Publish** to deploy to your sandbox.
3. Open any posted sales invoice and choose **Print / Send → Standard Sales - Invoice**.
4. Select either **Modern Sales Invoice (Word)** or **Modern Sales Invoice (RDLC)** from the layout picker.

---

## License

See [LICENSE](LICENSE).
