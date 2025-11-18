# Solution - Day 2 Challenge: Advanced S3 Bucket Metadata Manipulation

This solution analyzes S3 bucket metadata provided as JSON, identifies stale or large buckets, computes per-GB storage costs and potential savings from moving data to Glacier, and outputs actionable lists for cleanup, archival, or deletion.

## What the script does
- Loads bucket records from `bucket.json` and converts them to Python objects.
- Prints a summary (name, region, size, versioning) for each bucket.
- Aggregates storage costs by region and by team.
- Detects unused/stale buckets using date-based thresholds and size filters.
- Builds a deletion queue and a list of archival candidates and estimates Glacier savings.

## Key learnings (what I learned)
- JSON handling: parsing nested JSON and iterating records to access fields like `tags` and `policies`.
- Date math: using `datetime.strptime` and computing days-since-last-access to detect staleness.
- Rule-based filtering: expressing operational rules (e.g., size > 100GB and unused > 20 days) to produce deletion/archive lists.
- Cost modeling: implementing per-GB cost calculations and aggregating totals by region/team for chargeback insights.
- Modular scripting: organizing logic into small, testable functions (`load_buckets`, `generate_cost_report`, etc.).

## Practical hardening & suggested improvements
- Fix the exception handler in `load_buckets`: use `except Exception as e:` and return an informative error or exit.
- Parameterize behavior with `argparse` (`--file`, `--size-threshold`, `--days-threshold`, `--dry-run`).
- Add input validation and safe defaults for missing keys (`.get()`), and replace `print` with `logging`.
- Add `--dry-run` and produce CSV/JSON output for human review before performing deletions.
- Add pytest unit tests for `days_since_last_access`, `calculate_cost`, and boundary conditions.
- Optionally integrate with `boto3` to analyze live S3 buckets or AWS Cost Explorer for accurate billing data.

## Quick resume bullet
- Built a Python tool to analyze S3 metadata, identify stale/large buckets, compute region/team storage costs, and recommend archival or deletion to reduce cloud spend.

## How to run (current script)
Run with the repository's copy of `bucket.json`:
```
python DevOps_SRE_Challenge_Season_1/Day_2/bucket_analysis.py
```


