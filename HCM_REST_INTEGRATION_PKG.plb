CREATE OR REPLACE PACKAGE BODY hcm_rest_integration_pkg AS

-----------------------------------------------------------------
-- Global variables (Generic)
-----------------------------------------------------------------

g_base_url      VARCHAR2(1000) := 'https://example.fa.us2.oraclecloud.com';
g_wallet_path   VARCHAR2(1000) := 'file:/wallet';
g_username      VARCHAR2(100)  := 'HCM_USER';
g_password      VARCHAR2(100)  := 'PASSWORD';


-----------------------------------------------------------------
-- Procedure : process_manager_api_payload
-----------------------------------------------------------------

PROCEDURE process_manager_api_payload(
    p_file_id NUMBER
)
IS
    PRAGMA AUTONOMOUS_TRANSACTION;

    req   UTL_HTTP.req;
    res   UTL_HTTP.resp;

    l_url        VARCHAR2(4000);
    l_response   CLOB;
    l_buffer     VARCHAR2(32767);

    l_json_obj   JSON_OBJECT_T;
    l_json_arr   JSON_ARRAY_T;

BEGIN

    l_url :=
        g_base_url ||
        '/hcmRestApi/resources/latest/workers?limit=10';

    UTL_HTTP.set_wallet(g_wallet_path, NULL);

    req := UTL_HTTP.begin_request(l_url, 'GET');

    UTL_HTTP.set_authentication(req, g_username, g_password);

    UTL_HTTP.set_header(req, 'Content-Type',
        'application/vnd.oracle.adf.resourcecollection+json');

    res := UTL_HTTP.get_response(req);

    IF res.status_code = 200 THEN

        LOOP
            UTL_HTTP.read_line(res, l_buffer);
            l_response := l_response || l_buffer;
        END LOOP;

    END IF;

    UTL_HTTP.end_response(res);

    -------------------------------------------------------
    -- Parse JSON
    -------------------------------------------------------

    l_json_obj := JSON_OBJECT_T(l_response);

    l_json_arr := l_json_obj.get_array('items');

    FOR i IN 0 .. l_json_arr.get_size - 1 LOOP

        NULL;

        -- Example parsing
        -- l_person := ...

    END LOOP;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END process_manager_api_payload;



-----------------------------------------------------------------
-- Procedure : process_person_api_payload
-----------------------------------------------------------------

PROCEDURE process_person_api_payload(
    p_file_id NUMBER
)
IS
    PRAGMA AUTONOMOUS_TRANSACTION;

    req   UTL_HTTP.req;
    res   UTL_HTTP.resp;

    l_url        VARCHAR2(4000);
    l_response   CLOB;
    l_buffer     VARCHAR2(32767);

    l_json_obj   JSON_OBJECT_T;
    l_json_arr   JSON_ARRAY_T;

BEGIN

    l_url :=
        g_base_url ||
        '/hcmRestApi/resources/latest/workers?expand=workRelationships';

    UTL_HTTP.set_wallet(g_wallet_path, NULL);

    req := UTL_HTTP.begin_request(l_url, 'GET');

    UTL_HTTP.set_authentication(req, g_username, g_password);

    UTL_HTTP.set_header(
        req,
        'Content-Type',
        'application/vnd.oracle.adf.resourcecollection+json'
    );

    res := UTL_HTTP.get_response(req);

    IF res.status_code = 200 THEN

        LOOP
            UTL_HTTP.read_line(res, l_buffer);
            l_response := l_response || l_buffer;
        END LOOP;

    END IF;

    UTL_HTTP.end_response(res);

    -------------------------------------------------------
    -- JSON parsing
    -------------------------------------------------------

    l_json_obj := JSON_OBJECT_T(l_response);

    l_json_arr := l_json_obj.get_array('items');

    FOR i IN 0 .. l_json_arr.get_size - 1 LOOP

        NULL;

    END LOOP;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;

END process_person_api_payload;


END hcm_rest_integration_pkg;
/
