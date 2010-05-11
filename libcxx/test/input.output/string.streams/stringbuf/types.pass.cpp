//===----------------------------------------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

// <sstream>

// template <class charT, class traits = char_traits<charT>, class Allocator = allocator<charT> >
// class basic_stringbuf
//     : public basic_streambuf<charT, traits>
// {
// public:
//     typedef charT                          char_type;
//     typedef traits                         traits_type;
//     typedef typename traits_type::int_type int_type;
//     typedef typename traits_type::pos_type pos_type;
//     typedef typename traits_type::off_type off_type;
//     typedef Allocator                      allocator_type;

#include <sstream>
#include <type_traits>

int main()
{
    static_assert((std::is_base_of<std::basic_streambuf<char>, std::basic_stringbuf<char> >::value), "");
    static_assert((std::is_same<std::basic_stringbuf<char>::char_type, char>::value), "");
    static_assert((std::is_same<std::basic_stringbuf<char>::traits_type, std::char_traits<char> >::value), "");
    static_assert((std::is_same<std::basic_stringbuf<char>::int_type, std::char_traits<char>::int_type>::value), "");
    static_assert((std::is_same<std::basic_stringbuf<char>::pos_type, std::char_traits<char>::pos_type>::value), "");
    static_assert((std::is_same<std::basic_stringbuf<char>::off_type, std::char_traits<char>::off_type>::value), "");
    static_assert((std::is_same<std::basic_stringbuf<char>::allocator_type, std::allocator<char> >::value), "");
}
