#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <linux/cdrom.h>
#include <linux/fs.h>

#include <caml/mlvalues.h>
#include <caml/alloc.h>

value read_raw_frame(vfd, vlba)
     value vfd;
     value vlba;
{
  int lba;
  struct  cdrom_msf *msf;
  char  buf[CD_FRAMESIZE_RAW];
  int    rc;
  value  ret;

  bzero(buf, CD_FRAMESIZE_RAW);
  lba = Int_val(vlba);
  msf =  (struct cdrom_msf*) buf;

  msf->cdmsf_min0   = (lba + CD_MSF_OFFSET) / CD_FRAMES / CD_SECS; 
  msf->cdmsf_sec0   = (lba + CD_MSF_OFFSET) / CD_FRAMES % CD_SECS;
  msf->cdmsf_frame0 = (lba + CD_MSF_OFFSET) % CD_FRAMES;
  rc = ioctl(Int_val(vfd), CDROMREADRAW, buf);
  if (-1 == rc) {
    fprintf(stderr, "error");
  }
  ret = alloc_string( CD_FRAMESIZE_RAW );
  bcopy( buf, String_val(ret), CD_FRAMESIZE_RAW );
  return ret;
}
