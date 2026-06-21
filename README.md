# 🚀 Backend + AI Engineering Roadmap

A production-grade engineering ledger documenting my progression through backend systems architecture, data engineering pipelines, and intelligent agentic AI integrations. Each module is implemented as executable SQL or application code, designed to be auditable, reproducible, and incrementally composable toward a full-stack intelligent backend.

---

## 📂 Repository Blueprint

### 🏗️ Phase 1: Core Relational Data Layer (`/mysql`)

* **`Beginner - Parks_and_Rec_Create_db.sql`** — Full relational schema bootstrap: `CREATE DATABASE`, multi-table `CREATE TABLE` definitions with typed columns (`INT`, `VARCHAR`, `DATE`), `PRIMARY KEY` constraints, `AUTO_INCREMENT` sequences, and batch `INSERT INTO` population across three normalized tables (`employee_demographics`, `employee_salary`, `parks_departments`).
* **`2.select tutorial.sql`** — Data projection fundamentals: column-level `SELECT`, computed expressions, and `DISTINCT` deduplication for unique value extraction.
* **`3.where clause.sql`** — Row-level predicate filtering: equality, comparison, and range operators; `LIKE` pattern matching with wildcards; compound Boolean logic using `AND`, `OR`, and `NOT`.
* **`4.Group by and order by.sql`** — Aggregate analytics via `GROUP BY` with `SUM`, `AVG`, `COUNT` metric computation; multi-column `ORDER BY` for deterministic sort pipelines.
* **`5.where Vs having.sql`** — Contrasting pre-aggregation (`WHERE`) versus post-aggregation (`HAVING`) filtering semantics within grouped result sets.
* **`6.limit and alaising.sql`** — Result set pagination with `LIMIT` and `OFFSET`; semantic column and table renaming via `AS` aliasing for clean projection contracts.
* **`7.Joins.sql`** — Relational data stitching across `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, and positional `SELF JOIN` patterns for hierarchical or recursive relationship resolution.
* **`8.Unions.sql`** — Vertical row concatenation pipelines using `UNION` (deduplicated) and `UNION ALL` (preserving duplicates); cross-table schema-compatible result merging.
* **`9.String functions.sql`** — Text transformation toolkit: `LENGTH`, `UPPER`, `LOWER`, `TRIM`, `SUBSTRING` for positional chunking, `REPLACE` for in-place mutation, and `LOCATE` for index-based character search.
* **`10.Case statements.sql`** — Conditional branching inside projection blocks via `CASE WHEN … THEN … ELSE … END`, enabling inline categorical classification and derived column generation.
* **`11.Subqueries.sql`** — Nested query composition: scalar subqueries in `SELECT`, correlated subqueries in `WHERE`, and derived tables in `FROM` for dynamic, context-dependent filtering.
* **`12.Window functions.sql`** — Analytical partitioning with `OVER(PARTITION BY … ORDER BY …)`: per-partition `AVG` aggregation, ordered `SUM` rolling totals, and ranking trifecta (`ROW_NUMBER`, `RANK`, `DENSE_RANK`) for positional analytics.
* **`13. CTE.sql`** — Common Table Expressions (`WITH … AS`): named intermediate result sets for query decomposition, chained multi-CTE joins, and column alias overrides to decouple complex analytical pipelines from deeply nested subqueries.
* **`14. Temporary tables.sql`** — Session-scoped `CREATE TEMPORARY TABLE` for ephemeral staging: manual schema definition with `INSERT`, and `SELECT INTO` pattern for materializing filtered snapshots (e.g., salary threshold extractions).
* **`15. Stored procedures.sql`** — Reusable server-side logic encapsulation via `CREATE PROCEDURE`: single-statement procedures, multi-statement `BEGIN…END` blocks with `DELIMITER` switching, and parameterized procedures (`IN` parameters) for dynamic record lookup.
* **`16. Trigger and Events.sql`** — Reactive automation: `AFTER INSERT` row-level triggers for cross-table cascade inserts using `NEW` pseudo-record; scheduled `EVENT` definitions with `ON SCHEDULE EVERY` for periodic background maintenance (e.g., automated retiree purge).

---

### 🔬 Phase 1.5: Applied Data Engineering (`/mysql/Project`)

* **`Data Cleaning Project.sql`** — End-to-end data cleaning pipeline on a real-world layoffs dataset, executed across four disciplined stages:
    1. **Deduplication** — Copies raw data into a staging table (`CREATE TABLE … LIKE`), assigns deterministic duplicate identifiers via `ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions)`, materializes the row numbers into a secondary staging table (`layoffs_staging2`) with an appended `row_num` column, then surgically `DELETE`s all rows where `row_num > 1`.
    2. **Standardization** — Applies `TRIM()` to strip leading/trailing whitespace from `company`; normalizes variant industry labels (e.g., `Crypto%` → `Crypto`) via conditional `UPDATE`; removes trailing punctuation from `country` with `TRIM(TRAILING '.' FROM …)`; converts string-encoded dates to native `DATE` type using `STR_TO_DATE()` followed by `ALTER TABLE … MODIFY COLUMN`.
    3. **Null Imputation** — Converts empty-string `industry` values to `NULL`; performs a self-join (`t1 JOIN t2 ON t1.company = t2.company`) to back-fill missing industry values from sibling records of the same company.
    4. **Dead Row Pruning** — Removes analytically useless records where both `total_laid_off` and `percentage_laid_off` are `NULL`; drops the synthetic `row_num` scaffold column via `ALTER TABLE … DROP COLUMN`.

* **`Exploratory Data Analysis.sql`** — Multi-dimensional analytical deep dive on the cleaned dataset:
    * **Schema Hardening** — Casts `total_laid_off` and `funds_raised_millions` from `TEXT` to `INT`, and `percentage_laid_off` to `DECIMAL(5,2)` for numeric precision.
    * **Boundary Detection** — `MAX()` scans across layoff volume and percentage columns; `MIN/MAX` on `date` to establish the dataset's temporal range.
    * **Dimensional Aggregation** — `SUM(total_laid_off)` grouped independently by `company`, `industry`, `country`, `YEAR(date)`, and `stage` to surface top contributors across every analytical axis.
    * **Full-Shutdown Analysis** — Isolates companies with `percentage_laid_off = 1` (100% workforce elimination), ranked by `funds_raised_millions DESC` to quantify capital destruction.
    * **Monthly Time-Series with Rolling Totals** — Extracts `SUBSTRING(date, 1, 7)` as month key, computes monthly `SUM`, then applies `SUM(total_off) OVER(ORDER BY MONTH)` via a CTE-backed window function to produce a cumulative rolling total across the full timeline.
    * **Per-Year Company Ranking** — Chains two CTEs: `Company_year` aggregates layoffs by `(company, YEAR(date))`, then `Company_year_rank` applies `DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC)` to surface the **top 5 companies per year** by layoff volume.

---

## 📈 Tech Stack Foundations

| Layer | Technology | Domain |
|-------|-----------|--------|
| **Data** | MySQL 8.x | Relational schema design, window functions, CTEs, stored procedures, triggers, ETL pipelines |
| **Application** | Python | Scripting, data transformation, API development (planned) |
| **Systems** | C++ | Algorithms, memory management, performance-critical optimization |

---

## 🛠️ Upcoming Milestones

- [ ] **Phase 2: Web API Layer** — FastAPI with async route handlers, Pydantic schema validation, middleware-based auth (JWT/OAuth2), and OpenAPI spec generation.
- [ ] **Phase 3: Systems & DevOps** — Docker containerization, multi-stage builds, CI/CD pipelines, and automated ETL orchestration.
- [ ] **Phase 4: Agentic AI Integration** — Vector database embeddings (pgvector / Pinecone), LangChain agent orchestration, RAG pipelines, and autonomous tool-use workflows.