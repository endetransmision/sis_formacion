--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sigefo.f_cargo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de gestión de la formación
 FUNCION: 		sigefo.f_cargo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.tcargo'
 AUTOR: 		 (admin)
 FECHA:	        04-05-2017 20:37:24
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
***************************************************************************/

DECLARE

  v_consulta       VARCHAR;
  v_parametros     RECORD;
  v_nombre_funcion TEXT;
  v_resp           VARCHAR;

BEGIN

  v_nombre_funcion = 'sigefo.f_cargo_sel';
  v_parametros = pxp.f_get_record(p_tabla);

  /*********************************
   #TRANSACCION:  'SIGEFO_CARGO_SEL'
   #DESCRIPCION:	Consulta de datos
   #AUTOR:		yac
   #FECHA:		04-05-2017 20:37:24
  ***********************************/
  IF (p_transaccion = 'SIGEFO_CARGO_SEL')
  THEN

    BEGIN
      /*v_consulta:='SELECT
          tc.id_cargo,
          tc.id_uo,
          tc.id_tipo_contrato,
          tc.id_lugar,
          tc.nombre,
          tc.id_cargo AS identificador,
          uop.id_uo as id_uo_padre,
          uop.nombre_unidad as nombre_unidad_padre
        FROM orga.tuo uop
          JOIN orga.testructura_uo euo ON uop.id_uo = euo.id_uo_padre
          LEFT JOIN orga.tuo ON euo.id_uo_hijo = tuo.id_uo
          JOIN orga.tcargo tc ON tc.id_uo=euo.id_uo_hijo
        WHERE uop.gerencia = ''si'' and tc.estado_reg=''activo'' AND '; */

          
      --Sentencia de la consulta
      v_consulta:='SELECT 
          uo.id_uo::INTEGER as id_cargo,
          uo.nombre_cargo::varchar as nombre,
          uo.id_uo::INTEGER as cod_cargo,
          uo.nombre_cargo::varchar as unidad_organizacional
          FROM 
          ORGA.testructura_uo euo
          JOIN orga.tuo uo on euo.id_uo_hijo=uo.id_uo
          WHERE uo.estado_reg=''activo''  and';

      --Definicion de la respuesta
      v_consulta:=v_consulta || v_parametros.filtro;
      v_consulta:=
      v_consulta || ' order by ' || v_parametros.ordenacion || ' ' || v_parametros.dir_ordenacion || ' limit ' ||
      v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      RETURN v_consulta;

    END;
    /*********************************
 #TRANSACCION:  'SIGEFO_CARGO_CONT'
 #DESCRIPCION:	Conteo de registros
 #AUTOR:		yac
 #FECHA:		04-05-2017 19:16:06
***********************************/

  ELSIF (p_transaccion = 'SIGEFO_CARGO_CONT')
    THEN

      BEGIN
        --Sentencia de la consulta de conteo de registros
         /*v_consulta:='select count(tc.id_cargo)
					    FROM orga.tuo uop
          JOIN orga.testructura_uo euo ON uop.id_uo = euo.id_uo_padre
          LEFT JOIN orga.tuo ON euo.id_uo_hijo = tuo.id_uo
          JOIN orga.tcargo tc ON tc.id_uo=euo.id_uo_hijo
        WHERE uop.gerencia = ''si'' AND  ';*/
        
        v_consulta:='SELECT count(uo.id_uo)
          FROM 
          ORGA.testructura_uo euo
          JOIN orga.tuo uo on euo.id_uo_hijo=uo.id_uo
          WHERE uo.estado_reg=''activo''  and';

        --Definicion de la respuesta
        v_consulta:=v_consulta || v_parametros.filtro;


        RAISE NOTICE '%', v_consulta;
        --Devuelve la respuesta
        RETURN v_consulta;


      END;

  ELSE

    RAISE EXCEPTION 'Transaccion inexistente';

  END IF;

  EXCEPTION

  WHEN OTHERS
    THEN
      v_resp = '';
      v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', SQLERRM);
      v_resp = pxp.f_agrega_clave(v_resp, 'codigo_error', SQLSTATE);
      v_resp = pxp.f_agrega_clave(v_resp, 'procedimientos', v_nombre_funcion);
      RAISE EXCEPTION '%', v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;