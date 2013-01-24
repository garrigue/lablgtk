(*
 * Xml Light, an small Xml parser/printer with DTD support.
 * Copyright (C) 2003 Nicolas Cannasse (ncannasse@motion-twin.com)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *)
  
open Xml

type parse_error_msg =
	| InvalidDTDDecl
	| InvalidDTDElement
	| InvalidDTDAttribute
	| InvalidDTDTag
	| DTDItemExpected

type check_error =
	| ElementDefinedTwice of string
	| AttributeDefinedTwice of string * string
	| ElementEmptyContructor of string
	| ElementReferenced of string * string
	| ElementNotDeclared of string

type prove_error =
	| UnexpectedPCData
	| UnexpectedTag of string
	| UnexpectedAttribute of string
	| InvalidAttributeValue of string
	| RequiredAttribute of string
	| ChildExpected of string
	| EmptyExpected

type dtd_child =
	| DTDTag of string
	| DTDPCData
	| DTDOptional of dtd_child
	| DTDZeroOrMore of dtd_child
	| DTDOneOrMore of dtd_child
	| DTDChoice of dtd_child list
	| DTDChildren of dtd_child list

type dtd_element_type =
	| DTDEmpty
	| DTDAny
	| DTDChild of dtd_child

type dtd_attr_default =
	| DTDDefault of string
	| DTDRequired
	| DTDImplied
	| DTDFixed of string

type dtd_attr_type =
	| DTDCData
	| DTDNMToken
	| DTDEnum of string list

type dtd_item =
	| DTDAttribute of string * string * dtd_attr_type * dtd_attr_default
	| DTDElement of string * dtd_element_type

type dtd_result =
	| DTDNext
	| DTDNotMatched
	| DTDMatched
	| DTDMatchedResult of dtd_child

type error_pos = {
	eline : int;
	eline_start : int;
	emin : int;
	emax : int;
}

type parse_error = parse_error_msg * Xml.error_pos

exception Parse_error of parse_error
exception Check_error of check_error
exception Prove_error of prove_error

type dtd = dtd_item list

type ('a,'b) hash = ('a,'b) Hashtbl.t

type checked = {
	c_elements : (string,dtd_element_type) hash;
	c_attribs : (string,(string,(dtd_attr_type * dtd_attr_default)) hash) hash;
}

type dtd_state = {
	elements : (string,dtd_element_type) hash;
	attribs : (string,(string,(dtd_attr_type * dtd_attr_default)) hash) hash;
	mutable current : dtd_element_type;
	mutable curtag : string;
	state : (string * dtd_element_type) Stack.t;
}
