CREATE ROLE mere_mortal;
SET ROLE mere_mortal;

SHOW extwlist.extensions;

SELECT extname FROM pg_extension ORDER BY 1;

-- pre-existing extension
CREATE EXTENSION plpgsql;
SELECT extname FROM pg_extension ORDER BY 1;

-- non-whitelisted extension
CREATE EXTENSION hstore;
SELECT extname FROM pg_extension ORDER BY 1;

-- whitelisted extensions
CREATE EXTENSION citext;
CREATE EXTENSION pg_trgm;
SELECT extname FROM pg_extension ORDER BY 1;

-- whitelisted extension, but dependency is missing
CREATE EXTENSION earthdistance;
SELECT extname FROM pg_extension ORDER BY 1;

-- drop whitelisted extension
DROP EXTENSION pg_trgm;
SELECT extname FROM pg_extension ORDER BY 1;

-- drop non-whitelisted extension
DROP EXTENSION plpgsql;
SELECT extname FROM pg_extension ORDER BY 1;

-- whitelisted extension with custom after-create script
CREATE EXTENSION pg_stat_statements;
SELECT extname FROM pg_extension ORDER BY 1;

CREATE EXTENSION IF NOT EXISTS pg_trgm;
SET pgextwlist.custom_path TO '/Users/oleksii/src/github.com/dimitri/pgextwlist/test-scripts/catchall-before';
-- catchall before-create and before-update scripts
DROP EXTENSION IF EXISTS citext;
CREATE EXTENSION citext;
SELECT extname FROM pg_extension ORDER BY 1;
ALTER EXTENSION pg_trgm UPDATE;

SET pgextwlist.custom_path TO '/Users/oleksii/src/github.com/dimitri/pgextwlist/test-scripts/catchall-after';
-- catchall after-create and after-update scripts
DROP EXTENSION IF EXISTS citext;
CREATE EXTENSION citext;
SELECT extname FROM pg_extension ORDER BY 1;
ALTER EXTENSION pg_trgm UPDATE;
