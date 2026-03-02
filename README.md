# bbh-reporting-portfolio
# Private Markets Reporting & Governance Portfolio
**Akhil Vohra** | Data & Reporting Analyst

---

## Overview

This portfolio demonstrates end-to-end reporting and data governance skills applied to a private markets fund administration context — directly mirroring the operational environment at firms like BBH, where fund administrators are responsible for LP reporting, NAV validation, capital activity tracking, and data integrity across multi-currency, multi-fund structures.

The work here reflects the full reporting lifecycle: raw data ingestion, structured querying, business analysis, and the kind of governance thinking that sits behind every quarterly LP statement.

---

## The Dataset

**File:** `private_markets_raw_data.xlsx`

A private markets dataset covering three funds across Buyout, Growth, and Credit strategies, with six interconnected tables:

| Table | Description |
|---|---|
| `Funds` | Master fund register — 3 funds, $2.75B total AUM |
| `Investors` | LP base — pension funds, insurance companies, endowments, family offices |
| `Commitments` | LP commitments per fund, including side letter fee discounts |
| `Transactions` | 107 capital calls and distributions across all funds |
| `FX_Rates` | Historical exchange rates for multi-currency conversion (USD, EUR, GBP) |
| `NAV_Quarterly` | Quarterly NAV reporting — gross, net, called and distributed to date |

This structure mirrors real fund administration data architecture, where reporting requires joining across tables, handling currency conversion, and maintaining data integrity at every step.

---

## SQL Queries

All queries are in the `/sql` folder. Each one answers a specific business question a reporting analyst would face in a private markets context.

| # | File | Business Question |
|---|---|---|
| 01 | `01_fund_overview.sql` | What funds are we administering and what is their size? |
| 02 | `02_lp_commitments_ranked.sql` | Which investors have the largest total commitments across all funds? |
| 03 | `03_commitment_utilization.sql` | What percentage of each LP's commitment has been called so far? |
| 04 | `04_capital_calls_by_fund.sql` | How much capital has been drawn down per fund? |
| 05 | `05_distributions_by_fund.sql` | How much has been returned to investors per fund, and what % of fund size does that represent? |
| 06 | `06_investor_type_breakdown.sql` | What is our LP base composition and how much has each investor type committed? |
| 07 | `07_net_cash_flow_by_fund.sql` | What is the net cash position per fund (capital called vs distributions returned)? |
| 08 | `08_transaction_activity_by_quarter.sql` | How has transaction volume and value trended over time? |
| 09 | `09_lp_statement.sql` | What is each investor's complete financial position across all funds? |
| 10 | `10_fx_exposure.sql` | Which transactions involved currency conversion and what was the FX impact? |
| 11 | `11_nav_progression.sql` | How has each fund's net asset value evolved quarter by quarter? |
| 12 | `12_fund_dpi.sql` | How much have investors gotten back relative to what they put in? (DPI) |
| 13 | `13_investor_concentration.sql` | What percentage of total AUM does each LP represent? (Concentration risk) |
| 14 | `14_unfunded_commitments.sql` | How much capital is each LP still obligated to contribute? |
| 15 | `15_quarterly_reporting_pack.sql` | What is the complete fund health snapshot for the most recent quarter? (NAV + DPI + RVPI) |

### Technical highlights
- CTEs (Common Table Expressions) used to eliminate JOIN duplication and ensure data integrity
- Window functions (LAG) for quarter-on-quarter NAV change analysis
- CASE WHEN logic for transaction type filtering within aggregations
- Multi-table JOINs across 3+ tables with explicit column referencing
- COALESCE for handling NULL values in funds with no distribution activity

---

## Data Governance Note

During development, a JOIN duplication issue was identified in queries joining Investors, Commitments, and Transactions simultaneously — a common data integrity challenge in fund administration reporting. This was resolved by restructuring affected queries using CTEs to pre-aggregate each table independently before joining. This approach mirrors best practice in production reporting environments where data accuracy is non-negotiable.

---

## In Progress

- **Power BI Dashboard** — visualizing NAV progression, commitment utilization, capital activity and LP concentration using the same dataset
- **Excel LP Statement** — a formatted quarterly investor report for a single LP, replicating the kind of client-facing output produced in fund administration
- **Process Documentation** — data dictionary and reporting workflow documentation

---

## Tools Used

- **SQL / SQLite** — data extraction, transformation, and analysis
- **DB Browser for SQLite** — query development and testing
- **Python (pandas)** — Excel to SQLite conversion
- **Power BI** — dashboard development (in progress)
- **Microsoft Excel** — LP statement and reporting output (in progress)
- **GitHub** — version control and portfolio presentation
