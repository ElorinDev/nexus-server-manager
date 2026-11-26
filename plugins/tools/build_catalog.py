"""Build versioned, reproducible plugin packages without replacing a published version."""
from pathlib import Path
import hashlib
import io
import json
import re
import zipfile

root = Path(__file__).resolve().parent.parent
entries = []
for source in sorted((root / 'sources').iterdir()):
    if not source.is_dir():
        continue
    metadata = json.loads((source / 'metadata.json').read_text(encoding='utf-8-sig'))
    identifier, version, entrypoint = metadata['Id'], metadata['Version'], metadata['EntryPoint']
    assert re.fullmatch(r'[a-z][a-z0-9-]{0,63}', identifier)
    assert identifier == source.name and re.fullmatch(r'[0-9]+\.[0-9]+\.[0-9]+(?:\.[0-9]+)?', version)
    assert re.fullmatch(r'[A-Za-z][A-Za-z0-9_]{0,63}', entrypoint)
    assert (source / f'{entrypoint}.cs').is_file() and (source / 'LICENSE.txt').is_file()
    stream = io.BytesIO()
    with zipfile.ZipFile(stream, 'w', zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
        for path in sorted(source.iterdir()):
            if path.name == 'metadata.json' or not path.is_file():
                continue
            info = zipfile.ZipInfo(f'{entrypoint}.cs/{path.name}', date_time=(2026,1,1,0,0,0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = 0o100644 << 16
            archive.writestr(info, path.read_bytes(), compresslevel=9)
    package = stream.getvalue()
    relative = f'packages/{identifier}/{version}.zip'
    target = root / relative
    target.parent.mkdir(parents=True, exist_ok=True)
    if target.exists() and target.read_bytes() != package:
        raise RuntimeError(f'{relative} já existe com outro conteúdo. Aumente a versão do plugin.')
    target.write_bytes(package)
    metadata.update(Package=relative, Size=len(package), Sha256=hashlib.sha256(package).hexdigest())
    entries.append(metadata)
(root / 'catalog.json').write_text(json.dumps({'SchemaVersion':1,'Plugins':entries},ensure_ascii=False,indent=2)+'\n', encoding='utf-8')
print(f'Catálogo pronto: {len(entries)} plugin(s).')
