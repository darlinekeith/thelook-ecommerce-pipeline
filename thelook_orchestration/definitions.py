from dagster import Definitions, ScheduleDefinition, define_asset_job
from dagster_dbt import DbtCliResource, dbt_assets
from pathlib import Path

DBT_PROJECT_DIR = Path(__file__).parent.parent / "thelook_pipeline"

@dbt_assets(
    manifest=DBT_PROJECT_DIR / "target" / "manifest.json",
)
def thelook_dbt_assets(context, dbt: DbtCliResource):
    yield from dbt.cli(["run"], context=context).stream()

thelook_job = define_asset_job(
    name="thelook_pipeline_job",
    selection=[thelook_dbt_assets],
)

daily_schedule = ScheduleDefinition(
    job=thelook_job,
    cron_schedule="0 6 * * *",
)

defs = Definitions(
    assets=[thelook_dbt_assets],
    jobs=[thelook_job],
    schedules=[daily_schedule],
    resources={
        "dbt": DbtCliResource(project_dir=str(DBT_PROJECT_DIR)),
    },
)
