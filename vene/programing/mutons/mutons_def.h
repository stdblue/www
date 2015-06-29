#pragma once

#include "boost/spirit/core.hpp"
#include "boost/spirit/utility.hpp"
#include "boost/spirit/actor.hpp"

#include "mutons_act.h"

using namespace boost::spirit;

namespace mutons
{

	struct mutons_grammar : grammar<mutons_grammar>
	{

		template<typename ScannerT>
			struct definition
			{
				typedef rule<ScannerT> rule_t;

				rule_t constants, operators, tokens;
				rule_t type_keywords, control_keywords, module_keywords;
				rule_t string_value, integer_value, real_value, numerical_value;
				rule_t integer_value_hex, integer_value_digit, integer_value_octet;
				rule_t identifier, qualified_identifier;

#pragma region Statement rule
				rule_t statement, statement_list;
				rule_t control_statements, functor_statements, expression_statement;
				rule_t if_functor_statement, switch_functor_statement;
				rule_t case_functor_statement, default_functor_statement;
				rule_t while_functor_statement, for_functor_statement;
				rule_t foreach_functor_statement, do_while_functor_statement;
				rule_t anonymous_functor_statement, named_functor_statement;
#pragma endregion

#pragma region Expression rule
				rule_t primary_expression, expression_list;
				rule_t postfix_expression, postfix_expression_helper;
				rule_t unary_expression, cast_expression, new_expression, delete_expression;
				rule_t multiplicative_expression, multiplicative_expression_helper;
				rule_t additive_expression, additive_expression_helper;
				rule_t message_expression, message_expression_helper;
				rule_t relational_expression, relational_expression_helper;
				rule_t equality_expression, equality_expression_helper;
				rule_t and_expression, and_expression_helper;
				rule_t exclusive_or_expression, exclusive_or_expression_helper;
				rule_t inclusive_or_expression, inclusive_or_expression_helper;
				rule_t logical_and_expression, logical_and_expression_helper;
				rule_t logical_or_expression, logical_or_expression_helper;
				rule_t conditional_expression, conditional_expression_helper;
				rule_t assignment_expression;
				rule_t expression, expression_helper;
#pragma endregion
			
				rule_t unary_operator, assignment_operator;

				definition( const mutons_grammar& )
				{

#pragma region トークン
					keywords
						=	"if", "switch", "case", "default",
							"while", "do", "for", "foreach",
							"integer", "real", "string", "array", "object", "functor", "accessor"
						;

					tokens
						=	type_keywords
						|	control_keywords
						;

					type_keywords
						=	strlit<>("integer")
						|	strlit<>("real")
						|	strlit<>("string")
						|	strlit<>("array")
						|	strlit<>("object")
						|	strlit<>("functor")
						|	strlit<>("accessor")
						;

					control_keywords
						=	strlit<>("if")
						|	strlit<>("switch")
						|	strlit<>("case")
						|	strlit<>("default")
						|	strlit<>("for")
						|	strlit<>("foreach")
						|	strlit<>("while")
						|	strlit<>("do")
						;

					module_keywords
						=	strlit<>("module")
						|	strlit<>("import")
						;
#pragma endregion

#pragma region 定数定義
					string_value
						= lexeme_d[
								ch_p('\"') >> *( strlit<>("\\\"") | anychar_p - ch_p('\"') ) >> ch_p('"')
							]
						;

					integer_value
						=	integer_value_octet
						|	integer_value_digit
						|	integer_value_hex
						;

					integer_value_octet
						=	lexeme_d[
								ch_p('0') >> +( range<>('0', '7') | chlit<>('_') )
							]
						;

					integer_value_digit
						=	lexeme_d[
								( digit_p - ch_p('0') ) >> *( !ch_p('_') >> digit_p )
							|	chlit<>('0')
							]
						;

					integer_value_hex
						=	ch_p('0') >> as_lower_d[chlit<>('x')] >> +( xdigit_p >> !ch_p('_') )
						;

					real_value
						=	!sign_p >> !ch_p('0') >> ch_p('.') >> *( !ch_p('_') >> digit_p )
						|	!sign_p >> ( digit_p - ch_p('0') >> *( !ch_p('_') >> digit_p ) ) >> ch_p('.') >> *( !ch_p('_') >> digit_p )
						;

					numerical_value
						=	longest_d[ integer_value | real_value ];

					constants
						=	numerical_value
						|	string_value
						;
#pragma endregion

#pragma region 識別子定義
					identifier
						= lexeme_d[
								(
									(
										graph_p - sign_p - space_p
										- ch_p(';')
										- '*' - '/' - '%' - '&' - '|' - '=' - '~' - '^'
										- '\"' - '\'' - '.' - ',' - '!' - ':' - '\\' - '#'
										- '(' - ')' - '[' - ']' - '{' - '}' - '<' - '>'
									)
									>> *(
										graph_p - sign_p - space_p
										- ch_p(';')
										- '*' - '/' - '%' - '&' - '|' - '=' - '~' - '^'
										- '\"' - '\'' - '.' - ',' - '!' - ':' - '\\' - '#' - '$'
										- '(' - ')' - '[' - ']' - '{' - '}' - '<' - '>'
									)
								)
								- keywords
							]
							- constants
						;

					qualified_identifier
						=	identifier >> !( ch_p('.') >> qualified_identifier )
						;
#pragma endregion

#pragma region 演算子定義
					unary_operator
						=	( ch_p('+') | ch_p('-') | ch_p('!') | ch_p('~') )
						;

					assignment_operator
						=	( ch_p('=')
							| str_p("+=") | str_p("-=")
							| str_p("*=") | str_p("/=") | str_p("%=")
							| str_p("^=") | str_p("|=")
							)
						;
#pragma endregion

#pragma region 演算定義
					primary_expression
						=	qualified_identifier
						|	constants
						|	( ch_p('(') >> expression >> ch_p(')') )
						;

					postfix_expression
						=	primary_expression >> postfix_expression_helper
						;

					postfix_expression_helper
						=	(	ch_p('[') >> expression >> ch_p(']')
							|	ch_p('(') >> !expression_list >> ch_p(')')
							|	str_p("++")
							|	str_p("--")
							) >> postfix_expression_helper
						|	epsilon_p
						;

					expression_list
						=	assignment_expression >> *( ch_p(',') >> assignment_expression )
						;

					unary_expression
						=	postfix_expression
						|	str_p("++") >> unary_expression
						|	str_p("--") >> unary_expression
						|	unary_operator >> cast_expression
						|	new_expression
						|	delete_expression
						;

					new_expression
						=	str_p("new") >> qualified_identifier >> !( ch_p('(') >> expression_list >> ch_p(')') )
							>> !( ch_p(':') >> qualified_identifier >> *( ch_p(',') >> qualified_identifier ) )
						;

					delete_expression
						=	str_p("delete") >> qualified_identifier
						;

					cast_expression
						=	ch_p('(') >> ( type_keywords | qualified_identifier ) >> ch_p(')') >> cast_expression
						|	unary_expression
						;

					multiplicative_expression
						=	cast_expression >> multiplicative_expression_helper
						;

					multiplicative_expression_helper
						=	(	ch_p('*') >> cast_expression
							|	ch_p('/') >> cast_expression
							|	ch_p('%') >> cast_expression
							) >> multiplicative_expression_helper
						| epsilon_p
						;

					additive_expression
						=	multiplicative_expression >> additive_expression_helper
						;

					additive_expression_helper
						=	(	ch_p('+') >> multiplicative_expression
							|	ch_p('-') >> multiplicative_expression
							) >> additive_expression_helper
						| epsilon_p
						;

					message_expression
						=	additive_expression >> message_expression_helper
						;

					message_expression_helper
						=	(	str_p("<-") >> additive_expression
							|	str_p("->") >> additive_expression
							) >> message_expression_helper
						|	epsilon_p
						;

					relational_expression
						=	message_expression >> relational_expression_helper
						;

					relational_expression_helper
						=	(	ch_p('<')	>> message_expression
							|	ch_p('>')	>> message_expression
							|	str_p("<=")	>> message_expression
							|	str_p(">=")	>> message_expression
							) >> relational_expression_helper
						|	epsilon_p
						;

					equality_expression
						=	relational_expression >> equality_expression_helper
						;

					equality_expression_helper
						=	(	str_p("==") >> relational_expression 
							|	str_p("!=") >> relational_expression
							) >> equality_expression_helper
						|	epsilon_p
						;

					and_expression
						=	equality_expression >> and_expression_helper
						;

					and_expression_helper
						=	ch_p('&') >> equality_expression >> and_expression_helper
						|	epsilon_p
						;

					exclusive_or_expression
						=	and_expression >> exclusive_or_expression_helper
						;

					exclusive_or_expression_helper
						=	ch_p('^') >> and_expression >> exclusive_or_expression_helper
						|	epsilon_p
						;

					inclusive_or_expression
						=	exclusive_or_expression >> inclusive_or_expression_helper
						;

					inclusive_or_expression_helper
						= ch_p('|') >> exclusive_or_expression >> inclusive_or_expression_helper
						|	epsilon_p
						;

					logical_and_expression
						=	inclusive_or_expression >> logical_and_expression_helper
						;

					logical_and_expression_helper
						=	str_p("&&") >> inclusive_or_expression >> logical_and_expression_helper
						|	epsilon_p
						;

					logical_or_expression
						=	logical_and_expression >> logical_or_expression_helper
						;

					logical_or_expression_helper
						=	str_p("||") >> logical_and_expression >> logical_or_expression_helper
						|	epsilon_p
						;

					conditional_expression
						=	logical_or_expression >> conditional_expression_helper
						;

					conditional_expression_helper
						=  ch_p('?') >> expression >> ch_p(':') >> conditional_expression >> conditional_expression_helper
						|	epsilon_p
						;

					assignment_expression
						=	logical_or_expression >> assignment_operator >> assignment_expression
						|	conditional_expression
						;

					expression
						=	assignment_expression >> expression_helper
						;

					expression_helper
						=	ch_p(',') >> assignment_expression >> expression_helper
						|	epsilon_p
						;

#pragma endregion

#pragma region 構文定義
					expression_statement
						=	!expression >> ch_p(';')
						;

					control_statements
						=	if_functor_statement
						|	switch_functor_statement
						|	while_functor_statement
						|	for_functor_statement
						|	foreach_functor_statement
						|	do_while_functor_statement
						;

					functor_statements
						=	anonymous_functor_statement
						|	named_functor_statement
						;

					anonymous_functor_statement
						=	statement
						|	ch_p('{') >> statement_list >> ch_p('}')
						;

					named_functor_statement
						=	qualified_identifier >> !( ch_p('(') >> !expression_list >> ch_p(')') ) >> ch_p(';')
						;

					if_functor_statement
						=	str_p("if") >> ch_p('(') >> expression >> ch_p(')') >> functor_statements
							>> !( str_p("else") >> functor_statements )
						;

					switch_functor_statement
						=	str_p("switch") >> ch_p('(') >> expression >> ch_p(')')
							>> ch_p('{')
							>> *case_functor_statement
							>> !default_functor_statement
							>> ch_p('}')
						;

					case_functor_statement
						=	str_p("case") >> constants >> functor_statements
						;

					default_functor_statement
						=	str_p("default") >> functor_statements
						;

					while_functor_statement
						=	str_p("while") >> ch_p('(') >> expression >> ch_p(')') >> functor_statements
						;

					for_functor_statement
						=	str_p("for") >> ch_p('(')
							>> expression_statement >> expression_statement >> expression_statement
							>> ch_p(')') >> functor_statements
						;

					foreach_functor_statement
						=	str_p("foreach") >> ch_p('(') >> expression >> ch_p(')') >> functor_statements
						;

					do_while_functor_statement
						=	str_p("do") >> functor_statements >> str_p("while")
							>> ch_p('(') >> expression >> ch_p(')') >> ch_p(';')
						;
/*

					block_statement
						= ch_p('{') >> ( *line_statement | *block_statement ) >> ch_p('}')
						;

					statement
						=	* ( constants [&(mutons::actions::show_constants)]
							|	type_keywords [&(mutons::actions::show_keywords)]
							|	operators [&(mutons::actions::occur_operators)]
							|	qualified_identifier [&(mutons::actions::set_identifier)]
							)
						;
*/

					statement
						=	expression_statement
						|	control_statements
						|	functor_statements
						;

					statement_list
						= *statement
						;
#pragma endregion
				}

				symbols<> keywords;

				const rule_t& start() const {	return statement_list;	}
			};
	};
}
