
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

    [RoutePrefix("api/thiscontroller")]
    public class ThisController : ApiController
    {

        THUEXE_Entities db = new THUEXE_Entities();
        OperationResult thongbao = new OperationResult();
        Gateway mygatewate = new Gateway(0,new THUEXE_Entities().Database.Connection.ConnectionString);

        [Route("insertTTXE")]
        [HttpPost]
        public IHttpActionResult insertTTXE(TTXE entity)
        {
            try
            {

                var x = db.TTXEs.Add(entity);
                db.SaveChanges();
                thongbao.Success = true;
                thongbao.Message = "Thêm thông tin xe thành công";
                thongbao.Caption = "OK";
                return Ok(thongbao);
            }
            catch (Exception e)
            {
                thongbao.Success = false;
                thongbao.Message = "Không thể thêm tông tin xe";
                thongbao.Caption = "";
                return Ok(e.Message);
                throw new Exception(e.Message);
            }

        }


        [Route("showTTXE")]
        [HttpGet]
        
        public IHttpActionResult showTTXE()
        {
            try
            {
                var result  = mygatewate.ExecuteStoredProcedure("showTTXE", new string[] {}, new object[] {});
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


        [Route("updateTTXE")]
        [HttpPut]

        public IHttpActionResult updateTTXE(string TTX_BSX, string TTX_DONGIA)
        {
            try
            {
                var result = mygatewate.ExecuteStoredProcedure("updateTTXE", new string[] { "TTX_BSX", "TTX_DONGIA" }, new object[] { TTX_BSX, TTX_DONGIA });
                OperationResult thongbao = new OperationResult();

                thongbao.Success = true;
                thongbao.Message = "Cập nhật đơn giá thành công";
                thongbao.Caption = "OK";
                return Ok(thongbao);
            }
            catch (Exception e)
            {
                thongbao.Success = true;
                thongbao.Message = "Không thể cập hật đơn giá";
                thongbao.Caption = "OK";
                return Ok(thongbao);
                throw new Exception(e.Message);
            }

        }


        [Route("deleteTTXE")]
        [HttpDelete]

        public IHttpActionResult deleteTTXE(string TTX_BSX)
        {
            try
            {
                var result = mygatewate.ExecuteStoredProcedure("deleteTTXE", new string[] { "TTX_BSX" }, new object[] { TTX_BSX });
                OperationResult thongbao = new OperationResult();

                thongbao.Success = true;
                thongbao.Message = "Xóa thành công";
                thongbao.Caption = "OK";
                return Ok(thongbao);
            }
            catch (Exception e)
            {
                thongbao.Success = true;
                thongbao.Message = "Không thể xóa";
                thongbao.Caption = "OK";
                return Ok(thongbao);
                throw new Exception(e.Message);
            }

        }




    }
}
