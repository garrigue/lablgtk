/* $Id$ */

#define RegData_val(val) (Field(val,0))
#define RegPath_val(val) (Field(val,1))
#define RegOffset_val(val) (Long_val(Field(val,2)))
#define RegLength_val(val) (Long_val(Field(val,3)))

unsigned char* ml_gpointer_base (value region);
