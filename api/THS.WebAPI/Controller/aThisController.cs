
using System;
using System.Data.Entity;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Http;
using EHS.Models;
using WebAPI.Helper;
using NBear.Data;


namespace WebAPI.Controller
{

    [RoutePrefix("api/athiscontroller")]
    public class aThisController : ApiController
    {

        THUEXE_Entities db = new THUEXE_Entities();
        OperationResult thongbao = new OperationResult();
        Gateway mygatewate = new Gateway(0,new THUEXE_Entities().Database.Connection.ConnectionString);


        [Route("showHANGSX")]
        [HttpGet]
        
        public IHttpActionResult showHANGSX()
        {
            try
            {
                var result  = mygatewate.ExecuteStoredProcedure("showHANGSX", new string[] {}, new object[] {});
                //Dictionary<string, object> result = new Dictionary<string, object>();
                //result.Add("table1", x.Tables[0]);
                //result.Add("table2", x.Tables[1]);
                //var result = db.Database.ExecuteSqlCommand("showTTXE");

                return Ok(result.Tables[0]);
            }
            catch (Exception e)
            {
                return Ok(e.Message);
                throw new Exception(e.Message);
            }




        }


       




    }
}
