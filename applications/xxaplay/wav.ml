open Unix
(* open ThreadUnix *)

(* wave file *)

type header = {
    formatTag: int;
    nChannels: int;
    nSamplesPerSec: int;
    nAvgBytesPerSec: int;
    nBlockAlign: int;
    nBitsPerSample: int;
    totalSize: int 
  } 

let write_header fd header =
  let write_word i =
    let s = String.create 2 in
    s.[0] <- Char.chr (i mod 256);
    s.[1] <- Char.chr (i / 256);
    write fd s 0 2
  in
  let write_dword i =
    let s = String.create 4 in
    s.[0] <- Char.chr (i mod 256);
    s.[1] <- Char.chr (i / 256 mod 256);
    s.[2] <- Char.chr (i / 256 / 256 mod 256);
    s.[3] <- Char.chr (i / 256 / 256 / 256); (* Oops int is ok ? *)
    write fd s 0 4
  in
  (* move to the head *)
  lseek fd 0 SEEK_SET;
  write fd "RIFF" 0 4;
  write_dword ( 4 +     (* "WAVE" *)
		4 + 4 + (* "fmt " + size *)
		16 +    (* header (formatTag .. nBitsPerSample) *)
		4 + 4 + (* "data" + size *) 
                header.totalSize );

  write fd "WAVE" 0 4;

  write fd "fmt " 0 4;
  write_dword 16;
  write_word header.formatTag;
  write_word header.nChannels;
  write_dword header.nSamplesPerSec;
  write_dword header.nAvgBytesPerSec;
  write_word header.nBlockAlign;
  write_word header.nBitsPerSample;
  
  write fd "data" 0 4;
  write_dword header.totalSize
