#include <stdio.h>
#include <fcntl.h>
#include <linux/soundcard.h>

#include <caml/mlvalues.h>
#include <caml/callback.h>

value *dsp_error = NULL;

value dsp_init(v)
     value v;
{
  if( dsp_error == NULL)
    dsp_error = caml_named_value("dsp_error");
}

value dsp_get_block_size( fd )
     value fd;
{
  int blksiz;
  if ( ioctl(Int_val(fd), SNDCTL_DSP_GETBLKSIZE, &blksiz) < 0 ){
    raise_with_string(*dsp_error, "failed to get blocksize");
  }
  return Val_int( blksiz );
}

value dsp_set_sample_size( fd, sample )
     value fd; 
     value sample;
{
  int t;
  t = Int_val(sample); 
  if ( ioctl(Int_val(fd),SNDCTL_DSP_SAMPLESIZE,&t) < 0 ) {
    raise_with_string(*dsp_error, "failed to set sample size");
  }
  return Val_unit;
}

value dsp_set_stereo( fd, stereo )
     value fd;
     value stereo;
{
  int t;
  t = Int_val( stereo );
  if ( ioctl(Int_val(fd),SNDCTL_DSP_STEREO,&t) < 0 ) {
    raise_with_string(*dsp_error, "failed to set mono/stereo");
  }		
  return Val_unit;
}

value dsp_set_speed( fd, speed )
     value fd;
     value speed;
{
  /* SamplingRate */
  int t;
  t = Int_val( speed );
  if ( ioctl(Int_val(fd),SNDCTL_DSP_SPEED,&t) < 0 ) {
    raise_with_string(*dsp_error, "failed to set speed");
  }
  return Val_unit;
}

value dsp_sync( fd )
     value fd;
{
  if ( ioctl(fd, SNDCTL_DSP_SYNC,0) != 0 ){
    raise_with_string(*dsp_error, "failed to sync");
  }
  return Val_unit;
}
