-- Generar un listado con las personas asociadas a un apartamento (responsable y residentes).

CREATE OR REPLACE FUNCTION fu_list_per_asociados (
    pk_apto  IN apartamento.k_apartamento%TYPE,
    pc_error OUT NUMBER,
    pm_error OUT VARCHAR
) RETURN SYS_REFCURSOR IS 
    --Declaración de variables locales
    lk_apto SYS_REFCURSOR;
BEGIN
    pc_error := 0;
    pm_error := NULL;
    open lk_apto
     for   SELECT
        A.K_APARTAMENTO "ID Apartamento", P.N_NOMBRE ||' '|| P.N_APELLIDO "Nombre Completo"
    FROM
        apartamento a,
        persona     p,
        responsable r
    WHERE
            p.k_numero = r.fk_numero_responsable
        AND a.fk_numero_responsable_a = r.fk_numero_responsable
        and A.K_APARTAMENTO = pk_apto
    UNION
    SELECT
        A.K_APARTAMENTO "ID Apartamento", P.N_NOMBRE ||' '|| P.N_APELLIDO "Nombre Completo"
    FROM
        apartamento a,
        persona     p,
        residente   r
    WHERE
            p.k_numero = r.fk_numero_residente
        AND r.fk_apartamento_r = a.k_apartamento
        and A.K_APARTAMENTO = pk_apto;

    RETURN lk_apto;
EXCEPTION
    WHEN no_data_found THEN
        pc_error := 1;
        pm_error := 'personas no encontradas';
END fu_list_per_asociados;
/

--bloque anononimo 
DECLARE
  pk_apto VARCHAR2(3);
  PC_ERROR NUMBER;
  PM_ERROR VARCHAR2(200);
  v_Return SYS_REFCURSOR;
  ls_rec_nom VARCHAR(200);
  ls_rec_tipo VARCHAR(200);

BEGIN
  pk_apto := 1;

  v_Return :=fu_list_per_asociados (
    pk_apto => pk_apto,
    PC_ERROR => PC_ERROR,
    PM_ERROR => PM_ERROR
  );

  LOOP
  FETCH v_Return INTO ls_rec_nom, ls_rec_tipo;
  EXIT WHEN v_Return%NOTFOUND;
  dbms_output.put_line(ls_rec_nom || ',' || ls_rec_tipo||'.');
    END LOOP;
   close v_Return;
END;

-------------------------------------------------------------------------------------------------------------------------------------

-- Calcular el valor a pagar de un apartamento para un mes dado (debe incluir la cuota actual, el saldo pendiente y los intereses de mora)

CREATE OR REPLACE FUNCTION FU_CALCULAR_VALOR_APTO (
pk_apartamento IN apartamento.k_apartamento%TYPE, --Adopta el tipo de la col de la BD
pf_fecha_actual IN DATE 
)
RETURN FLOAT
IS
--DEFINICION DE VARIABLES
lv_valor_apto FLOAT;
lv_co_propiedad FLOAT;

lv_q_tamanio_apartamento apartamento.q_tamanio_apartamento%TYPE;
lv_q_area_privada conjunto.q_area_privada%TYPE;
lv_dia_oportuno conjunto.dia_oportuno%TYPE;
lv_administracion_base conjunto.administracion_base%TYPE;
lv_v_mora conjunto.v_mora%TYPE;

BEGIN

SELECT q_tamanio_apartamento INTO lv_q_tamanio_apartamento FROM apartamento WHERE k_apartamento = pk_apartamento;

SELECT c.q_area_privada INTO lv_q_area_privada FROM conjunto c , apartamento a WHERE c.k_conjunto = a.fk_conjunto_A;

SELECT c.dia_oportuno INTO lv_dia_oportuno FROM conjunto c , apartamento a WHERE c.k_conjunto = a.fk_conjunto_A;

SELECT c.administracion_base INTO lv_administracion_base FROM conjunto c , apartamento a WHERE c.k_conjunto = a.fk_conjunto_A;

SELECT c.v_mora INTO lv_v_mora FROM conjunto c , apartamento a WHERE c.k_conjunto = a.fk_conjunto_A;


lv_co_propiedad := (lv_q_tamanio_apartamento*100)/lv_q_area_privada; -- se obtiene un porcentaje ej: 6%

lv_valor_apto : = lv_administracion_base + (lv_administracion_base*lv_co_propiedad)/100; -- quitar el porcentaje

IF EXTRACT(DAY FROM pf_fecha_actual) > dia_oportuno THEN 
    lv_valor_apto : = lv_valor_apto + lv_v_mora*lv_administracion_base;

return lv_valor_apto;

EXCEPTION
    WHEN no_data_found THEN
        raise_application_error(100, 'No se encontro información relacionada');   

    WHEN OTHERS THEN
        raise_application_error(100, 'Error'); 

END FU_CALCULAR_VALOR_APTO;
/

-- bloque anonimo 


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Generar la cuenta de cobro de un apartamento para un mes dado. La cuenta de cobro debe incluir los datos del apartamento, el responsable del pago, el valor de la cuota actual, el saldo pendiente, la fecha de pago, el descuento por pronto pago y la mora en el caso de que haya un saldo pendiente.

CREATE OR REPLACE PROCEDURE FU_GENERAR_CUENTA_COBRO_APTO (
pk_cuenta_cobro IN NUMBER,    
pk_apartamento IN apartamento.k_apartamento%TYPE, -- Adopta el tipo de la col de la BD
pf_fecha_actual IN DATE 
)

IS

BEGIN

INSERT INTO CUENTA_COBRO VALUES (pk_cuenta_cobro, pk_apartamento, pf_fecha_actual, 'P', EXTRACT(MONTH FROM pf_fecha_actual), EXTRACT(YEAR FROM pf_fecha_actual));

END FU_CALCULAR_VALOR_APTO;

/

-- BLOQUE ANONIMO 

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Registrar el valor del pago para un apartamento (primero se deben pagar las cuotas pendientes en orden de antigüedad, y si el valor pagado alcanza, abonar a la cuota actual).

CREATE OR REPLACE PROCEDURE FU_REGISTRAR_PAGO_APTO (
pk_cuenta_cobro IN NUMBER,    
pk_apartamento IN apartamento.k_apartamento%TYPE, -- Adopta el tipo de la col de la BD
pf_fecha_actual IN DATE,
pf_forma_pago IN pago.f_forma_pago%TYPE
)
IS

lv_valor_a_pagar FLOAT;
lv_dia_oportuno conjunto.dia_oportuno%TYPE;
lv_descuento conjunto.descuento%TYPE;
lv_num_total NUMBER;
BEGIN

CURSOR c_cuenta_cobro IS
        SELECT
            k_cuenta_cobro,
            fk_apartamento_C,
            f_fecha_cuenta,
            i_estado_cuenta,
            periodo_mes,
            periodo_ano
        FROM
            CUENTA_COBRO
        WHERE
            k_cuenta_cobro=pk_cuenta_cobro;

        rc_cuenta_cobro c_cuenta_cobro%rowtype;
    BEGIN
        OPEN c_cuenta_cobro;
        LOOP
            FETCH c_cuenta_cobro INTO rc_cuenta_cobro;
            
            EXIT WHEN c_cuenta_cobro%notfound;
        END LOOP;

        CLOSE c_reserva;

lv_valor_a_pagar := FU_CALCULAR_VALOR_APTO(rc_cuenta_cobro.fk_apartamento_C, pf_fecha_actual)

SELECT c.dia_oportuno INTO lv_dia_oportuno FROM apartamento a, conjunto c WHERE a.k_apartamento = pk_apartamento AND c.k_conjunto = a.fk_conjunto_A;

SELECT c.descuento INTO lv_descuento FROM apartamento a, conjunto c WHERE a.k_apartamento = pk_apartamento AND c.k_conjunto = a.fk_conjunto_A;

SELECT COUNT(K_PAGO) INTO lv_num_total FROM PAGO; 


-- DESCUENTO
IF EXTRACT(DAY FROM pf_fecha_actual) <= lv_dia_oportuno THEN 
    lv_valor_a_pagar := lv_valor_a_pagar - (lv_valor_a_pagar*lv_descuento)

END IF 


lv_num_total := lv_num_total + 1;

INSERT INTO PAGO VALUES (lv_num_total, pk_cuenta_cobro, lv_valor_a_pagar, pf_fecha_actual, pf_forma_pago);

    EXCEPTION
        WHEN no_data_found THEN
            raise_application_error(100, 'No se encontró ninguna reserva');  
        WHEN OTHERS THEN
            raise_application_error(100, 'ERROR'); 


END FU_CALCULAR_VALOR_APTO;

/

-- BLOQUE ANONIMO 

