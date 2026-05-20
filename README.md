# Vantage6 Euracan Legacy Algorithms

Home to the source of the following images:

- `ghcr.io/euracan/starter-algorithm-base`
- `ghcr.io/euracan/starter-chisq`
- `ghcr.io/euracan/starter-summary`
- `ghcr.io/euracan/starter-coxph`
- `ghcr.io/euracan/starter-crosstab`
- `ghcr.io/euracan/starter-glm`
- `ghcr.io/euracan/starter-survdiff`
- `ghcr.io/euracan/starter-survfit`

## Disclosure Settings
`VTG_PREPROCESS_MIN_RECORDS_THRESHOLD`

## Release
To make a release you need to tag the commit with the algorithm and version number, for example:

```bash
git tag -a [ALGORITHM]/1.0.0 -m "Release 1.0.0"
git push origin [ALGORITHM]/1.0.0
```

With `[ALGORITHM]` being the name of the algorithm:

- `chisq`
- `summary`
- `survfit`
- `survdiff`
- `coxph`
- `crosstab`
- `glm`

## Documentation

The documentation is generated using sphinx. To generate the documentation you need to install the dependencies:

```bash
pip install -r docs/requirements.txt
```

Then you can generate the documentation with:

```bash
cd docs
make livehtml
```

Then you can view the documentation at `http://localhost:8000`.

