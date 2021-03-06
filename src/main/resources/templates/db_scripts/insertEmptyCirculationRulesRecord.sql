-- ensure that there will be one row only
ALTER TABLE ${myuniversity}_${mymodule}.${table.tableName}
  ADD COLUMN IF NOT EXISTS
    lock boolean DEFAULT true UNIQUE CHECK(lock=true);
INSERT INTO ${myuniversity}_${mymodule}.${table.tableName}
  SELECT id, jsonb_build_object('id', id, 'rulesAsText', '')
  FROM (SELECT md5('${myuniversity}_${mymodule}.${table.tableName}.rulesAsText')::uuid AS id) AS alias
  ON CONFLICT DO NOTHING;
