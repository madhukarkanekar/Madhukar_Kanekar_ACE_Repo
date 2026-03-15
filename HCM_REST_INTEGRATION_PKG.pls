CREATE OR REPLACE PACKAGE hcm_rest_integration_pkg AS

  PROCEDURE process_manager_api_payload(
      p_file_id   NUMBER
  );

  PROCEDURE process_person_api_payload(
      p_file_id   NUMBER
  );

END hcm_rest_integration_pkg;
/
