SET check_function_bodies = false;
INSERT INTO identity.parties (party_id, first_name, last_name, idp_id) VALUES (1, 'Jean-Luc', 'CANELA', 'google_');
INSERT INTO identity.party_roles (party_role_id, party_id, role_type_id) VALUES (1, 1, 'Administrator');
SELECT pg_catalog.setval('identity.parties_party_id_seq', 1, true);
SELECT pg_catalog.setval('identity.party_roles_party_role_id_seq', 1, true);
