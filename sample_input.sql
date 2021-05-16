CREATE OR REPLACE FUNCTION public.function123(
	in_hotelid integer)
    RETURNS TABLE(out_idhotelbooking integer, out_fname character varying, out_lname character varying, out_resvdate date, out_bookedby character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	DROP TABLE IF EXISTS tem;
	CREATE TEMP TABLE tem (
   	tem_idhotelbooking integer, 
	tem_fname character varying,
	tem_lname character varying, 
	tem_reservationdate date,
	"tem_idEmployee" character varying
	);
	INSERT INTO tem
	SELECT 
	idhotelbooking, 
	fname,
	lname, 
	reservationdate,
	employee."idEmployee"
	FROM roombooking 
	JOIN room ON roombooking."roomID" = room."idRoom"
	JOIN hotelbooking ON hotelbooking.idhotelbooking = roombooking."hotelbookingID"
	JOIN person ON person."idPerson" = roombooking."bookedforpersonID"
	LEFT JOIN employee ON employee."idEmployee" = hotelbooking."bookedbyclientID";
-- 	WHERE room."idHotel" = in_hotelid;
RETURN QUERY                                 
-- 	SELECT * FROM tem ORDER BY "out_idhotelbooking" ASC;
	SELECT tem_idhotelbooking, tem_fname, tem_lname, tem_reservationdate, 'employee'::character varying(16) AS "bookedBy" 
	FROM tem WHERE "tem_idEmployee" IS NOT NULL
	UNION
	SELECT tem_idhotelbooking, tem_fname, tem_lname, tem_reservationdate, 'client'::character varying(16) AS "bookedBy" 
	FROM tem WHERE "tem_idEmployee" IS NULL;
END;
$BODY$;