//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EHS.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class CHITIETTHUE
    {
        public string CTT_ID { get; set; }
        public string CTT_TGLX { get; set; }
        public string CTT_TGTX { get; set; }
        public Nullable<System.DateTime> CTT_NGAY { get; set; }
        public string CTT_TGTXTT { get; set; }
        public Nullable<int> CTT_TONGTIEN { get; set; }
        public Nullable<int> CTT_TIENNG { get; set; }
        public string NV_ID { get; set; }
        public string TTX_BSX { get; set; }
        public string KH_CMND { get; set; }
        public string DGQG_ID { get; set; }
    
        public virtual KHACHHANG KHACHHANG { get; set; }
        public virtual DONGIAQG DONGIAQG { get; set; }
        public virtual NHANVIEN NHANVIEN { get; set; }
        public virtual TTXE TTXE { get; set; }
    }
}
