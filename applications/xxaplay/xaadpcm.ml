(* header *)
(* sync - head  - sub - data - edc *) 
(* 12   - 4     - 8   - 2324 - 4   *)
(* ?    - msf+? - ?   - ?    - ?   *)

(* sub 0 1 2 3 4 5 6 7 *)
(* 0 = 01
   1 = channel
   2 = 0x64
   3 = 01
   4 = 01
   5 = channel
   6 = 0x64
   7 = see below *)

(* sub 7th - *) 
(*   0 stereo/mono *)   
(*   1 *)   
(*   2 *)   
(*   3 1:18900Hz??? 0:37800Hz ? *)   
(*   4 *)   
(*   5 *)   
(*   6 *)   
(*   7 *)   

let kNumOfSamples = 224
let kNumOfSGs = 18
 
let tR1 = ref 0.0
let tR2 = ref 0.0
let tL1 = ref 0.0
let tL2 = ref 0.0

let k0 = [| 0.0; 0.9375; 1.796875; 1.53125 |]
let k1 = [| 0.0; 0.0; -0.8125; -0.859375 |]

let getSoundData s sndgrp unit sample =
  let shift = (unit mod 2) * 4 in
  let offset = (24 + sndgrp * 128) + 16 + (unit / 2) + (sample * 4) in
  let ret = (Char.code s.[offset] lsr shift) land 0x0f in
  if ret > 7 then ret - 16 else ret

let getRangeFilter s sndgrp unit =
  let offset = (24 + sndgrp * 128) + 4 + unit in
  let v = Char.code s.[offset] in 
  v land 0x0f, v lsr 4 land 0x03
  
let init_decoder () =
  tR1 := 0.0;
  tR2 := 0.0;
  tL1 := 0.0;
  tL2 := 0.0

let decodeSector s =
  let buf = String.create 8064 in
  let pos = ref 0 in

  let write_word i =
    let i = if i < 0 then i + 0x10000 else i in
    buf.[!pos] <- Char.chr (i mod 256);
    incr pos;
    buf.[!pos] <- Char.chr (i / 256);
    incr pos
  in

  let count = ref 0 in
  for sndgrp = 0 to kNumOfSGs - 1 do
    for unit = 0 to 8 / 2 - 1 do
      let unitR = unit * 2 in
      let unitL = unit * 2 + 1 in
      let rangeR,filtR = getRangeFilter s sndgrp unitR in
      let rangeL,filtL = getRangeFilter s sndgrp unitL  in
      for sample = 0 to 28 - 1 do
	let snddat = getSoundData s sndgrp unitR sample in
	let tmp2 = float (snddat lsl (12 - rangeR)) in
	let tmp3 = tmp2 *. 2.0 
	and tmp4 = !tR1 *. k0.(filtR)
	and tmp5 = !tR2 *. k1.(filtR)
	in
	let t = tmp3 +. tmp4 +. tmp5 in
	tR2 := !tR1;
	tR1 := t;
	let t = t /. 2.0 in
	let decoded = 
	  if t > 32767.0 then 32767 
	  else if t < -32768.0 then -32768
	  else Pervasives.truncate t
	in
	write_word decoded;
	count := !count + 1;

	let snddat = getSoundData s sndgrp unitL sample in
	let tmp2 = float (snddat lsl (12 - rangeL)) in
	let tmp3 = tmp2 *. 2.0 
	and tmp4 = !tL1 *. k0.(filtL)
	and tmp5 = !tL2 *. k1.(filtL)
	in
	let t = tmp3 +. tmp4 +. tmp5 in
	tL2 := !tL1;
	tL1 := t;
	let t = t /. 2.0 in
	let decoded = 
	  if t > 32767.0 then 32767 
	  else if t < -32768.0 then -32768
	  else Pervasives.truncate t
	in
	write_word decoded;
	count := !count + 1;
      done
    done
  done;
  buf
;;
