#!/bin/bash
#https://www.pcre.org/ PC
Install_Pcre() {
    pushd ${ubdevenv_dir}/src > /dev/null
    dpkg -l|grep libpcre3-dev && apt-get autoremove -y libpcre3-dev
    if [ ! -e "/usr/bin/pcre-config" ]; then
        tar xzf pcre-${pcre_ver}.tar.gz
        pushd pcre-${pcre_ver} > /dev/null
        ./configure --prefix=/usr
        make -j ${THREAD} && make install
        popd > /dev/null
        rm -rf pcre-${pcre_ver}
    fi
    popd > /dev/null
}

Uninstall_Pcre() {
    pushd /usr/local/bin > /dev/null
    rm -fv pcretest pcregrep pcre-config
    popd > /dev/null

    pushd /usr/local/share/doc/pcre > /dev/null
    rm -fv pcre.txt pcre-config.txt pcregrep.txt pcretest.txt AUTHORS COPYING ChangeLog LICENCE NEWS README
    popd > /dev/null

    pushd /usr/local/share/doc/pcre/html > /dev/null
    rm -fv NON-AUTOTOOLS-BUILD.txt README.txt index.html pcre-config.html pcre.html pcre16.html pcre32.html pcre_assign_jit_stack.html pcre_compile.html pcre_compile2.html pcre_config.html pcre_copy_named_substring.html pcre_copy_substring.html pcre_dfa_exec.html pcre_exec.html pcre_free_study.html pcre_free_substring.html pcre_free_substring_list.html pcre_fullinfo.html pcre_get_named_substring.html pcre_get_stringnumber.html pcre_get_stringtable_entries.html pcre_get_substring.html pcre_get_substring_list.html pcre_jit_exec.html pcre_jit_stack_alloc.html pcre_jit_stack_free.html pcre_maketables.html pcre_pattern_to_host_byte_order.html pcre_refcount.html pcre_study.html pcre_utf16_to_host_byte_order.html pcre_utf32_to_host_byte_order.html pcre_version.html pcreapi.html pcrebuild.html pcrecallout.html pcrecompat.html pcredemo.html pcregrep.html pcrejit.html pcrelimits.html pcrematching.html pcrepartial.html pcrepattern.html pcreperform.html pcreposix.html pcreprecompile.html pcresample.html pcrestack.html pcresyntax.html pcretest.html pcreunicode.html pcrecpp.html
    popd > /dev/null

    pushd /usr/local/include > /dev/null
    rm -fv pcreposix.h pcrecpp.h pcre_scanner.h pcre.h pcrecpparg.h pcre_stringpiece.h
    popd > /dev/null

    pushd /usr/local/lib > /dev/null
    rm -fv libpcre.la libpcre.so.1.2.13 libpcre.so.1 libpcre.so libpcre.a libpcreposix.la libpcreposix.so.0.0.7 libpcreposix.so.0 libpcreposix.so libpcreposix.a libpcrecpp.la libpcrecpp.so.0.0.2 libpcrecpp.so.0 libpcrecpp.so libpcrecpp.a
    popd > /dev/null

    pushd /usr/local/share/man/man1 > /dev/null
    rm -fv pcre-config.1 pcregrep.1 pcretest.1
    popd > /dev/null

    pushd /usr/local/share/man/man3 > /dev/null
    rm -fv pcre.3 pcre16.3 pcre32.3 pcre_assign_jit_stack.3 pcre_compile.3 pcre_compile2.3 pcre_config.3 pcre_copy_named_substring.3 pcre_copy_substring.3 pcre_dfa_exec.3 pcre_exec.3 pcre_free_study.3 pcre_free_substring.3 pcre_free_substring_list.3 pcre_fullinfo.3 pcre_get_named_substring.3 pcre_get_stringnumber.3 pcre_get_stringtable_entries.3 pcre_get_substring.3 pcre_get_substring_list.3 pcre_jit_exec.3 pcre_jit_stack_alloc.3 pcre_jit_stack_free.3 pcre_maketables.3 pcre_pattern_to_host_byte_order.3 pcre_refcount.3 pcre_study.3 pcre_utf16_to_host_byte_order.3 pcre_utf32_to_host_byte_order.3 pcre_version.3 pcreapi.3 pcrebuild.3 pcrecallout.3 pcrecompat.3 pcredemo.3 pcrejit.3 pcrelimits.3 pcrematching.3 pcrepartial.3 pcrepattern.3 pcreperform.3 pcreposix.3 pcreprecompile.3 pcresample.3 pcrestack.3 pcresyntax.3 pcreunicode.3 pcrecpp.3
    popd > /dev/null

    pushd /usr/local/lib/pkgconfig > /dev/null
    rm -fv libpcre.pc libpcreposix.pc libpcrecpp.pc
    popd > /dev/null

    # pushd /usr/lib/x86_64-linux-gnu > /dev/null
    # rm -fv libpcrecpp.so libpcrecpp.pc libpcrecpp.so.0.0.1 libpcrecpp.a
    # popd > /dev/null
}